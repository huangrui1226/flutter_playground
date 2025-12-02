import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class AudioWavePage extends StatefulWidget {
  const AudioWavePage({super.key});

  @override
  State<AudioWavePage> createState() => _AudioWavePageState();
}

class _AudioWavePageState extends State<AudioWavePage> {
  final recorderController = RecorderController();
  final playerController = PlayerController();
  String? recordFilePath;
  Timer? getDecibelTimer;
  double? decibel;

  @override
  void dispose() {
    recorderController.dispose();
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Wave'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('decibel: $decibel'),
            AnimatedContainer(
              height: 32,
              width: MediaQuery.of(context).size.width * (decibel ?? 0),
              color: Colors.red,
              duration: Duration(milliseconds: 100),
            ),
            FilledButton(
              onPressed: onRecordStartTap,
              child: Text("开始录音"),
            ),
            FilledButton(
              onPressed: onRecordStopTap,
              child: Text("停止录音"),
            ),
            FilledButton(
              onPressed: onStartPlayTap,
              child: Text("播放录音"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onRecordStartTap() async {
    startListenDecibelChanged();
    final hasPermission = recorderController.checkPermission();
    debugPrint('hasPermission: $hasPermission');
    await recorderController.record();
  }

  Future<void> onRecordStopTap() async {
    stopListenDecibelChanged();
    final path = await recorderController.stop();
    if (path == null) {
      return;
    }
    await playerController.preparePlayer(path: path);
  }

  Future<void> startListenDecibelChanged() async {
    getDecibelTimer = Timer.periodic(Duration(milliseconds: 50), (timer) async {
      decibel = await AudioWaveformsInterface.instance.getDecibel();
      setState(() {});
    });
  }

  Future<void> stopListenDecibelChanged() async {
    getDecibelTimer?.cancel();
    getDecibelTimer = null;
  }

  Future<void> onStartPlayTap() async {
    playerController.startPlayer();
  }
}
