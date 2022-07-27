import 'package:penguin_kernel_manager/app/features/cpu_monitor/model/core_monitor_model.dart';

class CpuMonitorModel {
  final String name;
  final String numberOfCores;
  final String architecture;
  final String fabrication;
  final List<CoreMonitorModel> coreMonitors;
  CpuMonitorModel({
    required this.name,
    required this.numberOfCores,
    required this.architecture,
    required this.fabrication,
    required this.coreMonitors,
  });
}
