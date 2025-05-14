import '../../domain/models/scenario.dart';
import '../../domain/repository/scenario_repository.dart';
import '../../core/utils/scenario_id_mapper.dart';

import '../../core/utils/scenario_id_mapper.dart';
import '../../domain/models/scenario.dart';
import '../../domain/repository/scenario_repository.dart';

class MockScenarioRepository implements ScenarioRepository {
  @override
  Future<Scenario> fetchScenario(int lessonIndex, {required String type}) async {
    final lessonNumber = lessonIndex + 1;
    final scenarioId = ScenarioIdMapper.getScenarioId(type, lessonNumber) ?? 'unknown';

    switch (scenarioId) {
      case 'emotion_conversation_scenario':
        return _emotionScenario;
      case 'make_decision_scenario':
        return _decisionScenario;
      case 'ask_for_help_scenario':
        return _helpScenario;
      default:
        return _dailyScenario; // fallback
    }
  }
}

final _emotionScenario = Scenario(
  scenarioId: 'emotion_conversation_scenario',
  scenarioName: '친구와 감정대화하기',
  scenarioDescription:
  '오늘은 친구과 서로의 감정을 이야기해보는 날입니다.\n지금 느끼는 기분이나 최근에 있었던 감정 변화를 솔직하게 말해봅시다.',
  missions: [
    Mission(description: '오늘의 감정 한가지 표현'),
    Mission(description: '최근 기분이 좋았던 순간 말하기'),
    Mission(description: '힘들었던 일 하나 이야기하기'),
    Mission(description: '친구 감정에도 공감 표현하기'),
  ],
);

final _decisionScenario = Scenario(
  scenarioId: 'make_decision_scenario',
  scenarioName: '갈등상황에서 결정하기',
  scenarioDescription:
  '오늘은 작은 결정을 내려야하는 날이에요.\n규칙을 지켜야 하는 상황과 스스로 선택할 수 있는 상황을 구별해보고\n어떤 결정을 할 지 직접 말해보세요!',
  missions: [
    Mission(description: '제시된 상황을 듣고 스스로 결정해 말하기'),
    Mission(description: '판단 준거 설명하기'),
    Mission(description: '규칙을 따라야하는 상황 구별'),
    Mission(description: '결정 후 친구와 느낌 나누기'),
  ],
);

final _dailyScenario = Scenario(
  scenarioId: 'park_friend_scenario',
  scenarioName: '친구와 공원 산책',
  scenarioDescription: "오늘은 친구와 오랜만에 공원 산책을 하기로 했어요.\n가벼운 일상 이야기를 하면서 서로를 더 잘 알아가 보세요.\n대화를 이어가려면 먼저 상대방에게 관심을 가져보세요.",
  missions: [
    Mission(description: '먼저 인사하고 오늘 기분을 물어보기'),
    Mission(description: '상대방의 관심사 한 가지씩 물어보기'),
    Mission(description: '공통 관심사 찾기'),
    Mission(description: '다음 만남에 대해 제안하기'),
  ],
);
final  _helpScenario = Scenario(
  scenarioId: 'ask_for_help_scenario',
  scenarioName: '친구에게 프로젝트에 대한 도움을 요청하기',
  scenarioDescription: '''
이번에는 친구와 프로젝트를 해야 하는데, 친구에게 도움을 요청해야만 하는 상황이에요.
DEAR MAN 기법으로 '내가 원하는 것'을 정확히 말하고,
GIVE, FAST 기법으로 상대방과 좋은 관계를 유지하는 방법을 연습해봅시다!

📌 DEAR MAN 기법은 우리가 원하는 것을 상대방에게 잘 전달해서 얻을 수 있도록 도와주는 대화 방식이에요.

- D (Describe): 상황 묘사
- E (Express): 감정 표현
- A (Assert): 주장하기
- R (Reinforce): 강화하기
- M (Mindful): 집중하기
- A (Appear): 자신감 있는 태도
- N (Negotiate): 협상하기

📌 FAST 기법은 자기존중감을 지키며 대화하는 방법이에요.

- F (Fair): 공정하게
- A (Apologies): 최소한의 사과
- S (Stick to Values): 가치관 지키기
- T (Truthful): 진솔하게

📌 GIVE 기법은 상대방과 좋은 관계를 유지하는 대화법이에요.

- G (Gentle): 부드럽게
- I (Interested): 관심 보이기
- V (Validate): 공감하기
- E (Easy Manner): 편안한 태도
''',
  missions: [
    Mission(description: 'DEAR MAN 기법에서 최소 3단계 사용'),
    Mission(description: 'GIVE FAST 기법을 참고해 공손함 유지'),
    Mission(description: '요청 거절 가능성도 존중하는 태도 보이기'),
    Mission(description: '대화 끝에 자신의 감정 솔직히 표현'),
  ],
);

