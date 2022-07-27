import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/ram_monitor/model/ram_monitor_model.dart';
import 'package:penguin_kernel_manager/app/features/ram_monitor/providers/ram_monitor_providers.dart';
import 'package:penguin_kernel_manager/app/features/ram_monitor/providers/ram_monitor_providers_android_impl.dart';
import 'ram_monitor_repository.dart';

class RamMonitorRepositoryImpl extends RamMonitorRepository {
  late final RamMonitorProviders ramMonitorProviders;
  RamMonitorRepositoryImpl() {
    if (Platform.isAndroid) {
      ramMonitorProviders = RamMonitorProvidersAndroid();
    }
  }

  @override
  Future<RamMonitorModel> getRamMonitorModel() async {
    return RamMonitorModel(
      totalCapacity: await ramMonitorProviders.getTotalRam(),
      ramUsageNode: await ramMonitorProviders.getRamUsageNode(),
    );
  }
}

final ramMonitorRepositoryProvider =
    Provider<RamMonitorRepository>((final ref) {
  return RamMonitorRepositoryImpl();
});
