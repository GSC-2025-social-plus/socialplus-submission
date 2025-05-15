//user_preferences_repository.dart
abstract class UserPreferencesRepository {
  Future<void> saveConversationType(String type);
  Future<String?> loadConversationType();
  Future<void> saveLessonCompletion(String type, List<bool> completionList);
  Future<List<bool>> loadLessonCompletion(String type);
}
