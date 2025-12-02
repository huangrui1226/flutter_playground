import 'dart:convert';

import 'package:flutter/material.dart';

class JsonPage extends StatelessWidget {
  const JsonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final map1 = {
            'index': 1761610942919,
          };
          final json1 = jsonEncode(map1);
          debugPrint('json1: $json1');
          debugPrint('json1.length: ${json1.length}');
          final map2 = {
            'index': '1761610942919',
          };
          final json2 = jsonEncode(map2);
          debugPrint('json2: $json2');
          debugPrint('json2.length: ${json2.length}');
        },
      ),
      appBar: AppBar(
        title: const Text('JSON Page'),
      ),
      body: Center(),
    );
  }
}
