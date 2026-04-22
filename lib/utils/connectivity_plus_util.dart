import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

import 'file_logger_util.dart';

class ConnectivityPlusUtil extends ChangeNotifier {
  // 私有静态实例变量
  static ConnectivityPlusUtil? _instance;

  // 私有构造函数
  ConnectivityPlusUtil._();

  // 静态工厂方法获取单例实例
  factory ConnectivityPlusUtil() {
    _instance ??= ConnectivityPlusUtil._();
    return _instance!;
  }

  List<ConnectivityResult> _connectivityResult = [];
  List<ConnectivityResult> get connectivityResult => _connectivityResult;
  bool get hasNetwork => !_connectivityResult.contains(ConnectivityResult.none);

  init() {
    Connectivity().checkConnectivity().then((value) {
      _connectivityResult = value;
      FileLoggerUtil().log('网络检查结果: $value');
    });
    Connectivity().onConnectivityChanged.listen((value) {
      FileLoggerUtil().log('网络状态变化: $value');
      _connectivityResult = value;
      notifyListeners();
    });
  }
}
