abstract class BatteryCurrentProvider {
  String getBatteryCurrent();
}

class BatteryCurrentProviderAndroid extends BatteryCurrentProvider {
  @override
  String getBatteryCurrent() {
    return '/sys/class/power_supply/battery/current_now';
  }
}
