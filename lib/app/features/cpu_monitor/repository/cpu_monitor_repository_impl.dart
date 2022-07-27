import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/model/cpu_monitor_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/providers/cpu_monitor_providers.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/providers/cpu_monitor_providers_android_impl.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/repository/cpu_monitor_repository.dart';

class CpuMonitorRepositoryImpl extends CpuMonitorRepository {
  late final CpuMonitorProviders cpuMonitorProviders;
  CpuMonitorRepositoryImpl() {
    if (Platform.isAndroid) {
      cpuMonitorProviders = CpuMonitorProvidersAndroidImpl();
    }
  }
  @override
  Future<CpuMonitorModel> getCpuMonitor() async {
    return CpuMonitorModel(
      name: await cpuMonitorProviders.getCpuName(),
      numberOfCores: await cpuMonitorProviders.getNumberOfCores(),
      architecture: await cpuMonitorProviders.getArchitecture(),
      fabrication: await cpuMonitorProviders.getFabrication(),
      coreMonitors: await cpuMonitorProviders.getCoreMonitors(),
    );
  }
}

final cpuMonitorRepositoryProvider =
    Provider<CpuMonitorRepository>((final ref) {
  return CpuMonitorRepositoryImpl();
});
