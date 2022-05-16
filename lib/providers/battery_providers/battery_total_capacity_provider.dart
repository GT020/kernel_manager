import 'package:kernel_manager/utils/read_utils.dart';

abstract class BatteryTotalCapacityProvider {
  Future<String> getBatteryTotalCapacity();
}

class BatteryTotalCapacityProviderAndroid extends BatteryTotalCapacityProvider {
  @override
  Future<String> getBatteryTotalCapacity() {
    return ReadUtil.ioRead('/sys/class/power_supply/battery/temp');
  }
}
