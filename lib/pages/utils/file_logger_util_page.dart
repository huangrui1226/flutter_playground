import 'package:material_ui/material_ui.dart';
import 'package:flutter_playground/utils/file_logger_util.dart';

class FileLoggerUtilPage extends StatefulWidget {
  const FileLoggerUtilPage({super.key});

  @override
  State<FileLoggerUtilPage> createState() => _FileLoggerUtilPageState();
}

class _FileLoggerUtilPageState extends State<FileLoggerUtilPage> {
  final messageList = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Logger Util')),
      body: Row(
        children: [
          Expanded(child: _featureList()),
          Expanded(child: _messageList()),
        ],
      ),
    );
  }

  Widget _featureList() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            ElevatedButton(
              onPressed: () {
                final message = 'time: ${DateTime.now()}';
                messageList.add(message);
                setState(() {});
                FileLoggerUtil().log(message);
              },
              child: Text("Log time"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _messageList() {
    return Card(
      child: ListView.builder(
        padding: .all(8),
        itemCount: messageList.length,
        itemBuilder: (context, index) {
          final message = messageList[index];
          return Text(message);
        },
      ),
    );
  }
}
