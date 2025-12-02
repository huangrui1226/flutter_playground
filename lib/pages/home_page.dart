import 'package:flutter/material.dart';
import 'package:flutter_playground/pages/convert/convert_page.dart';
import 'package:flutter_playground/pages/third_party/third_party_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: 2,
      ),
    );
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    switch (index) {
      case 0:
        return ListTile(
          title: Text('Third Party'),
          onTap: () {
            final destination = ThirdPartyPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      case 1:
        return ListTile(
          title: Text('Convert'),
          onTap: () {
            final destination = ConvertPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      default:
        return ListTile();
    }
  }
}
