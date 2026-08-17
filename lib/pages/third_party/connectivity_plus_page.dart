import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:material_ui/material_ui.dart';

class ConnectivityPlusPage extends StatefulWidget {
  const ConnectivityPlusPage({super.key});

  @override
  State<ConnectivityPlusPage> createState() => _ConnectivityPlusPageState();
}

class _ConnectivityPlusPageState extends State<ConnectivityPlusPage> {
  List<ConnectivityResult> _connectivityResult = [];
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  List<ConnectivityResult> _streamConnectivityResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("connectivity_plus"),
      ),
      body: SafeArea(
        child: Container(
          padding: .all(8),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  TextButton(
                    child: Text("Get result"),
                    onPressed: () async {
                      final result = await Connectivity().checkConnectivity();
                      _connectivityResult = result;
                      setState(() {});
                    },
                  ),
                  Text("$_connectivityResult"),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    child: Text("Listen"),
                    onPressed: () async {
                      _connectivitySubscription = Connectivity().onConnectivityChanged.listen((event) {
                        _streamConnectivityResult = event;
                        setState(() {});
                      });
                    },
                  ),
                  Text('$_streamConnectivityResult'),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    child: Text("Cancel Listen"),
                    onPressed: () async {
                      _connectivitySubscription?.cancel();
                    },
                  ),
                ],
              ),
              Text('Bug #1'),
              Text('进入页面依次点击【Get result】【Listen】【Cancel Listen】【Get result】按钮，会出现 none 状态'),
            ],
          ),
        ),
      ),
    );
  }
}
