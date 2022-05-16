class CPU {
  final String name;
  final int numberOfCores;
  final String architecture;
  final String process;
  final List<List<int>> coreStructure;
  final List<CpuCore> cores;

  CPU(
      {required this.numberOfCores,
      required this.architecture,
      required this.process,
      required this.coreStructure,
      required this.name,
      required this.cores});
}

class CpuCore {
  final int coreNumber;
  final String currentFrequency;
  final List<int> availableFrequencies;
  final List<String> availableGovernor;

  CpuCore(this.availableFrequencies, this.coreNumber, this.currentFrequency,
      this.availableGovernor);
}
