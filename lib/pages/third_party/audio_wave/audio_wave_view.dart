import 'package:flutter/material.dart';

class AudioWaveView extends StatelessWidget {
  AudioWaveView({
    required this.decibelList,
    super.key,
  });

  final List<double> decibelList;

  final colorTween = ColorTween(begin: Color(0xFF3014C7), end: Color(0xFFB0D6FC));

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return Row(
          mainAxisAlignment: .spaceBetween,
          children: List.generate(decibelList.length * 2 - 1, (i) {
            final int index;
            if (i < decibelList.length - 1) {
              index = i;
            } else {
              index = (decibelList.length - 1) - (i - decibelList.length + 1);
            }
            final decibel = decibelList[index];
            return Container(
              width: 2,
              height: 4 + decibel * (height - 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                color: colorTween.lerp(index.toDouble() / (decibelList.length - 1).toDouble()),
              ),
            );
          }),
        );
      },
    );
  }
}
