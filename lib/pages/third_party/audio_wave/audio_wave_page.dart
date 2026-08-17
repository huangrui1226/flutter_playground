import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_playground/pages/third_party/audio_wave/audio_input_view.dart';

class AudioWavePage extends StatefulWidget {
  const AudioWavePage({super.key});

  @override
  State<AudioWavePage> createState() => _AudioWavePageState();
}

class _AudioWavePageState extends State<AudioWavePage> {
  final playerController = PlayerController();
  bool showWaveView = false;
  String? filePath;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
            Text('filePath: $filePath'),
            if (showWaveView)
              SizedBox(
                width: 256,
                child: AudioInputView(
                  onConfirm: (value) {
                    setState(() {
                      showWaveView = false;
                      filePath = value;
                      if (filePath != null) {
                        playerController.preparePlayer(path: filePath!);
                      }
                    });
                  },
                  onCancel: () {
                    setState(() {
                      showWaveView = false;
                    });
                  },
                ),
              ),
            FilledButton(
              onPressed: onRecordStartTap,
              child: Text("开始录音"),
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

  Future<void> onStartPlayTap() async {
    playerController.startPlayer();
  }

  Future<void> onRecordStartTap() async {
    setState(() {
      showWaveView = true;
    });
  }
}
