import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../domain/repository/user_preferences_repository.dart';

class UserPreferencesViewModel extends ChangeNotifier {
  final UserPreferencesRepository repo;

  UserPreferencesViewModel(this.repo);

  String? conversationType;
  List<bool> lessonCompletion = [false, false, false, false];

  Future<void> loadPreferences() async {
    conversationType = await repo.loadConversationType();
    if (conversationType != null) {
      lessonCompletion = await repo.loadLessonCompletion(conversationType!);
    }
    notifyListeners();
  }

  Future<void> saveConversationType(String type) async {
    await repo.saveConversationType(type);
    conversationType = type;
    notifyListeners();
  }


  Future<void> saveLessonCompletion(List<bool> completionList) async {
    if (conversationType != null) {
      await repo.saveLessonCompletion(conversationType!, completionList);
      lessonCompletion = completionList;
      notifyListeners();
    }
  }

  //레슨 완료 처리 함수
  void onLessonCompleted(BuildContext context, int lessonIndex) async {
    final prefsViewModel = context.read<UserPreferencesViewModel>();
    List<bool> updated = List.from(prefsViewModel.lessonCompletion);
    updated[lessonIndex] = true;
    await prefsViewModel.saveLessonCompletion(updated);
  }

}