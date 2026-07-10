import 'dart:async';

import 'package:display_metrics/display_metrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_playground/pages/home_page.dart';
import 'package:flutter_playground/utils/file_logger_util.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await FileLoggerUtil().init();
      runApp(const MyApp());
    },
    (error, stack) {
      FileLoggerUtil().logUncaughtError(error, stack);afdfd
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DisplayMetricsWidget(
      child: MaterialApp(
        home: HomePage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
