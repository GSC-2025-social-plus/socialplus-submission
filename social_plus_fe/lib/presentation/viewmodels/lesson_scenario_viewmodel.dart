import 'package:flutter/cupertino.dart';

import '../../domain/models/scenario.dart';
import '../../domain/scenario_repository.dart';

class LessonScenarioViewModel extends ChangeNotifier {
  final ScenarioRepository repo;
  Scenario? scenario;
  bool isLoading = false;

  LessonScenarioViewModel(this.repo);

  Future<void> loadScenario({required int index, required String type}) async {
    scenario = await repo.fetchScenario(index, type: type);
    notifyListeners();
  }
}
