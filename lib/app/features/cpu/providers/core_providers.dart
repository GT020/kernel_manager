abstract class CoreProviders {
  Future<String> getCoreFrequency(int coreNumber);
  Future<List<int>> getAvailableFrequencies(int coreNumber);
  Future<List<String>> getAvailableGovernor(int coreNumber);
}
