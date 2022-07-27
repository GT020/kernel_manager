import 'package:penguin_kernel_manager/app/features/battery_monitor/providers/battery_monitor_providers.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

class BatteryMonitorProvidersAndroid implements BatteryMonitorProviders {
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

  @override
  Future<double> getCurrentMax() async {
    final String currentMax =
        await ReadUtil.ioRead('/sys/class/power_supply/battery/current_max');

    return double.parse(currentMax);
  }

  @override
  Future<double> getVoltageMax() async {
    final String voltageMax =
        await ReadUtil.ioRead('/sys/class/power_supply/battery/voltage_max');

    return double.parse(voltageMax);
  }
}
