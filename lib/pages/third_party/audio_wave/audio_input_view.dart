import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

import 'audio_wave_view.dart';

class AudioInputView extends StatefulWidget {
  const AudioInputView({
    required this.onConfirm,
    required this.onCancel,
    super.key,
  });

  final VoidCallback onCancel;
  final ValueChanged<String?> onConfirm;

  @override
  State<AudioInputView> createState() => _AudioInputViewState();
}

class _AudioInputViewState extends State<AudioInputView> {
  final recorderController = RecorderController();
  late List<double> decibelList = List.generate(10, (_) => 0);
  Timer? getDecibelTimer;
  bool isRecording = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    recorderController.dispose();
    stopListenDecibelChanged();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .center,
      spacing: 8,
      children: [
        _titleView(context),
        Container(
          height: 64,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF343842),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            children: [
              _buttonView(
                'assets/images/wave_view_cancel.png',
                widget.onCancel,
              ),
              Expanded(child: AudioWaveView(decibelList: decibelList)),
              _buttonView(
                'assets/images/wave_view_confirm.png',
                () => _startOrStopRecording(_handleRecordStop),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _titleView(BuildContext context) {
    return Text(
      hasError ? "未识别到内容" : '正在识别',
      style: TextStyle(
        color: false ? Colors.black : Color(0xFFF2F6FA).withValues(alpha: 0.9),
        fontSize: 12,
        fontWeight: .w500,
      ),
    );
  }

  Widget _buttonView(String icon, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 64,
        height: 64,
        child: Center(
          child: Image.asset(
            icon,
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }

  Widget _retryButton() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0x5A68E9FF),
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      height: 64,
      child: Center(
        child: Text(
          '点击重新识别',
          style: TextStyle(
            color: false ? Colors.white : Color(0xF2F6FAE6),
            fontSize: 14,
            fontWeight: .w500,
          ),
        ),
      ),
    );
  }

  Future<void> startListenDecibelChanged() async {
    getDecibelTimer = Timer.periodic(Duration(milliseconds: 50), (timer) async {
      final decibel = await AudioWaveformsInterface.instance.getDecibel();
      if (decibel != null) {
        decibelList.add(decibel);
        decibelList.removeAt(0);
      }
      setState(() {});
    });
  }

  Future<void> stopListenDecibelChanged() async {
    getDecibelTimer?.cancel();
    getDecibelTimer = null;
  }

  Future<void> _startOrStopRecording(ValueChanged<String?>? onStop) async {
    try {
      if (isRecording) {
        recorderController.reset();
        final path = await recorderController.stop(false);
        onStop?.call(path);
      } else {
        await recorderController.record(
          recorderSettings: const RecorderSettings(),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (recorderController.hasPermission) {
        setState(() {
          isRecording = !isRecording;
        });
      }
    }
  }

  void _handleRecordStop(String? path) {
    if (path == null) {}
  }
}
