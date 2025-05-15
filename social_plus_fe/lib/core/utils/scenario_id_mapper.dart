class ScenarioIdMapper {
  static final Map<String, Map<int, String>> _scenarioMap = {
    'daily': {
      1: 'park_friend_scenario',
      2: 'emotion_conversation_scenario',
      3: 'make_decision_scenario',
      4: 'request_for_help_scenario',
    },
    'job-cafe': {
      1: 'park_friend_scenario',
      2: 'emotion_conversation_scenario',
      3: 'make_decision_scenario',
      4: 'request_for_help_scenario',
    },
    'job-it': {
      1: 'park_friend_scenario',
      2: 'emotion_conversation_scenario',
      3: 'make_decision_scenario',
      4: 'request_for_help_scenario',
    },
    'job-manufacture': {
      1: 'park_friend_scenario',
      2: 'emotion_conversation_scenario',
      3: 'make_decision_scenario',
      4: 'request_for_help_scenario',
    },
  };

  static String getScenarioId(String type, int lessonNumber) {
    return _scenarioMap[type]?[lessonNumber] ??
        'park_friend_scenario'; // 기본 fallback
  }
}
