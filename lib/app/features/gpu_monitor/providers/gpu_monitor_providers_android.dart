import 'package:flutter/foundation.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/providers/gpu_providers.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';
import 'package:penguin_kernel_manager/app/utils/root_utils.dart';

class GpuMonitorProvidersAndroid implements GpuMonitorProviders {
  @override
  Future<List<double>> getGpuAvailableFrequencies() async {
    final List<double> intF = [];

    try {
      final String availableFrequencies = await ReadUtil.cat(
        '/sys/class/kgsl/kgsl-3d0/gpu_available_frequencies',
      );

      final List<String> availableFrequenciesList =
          availableFrequencies.trim().split(' ');
      for (final String freq in availableFrequenciesList) {
        intF.add(double.parse(freq));
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

  @override
  Future<double> getMaxFrequency() async {
    final maxFrequency =
        await RootShell.cat('/sys/class/kgsl/kgsl-3d0/max_gpuclk');

    return double.parse(maxFrequency);
  }

  @override
  Future<double> getMinFrequency() async {
    final minFrequency =
        await RootShell.cat('/sys/class/kgsl/kgsl-3d0/devfreq/min_freq');

    return double.parse(minFrequency);
  }
}
