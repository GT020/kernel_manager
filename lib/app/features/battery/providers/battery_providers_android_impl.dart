import 'package:penguin_kernel_manager/app/features/battery/providers/battery_providers.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

class BatteryProvidersAndroid implements BatteryProviders {
  @override
  Future<String> getCurrentNode() async {
    return '/sys/class/power_supply/battery/current_now';
  }

  @override
  Future<String> getHealth() async {
    return ReadUtil.ioRead('/sys/class/power_supply/battery/health');
  }

  @override
  Future<String> getPercentageNode() async {
    return '/sys/class/power_supply/battery/capacity';
  }

  @override
  Future<String> getStatusNode() async {
    return '/sys/class/power_supply/battery/status';
  }

  @override
  Future<String> getTechnology() async {
    return ReadUtil.ioRead('/sys/class/power_supply/battery/technology');
  }

  @override
  Future<String> getTemperatureNode() async {
    return '/sys/class/power_supply/battery/temp';
  }

  @override
  Future<String> getTotalCapacity() {
    return ReadUtil.ioRead('/sys/class/power_supply/battery/temp');
  }

  @override
  Future<String> getVoltageNode() async {
    return '/sys/class/power_supply/battery/voltage_now';
  }
}
