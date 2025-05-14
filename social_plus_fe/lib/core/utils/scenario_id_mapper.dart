class ScenarioIdMapper {
  static final Map<String, Map<int, String>> _scenarioMap = {
    'daily': {
      1: 'park_friend_scenario',
      2: 'emotion_conversation_scenario',
      3: 'make_decision_scenario',
      4: 'ask_for_help_scenario',
    },
    // job 도 나중에 추가 가능
  };

  static String getScenarioId(String type, int lessonNumber) {
    return _scenarioMap[type]?[lessonNumber] ?? 'park_friend_scenario'; // 기본 fallback
  }
}