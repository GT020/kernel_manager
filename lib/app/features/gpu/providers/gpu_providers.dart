abstract class GpuProviders {
  Future<String> getGpuName();
  Future<String> getGpuCurrentFrequencyNode();
  Future<List<int>> getGpuAvailableFrequencies();
  Future<List<String>> getGpuAvailableGovernors();
}
