import 'package:penguin_kernel_manager/app/features/gpu/providers/gpu_providers.dart';

class GpuProvidersLinux implements GpuProviders {
  @override
  Future<List<int>> getGpuAvailableFrequencies() {
    // TODO: implement getGpuAvailableFrequencies
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getGpuAvailableGovernors() {
    // TODO: implement getGpuAvailableGovernors
    throw UnimplementedError();
  }

  @override
  Future<String> getGpuCurrentFrequencyNode() {
    // TODO: implement getGpuCurrentFrequencyNode
    throw UnimplementedError();
  }

  @override
  Future<String> getGpuName() {
    // TODO: implement getGpuName
    throw UnimplementedError();
  }
}
