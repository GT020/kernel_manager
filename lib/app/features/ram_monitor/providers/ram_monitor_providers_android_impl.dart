import 'package:penguin_kernel_manager/app/features/ram_monitor/providers/ram_monitor_providers.dart';

class RamMonitorProvidersAndroid extends RamMonitorProviders {
  @override
  Future<String> getRamUsageNode() async {
    return '/proc/meminfo';
  }

  @override
  Future<String> getTotalRam() async {
    return "8.0";
  }
}
