import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/scenario.dart';
import '../../domain/scenario_repository.dart';

class ScenarioRepositoryImpl implements ScenarioRepository {
  final String baseUrl = 'https://startconversation-imrcv7okwa-uc.a.run.app';

  @override
  Future<Scenario> fetchScenario (int lessonIndex, {String type = 'daily'}) async {
    final scenarioId = _mapIndexToScenarioId(lessonIndex);
    final userId = 'user123';

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, 'scenario': scenarioId}),
    );

    if (response.statusCode != 200) throw Exception('시나리오 불러오기 실패');

    final data = jsonDecode(response.body);

    final missionsMap = data['missions'] as Map<String, dynamic>;
    final missions = missionsMap.entries.map((e) {
      final m = e.value;
      return Mission(
        id: e.key,
        description: m['description'] ?? '',
        completed: m['completed'] ?? false,
        stampImageId: m['stampImageId'] ?? 'stamp_initial',
      );
    }).toList();

    return Scenario(
      scenarioId: data['scenarioId'],
      scenarioName: data['scenarioName'],
      scenarioDescription: data['scenarioDescription'],
      botInitialMessage: data['botInitialMessage'],
      missions: _parseMissions(data['missions']),
    );
  }


  String _mapIndexToScenarioId(int index) {
    const mapping = ['park_friend_scenario', 'job_cafe_scenario', 'job_it_scenario', 'job_manu_scenario'];
    return mapping[index];
  }

  List<Mission> _parseMissions(dynamic missionData) {
    if (missionData is! Map<String, dynamic>) return [];

    return missionData.entries.map((e) {
      final m = e.value as Map<String, dynamic>;
      return Mission(
        id: e.key,
        description: m['description'] ?? '',
        completed: m['completed'] ?? false,
        stampImageId: m['stampImageId'] ?? 'stamp_initial',
      );
    }).toList();
  }
}
