class Mission {
  final String description;

  const Mission({
    required this.description,
  });
}

class Scenario {
  final String scenarioId;
  final String scenarioName;
  final String scenarioDescription;
  final List<Mission> missions;

  const Scenario({
    required this.scenarioId,
    required this.scenarioName,
    required this.scenarioDescription,
    required this.missions,
  });
}
