import '../../domain/speech_recognition_repository.dart';
import '../speech_to_text_data_source.dart';

class SpeechRecognitionRepositoryImpl implements SpeechRecognitionRepository {
  final SpeechToTextDataSource dataSource;

  SpeechRecognitionRepositoryImpl(this.dataSource);

  @override
  Future<bool> initialize() => dataSource.initialize();

  @override
  void startListening(Function(String) onResult) =>
      dataSource.startListening(onResult);

  @override
  Future<void> stopListening() => dataSource.stopListening();
}
