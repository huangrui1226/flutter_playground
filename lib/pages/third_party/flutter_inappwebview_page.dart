import 'package:material_ui/material_ui.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FlutterInappwebviewPage extends StatelessWidget {
  const FlutterInappwebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InAppWebView(
        onWebViewCreated: (controller) {
          controller.loadUrl(
            urlRequest: URLRequest(
              url: WebUri('http://test-game.vicleer.com/StandardTraining/project/st1720/index.html'),
            ),
          );
        },
      ),
    );
  }
}
