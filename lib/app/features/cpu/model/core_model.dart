class CpuCore {
  final int coreNumber;
  final String currentFrequencyNode;
  final List<int> availableFrequencies;
  final List<String> availableGovernor;
  final Map<double, double> state;
  CpuCore(this.availableFrequencies, this.coreNumber, this.currentFrequencyNode,
      this.availableGovernor, this.state);
}
