import 'package:kernel_manager/app/features/gpu/providers/gpu_providers.dart';
import 'package:kernel_manager/app/utils/read_utils.dart';

class GpuProvidersAndroid implements GpuProviders {
  @override
  Future<List<int>> getGpuAvailableFrequencies() async {
    String availableFrequencies = await ReadUtil.ioRead(
        '/sys/class/kgsl/kgsl-3d0/gpu_available_frequencies');
    List<int> intF = [];

    List<String> a = availableFrequencies.trim().split(" ");
    for (String freq in a) {
      intF.add(int.parse(freq));
    }
    return intF;
  }

  @override
  Future<List<String>> getGpuAvailableGovernors() async {
    List<String> availableGovernor = (await ReadUtil.ioRead(
            '/sys/class/kgsl/kgsl-3d0/devfreq/available_governors'))
        .split(' ');

    return availableGovernor;
  }

  @override
  Future<String> getGpuCurrentFrequencyNode() async {
    return '/sys/class/kgsl/kgsl-3d0/gpuclk';
  }

  @override
  Future<String> getGpuName() {
    return ReadUtil.ioRead('/sys/kernel/gpu/gpu_model');
  }
}
