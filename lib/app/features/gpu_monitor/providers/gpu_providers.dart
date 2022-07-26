abstract class GpuMonitorProviders {
  Future<String> getGpuName();
  Future<String> getGpuCurrentFrequencyNode();
  Future<double> getMinFrequency();
  Future<double> getMaxFrequency();
  Future<List<double>> getGpuAvailableFrequencies();
  Future<List<String>> getGpuAvailableGovernors();
}
