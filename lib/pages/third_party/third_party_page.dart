import 'package:flutter/material.dart';

import 'audio_wave/audio_wave_page.dart';
import 'battery_plus_page.dart';
import 'connectivity_plus_page.dart';
import 'display_metrics_page.dart';
import 'flutter_blue_plus_page.dart';
import 'flutter_easyloading/flutter_easyloading_page.dart';
import 'flutter_inappwebview_page.dart';
import 'get_page.dart';
import 'screenshot_page.dart';

class ThirdPartyPage extends StatelessWidget {
  const ThirdPartyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Party'),
      ),
      body: ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: 9,
      ),
    );
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    switch (index) {
      case 0:
        return ListTile(
          title: Text('Audio wave'),
          onTap: () {
            final destination = AudioWavePage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      case 1:
        return ListTile(
          title: Text('Screenshot'),
          onTap: () {
            final destination = ScreenshotPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      case 2:
        return ListTile(
          title: Text('Get'),
          onTap: () {
            final destination = GetPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      case 3:
        return ListTile(
          title: Text('flutter_blue_plus'),
          onTap: () {
            final destination = FlutterBluePlusPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      case 4:
        return ListTile(
          title: Text('connectivity_plus'),
          onTap: () {
            final destination = ConnectivityPlusPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      case 5:
        return ListTile(
          title: Text('flutter_inappwebview'),
          onTap: () {
            final destination = FlutterInappwebviewPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      case 6:
        return ListTile(
          title: Text('display_metrics'),
          onTap: () {
            final destination = DisplayMetricsPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      case 7:
        return ListTile(
          title: Text('flutter_easyloading'),
          onTap: () {
            final destination = FlutterEasyloadingPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      case 8:
        return ListTile(
          title: Text('battery_plus'),
          onTap: () {
            final destination = BatteryPlusPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      default:
        return ListTile();
    }
  }
}
