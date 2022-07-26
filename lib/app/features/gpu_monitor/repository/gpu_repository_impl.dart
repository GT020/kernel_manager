import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/model/gpu_model.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/providers/gpu_providers.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/providers/gpu_providers_android.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/providers/gpu_providers_linux.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/repository/gpu_repository.dart';

class GpuRepositoryImpl extends GpuRepository {
  late final GpuMonitorProviders gpuProviders;
  GpuRepositoryImpl() {
    if (Platform.isAndroid) {
      gpuProviders = GpuMonitorProvidersAndroid();
    }
    if (Platform.isLinux) {
      gpuProviders = GpuMonitorProvidersLinux();
    }
  }
  @override
  Future<GpuMonitorModel> getGpu() async {
    return GpuMonitorModel(
      await gpuProviders.getGpuName(),
      await gpuProviders.getGpuCurrentFrequencyNode(),
      await gpuProviders.getGpuAvailableFrequencies(),
      await gpuProviders.getGpuAvailableGovernors(),
      await gpuProviders.getMinFrequency(),
      await gpuProviders.getMaxFrequency(),
    );
  }
}

final gpuRepositoryProvider = Provider<GpuRepository>((final ref) {
  return GpuRepositoryImpl();
});
