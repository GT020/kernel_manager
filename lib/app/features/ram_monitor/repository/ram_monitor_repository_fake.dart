import 'package:penguin_kernel_manager/app/features/ram_monitor/model/ram_monitor_model.dart';

import 'package:penguin_kernel_manager/app/features/ram_monitor/repository/ram_monitor_repository.dart';

class RamMonitorRepositoryFake extends RamMonitorRepository {
  @override
  Future<RamMonitorModel> getRamMonitorModel() {
    throw UnimplementedError();
  }
}
