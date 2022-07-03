import 'dart:io';

import 'package:kernel_manager/app/features/cpu/model/core_model.dart';
import 'package:kernel_manager/app/features/cpu/services/cpu_services.dart';
import 'package:kernel_manager/app/utils/read_utils.dart';

class CpuServiceAndroid implements CpuServices {
  RegExp arcRegex = RegExp(
    r"(?<=Processor	: )(.*)(?=\n)",
  );

  @override
  Future<List<List<int>>> getCoreStructure() async {
    //TODO improve the logic and use better algorithm to get the core structure
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

  @override
  Future<String> getCpuArchitecture() async {
    String procInfo = await ReadUtil.ioRead('/proc/cpuinfo');

    String? arch = arcRegex.firstMatch(procInfo)?.group(0);

    return arch ?? "Unknown";
  }

  @override
  Future<String> getCpuBuildProcess() async {
    return "Not Implemented";
  }

  @override
  Future<List<CpuCore>> getCpuCores(List<List<int>> coreStructure) {
    // TODO: implement getCpuCores
    throw UnimplementedError();
  }

  @override
  Future<String> getCpuName() {
    // TODO: implement getCpuName
    throw UnimplementedError();
  }
}
