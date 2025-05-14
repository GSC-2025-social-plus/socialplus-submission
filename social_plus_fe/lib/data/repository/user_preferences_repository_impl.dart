
import '../../domain/repository/user_preferences_repository.dart';
import '../user_preferences_data_source.dart';

class UserPreferencesRepositoryImpl implements UserPreferencesRepository {
  final UserPreferencesDataSource dataSource;

  UserPreferencesRepositoryImpl(this.dataSource);

  @override
  Future<void> saveConversationType(String type) => dataSource.saveConversationType(type);

  @override
  Future<String?> loadConversationType() => dataSource.loadConversationType();

  @override
  Future<void> saveLessonCompletion(String type, List<bool> completionList) =>
      dataSource.saveLessonCompletion(type, completionList);

  @override
  Future<List<bool>> loadLessonCompletion(String type) =>
      dataSource.loadLessonCompletion(type);
}
