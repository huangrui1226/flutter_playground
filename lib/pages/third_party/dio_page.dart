import 'package:dio/dio.dart';
import 'package:material_ui/material_ui.dart';

class DioPage extends StatefulWidget {
  const DioPage({super.key});

  @override
  State<DioPage> createState() => _DioPageState();
}

class _DioPageState extends State<DioPage> {
  String content = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: .all(32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: .center,
          children: [
            Expanded(child: Text(content)),
            Row(
              children: [
                FilledButton(
                  onPressed: () => _request('https://www.baidu.com'),
                  child: Text("https get"),
                ),
                FilledButton(
                  onPressed: () => _request('http://www.baidu.com'),
                  child: Text("http get"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _request(String url) async {
    content = '';
    setState(() {});
    final dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      final response = await dio.get(url);
      content = response.toString();
      setState(() {});
    } catch (e) {
      content = e.toString();
      setState(() {});
    }
  }
}
