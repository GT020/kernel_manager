import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/cpu/model/cpu_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu/providers/core_providers.dart';
import 'package:penguin_kernel_manager/app/features/cpu/providers/core_providers_android_impl.dart';
import 'package:penguin_kernel_manager/app/features/cpu/providers/core_providers_linux_impl.dart';
import 'package:penguin_kernel_manager/app/features/cpu/providers/cpu_providers.dart';
import 'package:penguin_kernel_manager/app/features/cpu/providers/cpu_providers_android_impl.dart';
import 'package:penguin_kernel_manager/app/features/cpu/providers/cpu_providers_linux_impl.dart';
import 'package:penguin_kernel_manager/app/features/cpu/repository/cpu_repository.dart';

class CpuRepositoryImpl extends CpuRepository {
  late final CpuProviders cpuProviders;
  late final CoreProviders coreProviders;

  CpuRepositoryImpl() {
    if (Platform.isAndroid) {
      cpuProviders = CpuProviderAndroid();
      coreProviders = CoreProviderAndroid();
    }
    if (Platform.isLinux) {
      cpuProviders = CpuProviderLinux();
      coreProviders = CoreProviderLinux();
    }
  }

  @override
  Future<CpuModel> getCpu() async {
    final coreStructure = await cpuProviders.getCoreStructure();

    return CpuModel(
      numberOfCores: Platform.numberOfProcessors,
      architecture: await cpuProviders.getCpuArchitecture(),
      process: await cpuProviders.getCpuBuildProcess(),
      coreStructure: coreStructure,
      name: await cpuProviders.getCpuName(),
      cores: await cpuProviders.getCpuCores(coreStructure),
    );
  }
}

final cpuRepositoryProvider = Provider<CpuRepository>((final ref) {
  return CpuRepositoryImpl();
});
