import 'package:kernel_manager/utils/read_utils.dart';

abstract class BatteryTechnologyProvider {
  Future<String> getBatteryTechnology();
}

class BatteryTechnologyProviderAndroid extends BatteryTechnologyProvider {
  @override
  Future<String> getBatteryTechnology() {
    return ReadUtil.ioRead('/sys/class/power_supply/battery/technology');
  }
}
