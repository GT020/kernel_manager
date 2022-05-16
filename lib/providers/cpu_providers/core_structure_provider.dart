import 'dart:io';

import 'package:kernel_manager/utils/read_utils.dart';

abstract class CoreStructureProvider {
  Future<List<List<int>>> getCoreStructure();
}

//TODO improve the logic and use better algorithm

class CoreStructureProviderByCompare extends CoreStructureProvider {
  @override
  Future<List<List<int>>> getCoreStructure() async {
    int cluster = 0;
    List<List<int>> cpuMask = [];
    List<String> availableFrequenciesOfCores = [];
    for (int i = 0; i < Platform.numberOfProcessors; i++) {
      availableFrequenciesOfCores.add(await ReadUtil.ioRead(
          '/sys/devices/system/cpu/cpu$i/cpufreq/scaling_available_frequencies'));
    }

    for (int i = 0; i < Platform.numberOfProcessors; i++) {
      if (i == 0) {
        cpuMask.add([i]);
      } else {
        if (availableFrequenciesOfCores[i] ==
            availableFrequenciesOfCores[i - 1]) {
          cpuMask[cluster].add(i);
        } else {
          cpuMask.add([i]);
          cluster++;
        }
      }
    }

    return cpuMask;
  }
}
