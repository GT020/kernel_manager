abstract class BatteryVoltageProvider {
  String getBatteryVoltage();
}

class BatteryVoltageProviderAndroid extends BatteryVoltageProvider {
  @override
  String getBatteryVoltage() {
    return '/sys/class/power_supply/battery/voltage_now';
  }
}
