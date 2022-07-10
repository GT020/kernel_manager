import 'package:penguin_kernel_manager/app/features/cpu/providers/core_providers.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

class CoreProviderAndroid implements CoreProviders {
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
    return '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/scaling_cur_freq';
  }

  @override
  Future<Map<double, double>> getCoreStates(int coreNumber) async {
    //TODO: factor in deepsleep
    Map<double, double> coreStates = {};
    String state = await ReadUtil.ioRead(
        '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/stats/time_in_state');
    List<String> listStates = state.split("\n");
    for (String st in listStates) {
      if (st.isEmpty) {
        continue;
      }
      List<String> list = st.split(" ");
      double freq = double.parse(list[0]) / 1000;
      double time = double.parse(list[1]);
      coreStates[freq] = time;
    }

    return coreStates;
  }
}
