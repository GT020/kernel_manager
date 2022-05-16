import 'package:kernel_manager/models/cpu_model.dart';
import 'package:kernel_manager/providers/cpu_providers/core_frequency_provider.dart';
import 'package:kernel_manager/utils/read_utils.dart';

abstract class CoresProvider {
  Future<List<CpuCore>> getCpuCores(List<List<int>> coreStructure);
}

class CoresProviderAndroid extends CoresProvider {
  RegExp frequencyRegex = RegExp(
    r"![\d+]",
  );
  @override
  Future<List<CpuCore>> getCpuCores(List<List<int>> coreStructure) async {
    List<CpuCore> cores = [];
    for (List<int> cluster in coreStructure) {
      for (int coreNumber in cluster) {
        String availableFrequencies = await ReadUtil.ioRead(
            '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/scaling_available_frequencies');
        List<int> intF = [];

        List<String> a = availableFrequencies.trim().split(" ");
        for (String freq in a) {
          intF.add(int.parse(freq));
        }
        List<String> availableGovernor = (await ReadUtil.ioRead(
                '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/scaling_available_frequencies'))
            .split(' ');
        cores.add(CpuCore(
            intF,
            coreNumber,
            CoreFrequencyProviderAndroid().getCoreFrequency(coreNumber),
            availableGovernor));
      }
    }

    return cores;
  }
}
