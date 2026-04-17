import 'dart:async';

import 'package:flutter/material.dart';
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
      FileLoggerUtil().logUncaughtError(error, stack);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
