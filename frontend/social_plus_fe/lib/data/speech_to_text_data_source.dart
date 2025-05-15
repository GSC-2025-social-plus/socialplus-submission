import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextDataSource {
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<bool> initialize() => _speech.initialize();

  void startListening(Function(String) onResult) {
    _speech.listen(onResult: (result) => onResult(result.recognizedWords));
  }

  Future<void> stopListening() => _speech.stop();
}
