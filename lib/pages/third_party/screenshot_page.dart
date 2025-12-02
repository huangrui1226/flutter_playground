import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class ScreenshotPage extends StatefulWidget {
  const ScreenshotPage({super.key});

  @override
  State<ScreenshotPage> createState() => _ScreenshotPageState();
}

class _ScreenshotPageState extends State<ScreenshotPage> {
  final controller = ScreenshotController();
  Uint8List? imageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screenshot'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageData != null) Image.memory(imageData!),
            FilledButton.tonal(
              onPressed: _offScreenshotTap,
              child: Text('离屏截图'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _offScreenshotTap() async {
    final result = await controller.captureFromLongWidget(
      InheritedTheme.captureAll(
        context,
        Material(
          child: Builder(
            builder: (context) {
              return Column(
                children: List.generate(
                  20,
                  (index) => Text('index: $index'),
                ),
              );
            },
          ),
        ),
      ),
      delay: Duration(milliseconds: 100),
      context: context,
    );
    imageData = result;
    setState(() {});
  }
}
