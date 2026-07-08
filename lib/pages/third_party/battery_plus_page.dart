import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryPlusPage extends StatefulWidget {
  const BatteryPlusPage({super.key});

  @override
  State<BatteryPlusPage> createState() => _BatteryPlusPageState();
}

class _BatteryPlusPageState extends State<BatteryPlusPage> {
  final Battery _battery = Battery();

  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    _battery.batteryState.then(_updateBatteryState);
    _batteryStateSubscription = _battery.onBatteryStateChanged.listen(_updateBatteryState);
  }

  void _updateBatteryState(BatteryState state) {
    if (_batteryState == state) return;
    setState(() {
      _batteryState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery plus example app'),
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Current battery state:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(
              '${_batteryState?.name}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _battery.batteryLevel.then(
                  (batteryLevel) {
                    if (context.mounted) {
                      showDialog<void>(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: Text('Battery: $batteryLevel%'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
              child: const Text('Get battery level'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _battery.isInBatterySaveMode.then(
                  (isInPowerSaveMode) {
                    if (context.mounted) {
                      showDialog<void>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text(
                            'Is in Battery Save mode?',
                            style: TextStyle(fontSize: 20),
                          ),
                          content: Text(
                            "$isInPowerSaveMode",
                            style: const TextStyle(fontSize: 18),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
              child: const Text('Is in Battery Save mode?'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription!.cancel();
    }
  }
}
