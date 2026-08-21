import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'convert/convert_page.dart';
import 'third_party/third_party_page.dart';
import 'utils/utils_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PackageInfo? info;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((value) {
      info = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          throw StateError('This is test exception');
        },
        child: Icon(Icons.error),
      ),
      appBar: AppBar(
        title: Text('Home Page v${info?.version} ${info?.buildNumber}'),
      ),
      body: ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: 3,
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
      case 2:
        return ListTile(
          title: Text('Utils'),
          onTap: () {
            final destination = UtilsPage();
            final route = MaterialPageRoute(builder: (context) => destination);
            Navigator.push(context, route);
          },
        );
      default:
        return ListTile();
    }
  }
}
