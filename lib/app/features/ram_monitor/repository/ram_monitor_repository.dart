import 'package:penguin_kernel_manager/app/features/ram_monitor/model/ram_monitor_model.dart';

abstract class RamMonitorRepository {
  Future<RamMonitorModel> getRamMonitorModel();
}
