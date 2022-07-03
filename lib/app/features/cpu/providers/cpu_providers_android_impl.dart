import 'dart:io';

import 'package:kernel_manager/app/features/cpu/model/core_model.dart';
import 'package:kernel_manager/app/features/cpu/providers/core_providers.dart';
import 'package:kernel_manager/app/features/cpu/providers/core_providers_android_impl.dart';
import 'package:kernel_manager/app/features/cpu/providers/cpu_providers.dart';
import 'package:kernel_manager/app/utils/read_utils.dart';

class CpuProviderAndroid implements CpuProviders {
  RegExp arcRegex = RegExp(
    r"(?<=Processor	: )(.*)(?=\n)",
  );
  RegExp cpuNameRegex = RegExp(
    r"(?<=Hardware	: )(.*)(?=\n)",
  );

  late final CoreProviders coreProviders;
  CpuProviderAndroid() {
    coreProviders = CoreProviderAndroid();
  }
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
  Future<List<CpuCore>> getCpuCores(List<List<int>> coreStructure) async {
    List<CpuCore> cpuCores = [];
    //TODO: since we know core from same cluster have same frequencies and same governors we need to optimize this logic
    for (List<int> cluster in coreStructure) {
      for (int core in cluster) {
        cpuCores.add(CpuCore(
            await coreProviders.getAvailableFrequencies(core),
            core,
            await coreProviders.getCoreFrequency(core),
            await coreProviders.getAvailableGovernor(core)));
      }
    }
    return cpuCores;
  }

  @override
  Future<String> getCpuName() async {
    String procInfo = await ReadUtil.ioRead('/proc/cpuinfo');
    String? name = cpuNameRegex.firstMatch(procInfo)?.group(0);

    return name ?? "Unknown";
  }
}
