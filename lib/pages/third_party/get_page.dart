import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetPage extends StatelessWidget {
  const GetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Page"),
      ),
      body: GetBuilder<GetPageController>(
        init: GetPageController(),
        builder: (controller) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FilledButton.tonal(
                  onPressed: controller.onFirstOrNullTap,
                  child: Text("firstOrNull"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GetPageController extends GetxController {
  void onFirstOrNullTap() {
    final list1 = <int>[];
    final n1 = list1.firstOrNull;
  }
}
