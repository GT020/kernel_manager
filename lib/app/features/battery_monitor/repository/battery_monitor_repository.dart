import 'package:penguin_kernel_manager/app/features/battery_monitor/model/battery_monitor_model.dart';

abstract class BatteryRepository {
  Future<BatteryMonitorModel> getBattery();
}
