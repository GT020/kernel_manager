import 'package:kernel_manager/models/gpu_model.dart';
import 'package:kernel_manager/providers/gpu_providers/gpu_available_frequencies_provider.dart';
import 'package:kernel_manager/providers/gpu_providers/gpu_available_governor_provider.dart';
import 'package:kernel_manager/providers/gpu_providers/gpu_name_provider.dart';

class GpuRepository {
  Future<GPU> getGpu() async {
    return GPU(
        await GpuNameProviderDefault().getGpuName(),
        '/sys/kernel/gpu/gpu_clock',
        await GpuFrequencyProviderDefault().getGpuFrequencies(),
        await GpuAvailableGovernorProviderDefault().getGpuAvailableGovernors());
  }
}
