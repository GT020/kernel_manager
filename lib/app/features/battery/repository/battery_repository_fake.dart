import 'package:penguin_kernel_manager/app/features/battery/model/battery_model.dart';

import 'package:penguin_kernel_manager/app/features/battery/repository/battery_repository.dart';

class BatteryRepositoryFake extends BatteryRepository {
  @override
  Future<BatteryModel> getBattery() {
    throw UnimplementedError();
  }
}
