abstract class SpeechRecognitionRepository {
  Future<bool> initialize();
  void startListening(Function(String) onResult);
  Future<void> stopListening();
}
