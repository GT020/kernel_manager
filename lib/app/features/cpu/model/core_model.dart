class CpuCore {
  final int coreNumber;
  final String currentFrequency;
  final List<int> availableFrequencies;
  final List<String> availableGovernor;

  CpuCore(this.availableFrequencies, this.coreNumber, this.currentFrequency,
      this.availableGovernor);
}
