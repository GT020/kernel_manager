import 'package:kernel_manager/utils/read_utils.dart';

abstract class GpuAvailableGovernorProvider {
  Future<List<String>> getGpuAvailableGovernors();
}

class GpuAvailableGovernorProviderDefault extends GpuAvailableGovernorProvider {
  @override
  Future<List<String>> getGpuAvailableGovernors() async {
    List<String> availableGovernor = (await ReadUtil.ioRead(
            '/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies'))
        .split(' ');
    return availableGovernor;
  }
}
