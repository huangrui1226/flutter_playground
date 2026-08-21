import 'dart:async';

import 'package:display_metrics/display_metrics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_playground/pages/home_page.dart';
import 'package:flutter_playground/utils/file_logger_util.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      if (!kIsWeb) {
        await FileLoggerUtil().init();
      }
      const env = String.fromEnvironment("env");
      if (env == 'production') {
        await SentryFlutter.init(
          (options) {
            options.dsn = 'https://a4789d0beb49453a0ccb5fb618bc59af@o4510661938642944.ingest.us.sentry.io/4511908428709888';
            // Adds request headers and IP for users, for more info visit:
            // https://docs.sentry.io/platforms/dart/guides/flutter/data-management/data-collected/
            options.sendDefaultPii = true;
            options.enableLogs = true;
            // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
            // We recommend adjusting this value in production.
            options.tracesSampleRate = 1.0;
            // The sampling rate for profiling is relative to tracesSampleRate
            // Setting to 1.0 will profile 100% of sampled transactions:
            options.profilesSampleRate = 1.0;
            // Configure Session Replay
            options.replay.sessionSampleRate = 0.1;
            options.replay.onErrorSampleRate = 1.0;
          },
          appRunner: () => runApp(SentryWidget(child: const MyApp())),
        );
      } else {
        runApp(MyApp());
      }
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
    return DisplayMetricsWidget(
      child: MaterialApp(
        home: HomePage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
