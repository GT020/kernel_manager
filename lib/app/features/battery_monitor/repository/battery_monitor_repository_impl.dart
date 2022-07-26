import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/battery_monitor/model/battery_monitor_model.dart';
import 'package:penguin_kernel_manager/app/features/battery_monitor/providers/battery_monitor_providers.dart';
import 'package:penguin_kernel_manager/app/features/battery_monitor/providers/battery_monitor_providers_android_impl.dart';
import 'package:penguin_kernel_manager/app/features/battery_monitor/providers/battery_monitor_providers_linux_impl.dart';
import 'package:penguin_kernel_manager/app/features/battery_monitor/repository/battery_monitor_repository.dart';

class BatteryRepositoryImpl extends BatteryRepository {
  late final BatteryMonitorProviders batteryMonitorProviders;

  BatteryRepositoryImpl() {
    if (Platform.isAndroid) {
      batteryMonitorProviders = BatteryMonitorProvidersAndroid();
    }
    if (Platform.isLinux) {
      batteryMonitorProviders = BatteryMonitorProvidersLinux();
    }
  }
  @override
  Future<BatteryMonitorModel> getBattery() async {
    return BatteryMonitorModel(
      await batteryMonitorProviders.getTechnology(),
      await batteryMonitorProviders.getHealth(),
      await batteryMonitorProviders.getTotalCapacity(),
      await batteryMonitorProviders.getTemperatureNode(),
      await batteryMonitorProviders.getCurrentNode(),
      await batteryMonitorProviders.getVoltageNode(),
      await batteryMonitorProviders.getPercentageNode(),
      await batteryMonitorProviders.getStatusNode(),
      await batteryMonitorProviders.getCurrentMax(),
      await batteryMonitorProviders.getVoltageMax(),
    );
  }
}

final batteryRepositoryProvider = Provider<BatteryRepository>((final ref) {
  return BatteryRepositoryImpl();
});
