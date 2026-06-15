import 'package:display_metrics/display_metrics.dart';
import 'package:flutter/material.dart';

class DisplayMetricsPage extends StatelessWidget {
  const DisplayMetricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final dm = DisplayMetrics.of(context);
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(height: 32),
                  Text(dm.physicalSize.toString()),
                  Text(dm.resolution.toString()),
                  Text(dm.diagonal.toString()),
                  Text(dm.ppi.toString()),
                  Text(constraints.maxHeight.toString()),
                  Text(mq.size.height.toString()),
                ],
              ),
              VerticalDivider(),
              Container(height: constraints.maxHeight, width: 10, color: Colors.red),
              Container(height: constraints.maxHeight - 1, width: 10, color: Colors.red),
            ],
          );
        },
      ),
    );
  }
}
