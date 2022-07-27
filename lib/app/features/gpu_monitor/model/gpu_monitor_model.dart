class GpuMonitorModel {
  final String name;
  final String currentFrequencyNode;
  final double minFrequency;
  final double maxFrequency;

  GpuMonitorModel({
    required this.name,
    required this.currentFrequencyNode,
    required this.minFrequency,
    required this.maxFrequency,
  });
}
