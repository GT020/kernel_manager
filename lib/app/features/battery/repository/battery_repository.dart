import 'package:penguin_kernel_manager/app/features/battery/model/battery_model.dart';

abstract class BatteryRepository {
  Future<BatteryModel> getBattery();
}
