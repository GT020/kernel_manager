class GpuModel {
  final String name;
  final String currentFrequencyNode;
  final double minFrequency;
  final double maxFrequency;
  final List<double> availableFrequencies;
  final List<String> availableGovernors;

  GpuModel(
    this.name,
    this.currentFrequencyNode,
    this.availableFrequencies,
    this.availableGovernors,
    this.minFrequency,
    this.maxFrequency,
  );
}
