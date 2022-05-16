import 'package:kernel_manager/models/battery_model.dart';
import 'package:kernel_manager/providers/battery_providers/battery_current_provider.dart';
import 'package:kernel_manager/providers/battery_providers/battery_health_provider.dart';
import 'package:kernel_manager/providers/battery_providers/battery_percentage_provider.dart';
import 'package:kernel_manager/providers/battery_providers/battery_status_provider.dart';
import 'package:kernel_manager/providers/battery_providers/battery_technology_provider.dart';
import 'package:kernel_manager/providers/battery_providers/battery_temperature_provider.dart';
import 'package:kernel_manager/providers/battery_providers/battery_total_capacity_provider.dart';
import 'package:kernel_manager/providers/battery_providers/battery_voltage_provider.dart';

abstract class BatteryRepository {
  Future<Battery> getBattery();
}

class BatteryRepositoryAndroid extends BatteryRepository {
  @override
  Future<Battery> getBattery() async {
    return Battery(
        await BatteryTechnologyProviderAndroid().getBatteryTechnology(),
        await BatteryHealthProviderAndroid().getBatteryHealth(),
        await BatteryTotalCapacityProviderAndroid().getBatteryTotalCapacity(),
        BatteryTemperatureProviderAndroid().getBatteryTemperature(),
        BatteryCurrentProviderAndroid().getBatteryCurrent(),
        BatteryVoltageProviderAndroid().getBatteryVoltage(),
        BatteryPercentageProviderAndroid().getBatteryPercentage(),
        BatteryStatusProviderAndroid().getBatteryStatus());
  }
}
