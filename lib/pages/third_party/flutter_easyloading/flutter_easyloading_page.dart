import 'package:flutter/material.dart';
import 'package:flutter_playground/utils/toast_util.dart';

class FlutterEasyloadingPage extends StatefulWidget {
  const FlutterEasyloadingPage({super.key});

  @override
  State<FlutterEasyloadingPage> createState() => _FlutterEasyloadingPageState();
}

class _FlutterEasyloadingPageState extends State<FlutterEasyloadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter_easyloading"),
      ),
      body: Column(
        mainAxisSize: .min,
        children: [
          TextButton(
            onPressed: () {
              ToastUtil().show();
            },
            child: Text("Show Toast"),
          ),
          TextButton(
            onPressed: () {
              ToastUtil().hide();
            },
            child: Text("Hide Toast"),
          ),
        ],
      ),
    );
  }
}
