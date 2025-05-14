import 'dart:async';

import 'package:flutter/material.dart';
import '../../domain/repository/speech_recognition_repository.dart';

class SpeechRecognitionViewModel extends ChangeNotifier {
  final SpeechRecognitionRepository repo;
  bool isListening = false;
  final TextEditingController textController = TextEditingController();
  Timer? _silenceTimer;
  bool _acceptSttInput = true;

  SpeechRecognitionViewModel(this.repo);

  Future<void> initialize() async {
    await repo.initialize();
  }

  Future<void> startListening() async {
    bool available = await repo.initialize();
    if (!available) return;

    _acceptSttInput = true;
    isListening = true;
    notifyListeners();

    repo.startListening((text) {
      if (!_acceptSttInput) return;
      textController.text = text;
      textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length),
      );
      notifyListeners();
      _resetSilenceTimer();
    });

    _resetSilenceTimer();
  }

  void _resetSilenceTimer() {
    _silenceTimer?.cancel();
    _silenceTimer = Timer(const Duration(seconds: 2), () {
      stopListening();
    });
  }

  Future<void> stopListening() async {
    _acceptSttInput = false;
    isListening = false;
    notifyListeners();
    await repo.stopListening();
    _silenceTimer?.cancel();
  }

  void onTextChanged(String text) {
    textController.text = text;
    notifyListeners();
  }
}