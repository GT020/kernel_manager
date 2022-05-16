import 'package:kernel_manager/utils/read_utils.dart';

abstract class GpuFrequencyProvider {
  Future<List<int>> getGpuFrequencies();
}

class GpuFrequencyProviderDefault extends GpuFrequencyProvider {
  @override
  Future<List<int>> getGpuFrequencies() async {
    String availableFrequencies = await ReadUtil.ioRead(
        '/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies');
    List<int> intF = [];

    List<String> a = availableFrequencies.trim().split(" ");
    for (String freq in a) {
      intF.add(int.parse(freq));
    }
    return intF;
  }
}
