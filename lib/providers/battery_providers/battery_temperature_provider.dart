abstract class BatteryTemperatureProvider {
  String getBatteryTemperature();
}

class BatteryTemperatureProviderAndroid extends BatteryTemperatureProvider {
  @override
  String getBatteryTemperature() {
    return '/sys/class/power_supply/battery/temp';
  }
}
