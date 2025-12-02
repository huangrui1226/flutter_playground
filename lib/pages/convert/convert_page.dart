import 'package:flutter/material.dart';
import 'package:flutter_playground/pages/convert/json_page.dart';

class ConvertPage extends StatelessWidget {
  const ConvertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convert'),
      ),
      body: ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: 1,
      ),
    );
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    switch (index) {
      case 0:
        return ListTile(
          title: Text('Json'),
          onTap: () {
            final destination = JsonPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      default:
        return ListTile();
    }
  }
}
