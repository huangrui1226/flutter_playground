import 'package:flutter/material.dart';
import 'package:flutter_playground/pages/third_party/audio_wave_page.dart';
import 'package:flutter_playground/pages/third_party/flutter_blue_plus_page.dart';
import 'package:flutter_playground/pages/third_party/get_page.dart';
import 'package:flutter_playground/pages/third_party/screenshot_page.dart';

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
        itemCount: 5,
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
      default:
        return ListTile();
    }
  }
}
