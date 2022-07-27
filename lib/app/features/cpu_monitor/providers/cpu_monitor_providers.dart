import 'package:penguin_kernel_manager/app/features/cpu_monitor/model/core_monitor_model.dart';

abstract class CpuMonitorProviders {
  Future<String> getCpuName();
  Future<String> getNumberOfCores();
  Future<String> getArchitecture();
  Future<String> getFabrication();
  Future<List<CoreMonitorModel>> getCoreMonitors();
}
