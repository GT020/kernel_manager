import 'package:kernel_manager/utils/read_utils.dart';

abstract class BatteryHealthProvider {
  Future<String> getBatteryHealth();
}

class BatteryHealthProviderAndroid extends BatteryHealthProvider {
  @override
  Future<String> getBatteryHealth() {
    return ReadUtil.ioRead('/sys/class/power_supply/battery/health');
  }
}
