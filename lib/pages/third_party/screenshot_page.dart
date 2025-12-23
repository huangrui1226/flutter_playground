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
    final list = Column(
      spacing: 16,
      children: List.generate(
        20,
        (index) => Container(
          decoration: BoxDecoration(border: .all()),
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text('index: $index'),
        ),
      ),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () => _offScreenshotTap(list)),
      appBar: AppBar(
        title: Text('Screenshot'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: .topCenter,
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: .all(16),
                  child: list,
                ),
              ),
              if (imageData != null)
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: Image.memory(imageData!),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _offScreenshotTap(Widget child) async {
    if (imageData != null) {
      imageData = null;
      setState(() {});
      return;
    }
    final result = await controller.captureFromLongWidget(
      InheritedTheme.captureAll(
        context,
        Material(
          child: Builder(
            builder: (context) => child,
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
