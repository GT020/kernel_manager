class GPU {
  final String name;
  final String currentFrequency;
  final List<int> availableFrequencies;
  final List<String> availableGovernors;

  GPU(this.name, this.currentFrequency, this.availableFrequencies,
      this.availableGovernors);
}
