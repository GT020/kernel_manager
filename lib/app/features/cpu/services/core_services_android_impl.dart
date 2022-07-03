import 'package:kernel_manager/app/features/cpu/services/core_services.dart';
import 'package:kernel_manager/app/utils/read_utils.dart';

class CoreServiceAndroid implements CoreServices {
  RegExp frequencyRegex = RegExp(
    r"![\d+]",
  );

  @override
  Future<List<int>> getAvailableFrequencies(int coreNumber) async {
    String availableFrequencies = await ReadUtil.ioRead(
        '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/scaling_available_frequencies');
    List<int> intF = [];

    List<String> a = availableFrequencies.trim().split(" ");
    for (String freq in a) {
      intF.add(int.parse(freq));
    }
    return intF;
  }

  @override
  Future<List<String>> getAvailableGovernor(int coreNumber) async {
    List<String> availableGovernor = (await ReadUtil.ioRead(
            '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/scaling_available_governors'))
        .split(' ');

    return availableGovernor;
  }

  @override
  Future<String> getCoreFrequency(int coreNumber) async {
    return await ReadUtil.ioRead(
        '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/scaling_cur_freq');
  }
}
