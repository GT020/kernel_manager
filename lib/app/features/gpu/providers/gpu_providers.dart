abstract class GpuProviders {
  Future<String> getGpuName();
  Future<String> getGpuCurrentFrequencyNode();
  Future<List<double>> getGpuAvailableFrequencies();
  Future<List<String>> getGpuAvailableGovernors();
}
