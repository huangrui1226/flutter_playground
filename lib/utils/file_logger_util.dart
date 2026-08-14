import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

/*
初始化方法
Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await FileLoggerUtil().init();
      runApp(const MyApp());
    },
    (error, stack) {
      FileLoggerUtil().logUncaughtError(error, stack);
    },
  );
}
 */
class FileLoggerUtil {
  // 私有静态实例变量
  static FileLoggerUtil? _instance;

  // 私有构造函数
  FileLoggerUtil._();

  // 静态工厂方法获取单例实例
  factory FileLoggerUtil() {
    _instance ??= FileLoggerUtil._();
    return _instance!;
  }

  late final String _launchTimestamp; // 启动时间戳（用于文件名）
  File? _file;
  IOSink? _sink;
  bool _initialized = false;

  // 串行队列
  final _queue = StreamController<String>(sync: true);
  late final StreamSubscription<void> _sub;

  // 可选：暴露当前日志文件路径
  String? get currentLogPath => _file?.path;

  /// 在应用启动时调用（如 main 中）
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    _launchTimestamp = _formatTimestamp(DateTime.now()); // yyyy-MM-dd-HH-mm-ss

    final dir = await getApplicationDocumentsDirectory();
    final logsDir = Directory('${dir.path}/logs');
    if (!await logsDir.exists()) {
      await logsDir.create(recursive: true);
    }

    _file = File('${logsDir.path}/$_launchTimestamp.txt');
    _sink = _file!.openWrite(mode: FileMode.append);

    // 自动清理超过 7 天的旧日志文件
    _cleanOldLogs(logsDir);

    // 串行消费写入
    _sub = _queue.stream
        .asyncMap((line) async {
          _sink?.writeln(line);
          await _sink?.flush();
        })
        .listen(null);

    // 捕获 Flutter 框架内的异常（如 build/layout/paint 阶段）
    hookFlutterErrors();

    // 捕获 PlatformDispatcher 级别未处理的异常（兜底）
    PlatformDispatcher.instance.onError = (error, stack) {
      logUncaughtError(error, stack);
      return true;
    };

    await _logAppInfo();
  }

  /// 记录一条日志（线程安全/串行写）
  void log(String message, {String tag = 'APP'}) {
    debugPrint(message);
    if (!_initialized) return;
    final ts = _formatLineTime(DateTime.now()); // HH:mm:ss.SSS
    _queue.add('[$ts][$tag] $message');
  }

  /// 捕获 Flutter 框架异常
  void hookFlutterErrors() {
    FlutterError.onError = (details) {
      _logCrashSync(
        'FlutterError: ${details.exceptionAsString()}\n${details.stack}',
      );
    };
  }

  /// 记录未捕获的 Zone 异常（供 runZonedGuarded onError 调用）
  void logUncaughtError(Object error, StackTrace stack) {
    _logCrashSync('UncaughtError: $error\n$stack');
  }

  /// 只保留最新的日志文件，其他的删除
  Future<void> keepLatestLog() async {
    if (currentLogPath == null) {
      return;
    }
    final logsDir = Directory(currentLogPath!);
    try {
      final entities = await logsDir.list().toList();
      final logFiles = <File>[];
      for (final entity in entities) {
        if (entity is File && entity.path.endsWith('.txt')) {
          logFiles.add(entity);
        }
      }
      if (logFiles.length <= 1) return;

      logFiles.sort((a, b) {
        final aStat = a.statSync().modified;
        final bStat = b.statSync().modified;
        return bStat.compareTo(aStat);
      });

      final latestPath = _file?.path ?? logFiles.first.path;
      for (final file in logFiles) {
        if (file.path == latestPath) continue;
        try {
          await file.delete();
          debugPrint(
            '[AppFileLogger] 已删除旧日志: ${file.path.split('/').last}',
          );
        } catch (e) {
          debugPrint('[AppFileLogger] 删除日志失败: ${file.path} -> $e');
        }
      }
    } catch (e) {
      debugPrint('[AppFileLogger] 保留最新日志失败: $e');
    }
  }

  /// 同步写入崩溃日志，确保 app 终止前数据落盘
  void _logCrashSync(String message) {
    debugPrint(message);
    if (!_initialized || _file == null) return;
    final ts = _formatLineTime(DateTime.now());
    _file!.writeAsStringSync(
      '[$ts][CRASH] $message\n',
      mode: FileMode.append,
      flush: true,
    );
  }

  /// 关闭（应用退出时调用）
  Future<void> dispose() async {
    if (!_initialized) return;
    await _queue.close();
    await _sub.cancel();
    await _sink?.flush();
    await _sink?.close();
    _sink = null;
    _initialized = false;
  }

  /// 清理超过 3 天的旧日志文件
  Future<void> _cleanOldLogs(Directory logsDir) async {
    try {
      final threshold = DateTime.now().subtract(const Duration(days: 3));
      final entities = await logsDir.list().toList();
      for (final entity in entities) {
        if (entity is File &&
            entity.path.endsWith('.txt') &&
            entity.path != _file?.path) {
          final stat = await entity.stat();
          if (stat.modified.isBefore(threshold)) {
            await entity.delete();
            debugPrint(
              '[AppFileLogger] 已删除过期日志: ${entity.path.split('/').last}',
            );
          }
        }
      }
    } catch (e) {
      debugPrint('[AppFileLogger] 清理旧日志失败: $e');
    }
  }

  // --- 工具方法 ---

  Future<void> _logAppInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      log(
        'AppName: ${info.appName}\n'
        'PackageName: ${info.packageName}\n'
        'Version: ${info.version}\n'
        'BuildNumber: ${info.buildNumber}',
        tag: 'APP_INFO',
      );
    } catch (error, stack) {
      log(
        '读取 App 基本信息失败: $error\n$stack',
        tag: 'APP_INFO',
      );
    }
  }

  String _formatTimestamp(DateTime dt) {
    // yyyy-MM-dd-HH-mm-ss
    final y = dt.year.toString().padLeft(4, '0');
    final M = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return '$y-$M-$d-$h-$m-$s';
    // 注意：文件名用小写 hh（需求里是 HH，24h 已满足）
  }

  String _formatLineTime(DateTime dt) {
    // yyyy-MM-dd-HH-mm-ss
    final y = dt.year.toString().padLeft(4, '0');
    final M = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return '$y-$M-$d $h:$m:$s';
  }
}
