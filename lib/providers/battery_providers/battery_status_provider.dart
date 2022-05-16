abstract class BatteryStatusProvider {
  String getBatteryStatus();
}

class BatteryStatusProviderAndroid extends BatteryStatusProvider {
  @override
  String getBatteryStatus() {
    return '/sys/class/power_supply/battery/status';
  }
}
