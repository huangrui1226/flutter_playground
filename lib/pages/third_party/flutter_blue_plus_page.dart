import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class FlutterBluePlusPage extends StatefulWidget {
  const FlutterBluePlusPage({super.key});

  @override
  State<FlutterBluePlusPage> createState() => _FlutterBluePlusPageState();
}

class _FlutterBluePlusPageState extends State<FlutterBluePlusPage> {
  bool? isSupported;
  List<ScanResult> scanResult = [];
  StreamSubscription? scanSubscription;

  @override
  void initState() {
    super.initState();
    checkSupported();
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    scanSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Blue Plus'),
      ),
      body: Builder(
        builder: (context) {
          if (isSupported == null) {
            return _loadingView();
          } else {
            return isSupported! ? _supportedView() : _unsupportedView();
          }
        },
      ),
    );
  }

  Widget _loadingView() {
    return Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget _unsupportedView() {
    return Center(
      child: Text('蓝牙不可用'),
    );
  }

  Widget _supportedView() {
    return StreamBuilder(
      stream: FlutterBluePlus.adapterState,
      builder: (BuildContext context, AsyncSnapshot<BluetoothAdapterState> snapshot) {
        if (!snapshot.hasData) {
          return _loadingView();
        }
        final state = snapshot.data;
        if (state == null) {

        }
        return Padding(
          padding: .all(8),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Wrap(
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      scanSubscription = FlutterBluePlus.scanResults.listen(
                        (value) {
                          setState(() {
                            scanResult = value;
                          });
                        },
                        onError: (scanError) {
                          debugPrint('scan error: $scanError');
                        },
                      );
                      FlutterBluePlus.cancelWhenScanComplete(scanSubscription!);
                      FlutterBluePlus.startScan(
                        timeout: Duration(seconds: 5),
                      );
                    },
                    child: Text('开始扫描'),
                  ),
                ],
              ),
              Text("device count: ${scanResult.length}"),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, _) => Divider(),
                  itemBuilder: _itemBuilder,
                  itemCount: scanResult.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final result = scanResult[index];
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(result.device.remoteId.str),
              Text(result.device.toString()),
              Text(result.advertisementData.toString()),
              Text(result.rssi.toString()),
              Text(result.timeStamp.toString()),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {
            if (result.device.isConnected) {
              result.device.disconnect();
            } else {}
          },
          child: result.device.isConnected ? Text("Disconnect") : Text("Connect"),
        ),
      ],
    );
  }

  Future<void> checkSupported() async {
    final value = await FlutterBluePlus.isSupported;
    setState(() {
      isSupported = value;
    });
  }
}
