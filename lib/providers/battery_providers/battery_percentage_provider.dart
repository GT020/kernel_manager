abstract class BatteryPercentageProvider {
  String getBatteryPercentage();
}

class BatteryPercentageProviderAndroid extends BatteryPercentageProvider {
  @override
  String getBatteryPercentage() {
    return '/sys/class/power_supply/battery/capacity';
  }
}
