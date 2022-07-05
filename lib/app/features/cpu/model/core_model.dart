class CpuCore {
  final int coreNumber;
  final String currentFrequencyNode;
  final List<int> availableFrequencies;
  final List<String> availableGovernor;

  CpuCore(this.availableFrequencies, this.coreNumber, this.currentFrequencyNode,
      this.availableGovernor);
}
