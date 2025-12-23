import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class FlutterBluePlusPage extends StatefulWidget {
  const FlutterBluePlusPage({super.key});

  @override
  State<FlutterBluePlusPage> createState() => _FlutterBluePlusPageState();
}

class _FlutterBluePlusPageState extends State<FlutterBluePlusPage> {
  bool? isSupported;
  List<ScanResult> scanResult = [];
  StreamSubscription? scanSubscription;
  StreamSubscription? adapterStateSubscription;
  BluetoothAdapterState state = BluetoothAdapterState.unknown;

  @override
  void initState() {
    super.initState();
    _checkSupported();
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    scanSubscription?.cancel();
    adapterStateSubscription?.cancel();
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
      builder:
          (
            BuildContext context,
            AsyncSnapshot<BluetoothAdapterState> snapshot,
          ) {
            if (!snapshot.hasData) {
              return _loadingView();
            }
            final state = snapshot.data;
            if (state == null) {}
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      FilledButton.tonal(
                        onPressed: _onStartScanTap,
                        child: Text('开始扫描'),
                      ),
                      FilledButton.tonal(
                        onPressed: _onOpenSettingTap,
                        child: Text('打开设置'),
                      ),
                      FilledButton.tonal(
                        onPressed: _onRequestBluetooth,
                        child: Text('获取蓝牙权限'),
                      ),
                    ],
                  ),
                  Text("device count: ${scanResult.length}"),
                  Text("bluetooth adapter state: $state"),
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
            crossAxisAlignment: CrossAxisAlignment.start,
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

  void _onOpenSettingTap() {
    AppSettings.openAppSettings(type: AppSettingsType.bluetooth);
  }

  void _onRequestBluetooth() {
    Permission.bluetooth.request();
  }

  Future<void> _onStartScanTap() async {
    scanSubscription = FlutterBluePlus.scanResults.listen(
      _handleScanResult,
      onError: _handleScanError,
    );
    FlutterBluePlus.cancelWhenScanComplete(
      scanSubscription!,
    );
    try {
      FlutterBluePlus.startScan(
        timeout: Duration(seconds: 5),
      );
    } catch (e) {
      debugPrint('startScan error: $e');
    }
  }

  Future<void> _checkSupported() async {
    final value = await FlutterBluePlus.isSupported;
    isSupported = value;
    debugPrint('isSupported = $isSupported');
    setState(() {});

    if (isSupported == true || true) {
      state = FlutterBluePlus.adapterStateNow;
      debugPrint('state = $state');
      setState(() {});
      _listenStateChange();
    }
  }

  Future<void> _listenStateChange() async {
    adapterStateSubscription = FlutterBluePlus.adapterState.listen(
      _handleBluetoothAdapterStateChanged,
    );
  }

  void _handleBluetoothAdapterStateChanged(BluetoothAdapterState value) {
    if (state == value) {
      return;
    }
    state = value;
    debugPrint('state = $state');
    switch (value) {
      case BluetoothAdapterState.unknown:
      case BluetoothAdapterState.unavailable:
      case BluetoothAdapterState.unauthorized:
      case BluetoothAdapterState.turningOn:
      case BluetoothAdapterState.on:
      case BluetoothAdapterState.turningOff:
      case BluetoothAdapterState.off:
    }
    setState(() {});
  }

  void _handleScanResult(List<ScanResult> result) {
    scanResult = result;
    setState(() {});
  }

  void _handleScanError(scanError) {
    debugPrint('scan error: $scanError');
  }
}
