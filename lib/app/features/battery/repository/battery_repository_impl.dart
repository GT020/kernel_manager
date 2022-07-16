import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/battery/model/battery_model.dart';
import 'package:penguin_kernel_manager/app/features/battery/providers/battery_providers.dart';
import 'package:penguin_kernel_manager/app/features/battery/providers/battery_providers_android_impl.dart';
import 'package:penguin_kernel_manager/app/features/battery/providers/battery_providers_linux_impl.dart';
import 'package:penguin_kernel_manager/app/features/battery/repository/battery_repository.dart';

class BatteryRepositoryImpl extends BatteryRepository {
  late final BatteryProviders batteryProviders;

  BatteryRepositoryImpl() {
    if (Platform.isAndroid) {
      batteryProviders = BatteryProvidersAndroid();
    }
    if (Platform.isLinux) {
      batteryProviders = BatteryProvidersLinux();
    }
  }
  @override
  Future<BatteryModel> getBattery() async {
    return BatteryModel(
      await batteryProviders.getTechnology(),
      await batteryProviders.getHealth(),
      await batteryProviders.getTotalCapacity(),
      await batteryProviders.getTemperatureNode(),
      await batteryProviders.getCurrentNode(),
      await batteryProviders.getVoltageNode(),
      await batteryProviders.getPercentageNode(),
      await batteryProviders.getStatusNode(),
    );
  }
}

final batteryRepositoryProvider = Provider<BatteryRepository>((final ref) {
  return BatteryRepositoryImpl();
});
