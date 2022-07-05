class GpuModel {
  final String name;
  final String currentFrequencyNode;
  final List<int> availableFrequencies;
  final List<String> availableGovernors;

  GpuModel(this.name, this.currentFrequencyNode, this.availableFrequencies,
      this.availableGovernors);
}
