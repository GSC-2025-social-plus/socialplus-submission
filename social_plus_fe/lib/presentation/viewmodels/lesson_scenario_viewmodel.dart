import 'package:flutter/cupertino.dart';

import '../../core/utils/scenario_id_mapper.dart';
import '../../domain/models/scenario.dart';
import '../../domain/repository/scenario_repository.dart';

class LessonScenarioViewModel extends ChangeNotifier {
  final ScenarioRepository repo;
  Scenario? scenario;
  bool isLoading = false;

  LessonScenarioViewModel(this.repo);

  Future<void> loadScenario({required int index, required String type}) async {
    scenario = await repo.fetchScenario(index, type: type);
    notifyListeners();
  }

  final ScenarioIdMapper _mapper = ScenarioIdMapper(); // 혹은 의존성 주입

  String? getScenarioId(String type, int lessonNumber) {
    return ScenarioIdMapper.getScenarioId(type, lessonNumber);
  }
}
