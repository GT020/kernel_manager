import 'package:penguin_kernel_manager/app/features/battery_monitor/model/battery_model.dart';

import 'package:penguin_kernel_manager/app/features/battery_monitor/repository/battery_monitor_repository.dart';

class BatteryRepositoryFake extends BatteryRepository {
  @override
  Future<BatteryMonitorModel> getBattery() {
    throw UnimplementedError();
  }
}
