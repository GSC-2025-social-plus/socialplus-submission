import '../models/scenario.dart';

abstract class ScenarioRepository {
  Future<Scenario> fetchScenario(int lessonIndex, {required String type});
}