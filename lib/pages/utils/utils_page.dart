import 'package:material_ui/material_ui.dart';

import 'file_logger_util_page.dart';

class UtilsPage extends StatelessWidget {
  const UtilsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Utils'),
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
          title: Text('File logger'),
          onTap: () {
            final destination = FileLoggerUtilPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      default:
        return ListTile();
    }
  }
}
