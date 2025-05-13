import '../../domain/models/scenario.dart';
import '../../domain/scenario_repository.dart';

final mockDailyLessonScenario = Scenario(
  scenarioId: 'daily_lesson_1',
  scenarioName: '일본 친구와 오랜만에 만남',
  scenarioDescription: '친구와 일본 음식점에서 오랜만에 만나 대화하는 상황입니다.',
  botInitialMessage: '오랜만이네! 너랑 밥 먹으니까 너무 좋다~',
  missions: [
    Mission(
      id: 'mission_1',
      description: '먼저 인사하고 오늘 기분을 물어보기',
      completed: false,
      stampImageId: 'stamp1',
    ),
    Mission(
      id: 'mission_2',
      description: '상대방의 관심사 한 가지씩 물어보기',
      completed: false,
      stampImageId: 'stamp2',
    ),
    Mission(
      id: 'mission_3',
      description: '공통 관심사 찾기',
      completed: false,
      stampImageId: 'stamp3',
    ),
    Mission(
      id: 'mission_4',
      description: '다음 만남에 대해 제안하기',
      completed: false,
      stampImageId: 'stamp4',
    ),
  ],
);

class ScenarioRepositoryImpl implements ScenarioRepository {
  final String baseUrl = 'https://startconversation...';

  @override
  Future<Scenario> fetchScenario(int lessonIndex, {String type = 'daily'}) async {
    try {
      // TODO: API 요청 로직
      return mockDailyLessonScenario;
    } catch (_) {
      // 실패하거나 API가 없을 경우 mock 반환
      if (type == 'daily') {
        return mockDailyLessonScenario;
      }
      throw Exception('시나리오를 불러올 수 없습니다.');
    }
  }
}
