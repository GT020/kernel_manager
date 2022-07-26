import 'package:penguin_kernel_manager/app/features/cpu_monitor/model/cpu_monitor_model.dart';

abstract class CpuMonitorRepository {
  Future<CpuMonitorModel> getCpuMonitor();
}
