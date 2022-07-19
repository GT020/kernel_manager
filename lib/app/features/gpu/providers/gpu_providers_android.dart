import 'package:flutter/foundation.dart';
import 'package:penguin_kernel_manager/app/features/gpu/providers/gpu_providers.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

class GpuProvidersAndroid implements GpuProviders {
  @override
  Future<List<int>> getGpuAvailableFrequencies() async {
    final List<int> intF = [];

    try {
      final String availableFrequencies = await ReadUtil.cat(
        '/sys/class/kgsl/kgsl-3d0/gpu_available_frequencies',
      );

      final List<String> availableFrequenciesList =
          availableFrequencies.trim().split(' ');
      for (final String freq in availableFrequenciesList) {
        intF.add(int.parse(freq));
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      debugPrint(e.toString());
    }

    return intF;
  }

  @override
  Future<List<String>> getGpuAvailableGovernors() async {
    try {
      final List<String> availableGovernor = (await ReadUtil.cat(
        '/sys/class/kgsl/kgsl-3d0/devfreq/available_governors',
      ))
          .split(' ');

      return availableGovernor;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return [e.toString()];
    }
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
