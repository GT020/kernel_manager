import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/gpu/model/gpu_model.dart';
import 'package:penguin_kernel_manager/app/features/gpu/providers/gpu_providers.dart';
import 'package:penguin_kernel_manager/app/features/gpu/providers/gpu_providers_android.dart';
import 'package:penguin_kernel_manager/app/features/gpu/providers/gpu_providers_linux.dart';
import 'package:penguin_kernel_manager/app/features/gpu/repository/gpu_repository.dart';

class GpuRepositoryImpl extends GpuRepository {
  late final GpuProviders gpuProviders;
  GpuRepositoryImpl() {
    if (Platform.isAndroid) {
      gpuProviders = GpuProvidersAndroid();
    }
    if (Platform.isLinux) {
      gpuProviders = GpuProvidersLinux();
    }
  }
  @override
  Future<GpuModel> getGpu() async {
    return GpuModel(
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
