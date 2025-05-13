class Mission {
  final String id;
  final String description;
  final bool completed;
  final String stampImageId;

  const Mission({
    required this.id,
    required this.description,
    required this.completed,
    required this.stampImageId,
  });
}

class Scenario {
  final String scenarioId;
  final String scenarioName;
  final String scenarioDescription;
  final String botInitialMessage;
  final List<Mission> missions;

  const Scenario({
    required this.scenarioId,
    required this.scenarioName,
    required this.scenarioDescription,
    required this.botInitialMessage,
    required this.missions,
  });
}