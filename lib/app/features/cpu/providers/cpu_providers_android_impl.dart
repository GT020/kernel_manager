import 'dart:io';

import 'package:penguin_kernel_manager/app/features/cpu/model/core_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu/providers/core_providers.dart';
import 'package:penguin_kernel_manager/app/features/cpu/providers/core_providers_android_impl.dart';
import 'package:penguin_kernel_manager/app/features/cpu/providers/cpu_providers.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

class CpuProviderAndroid implements CpuProviders {
  RegExp arcRegex = RegExp(
    r'(?<=Processor	: )(.*)(?=\n)',
  );
  RegExp cpuNameRegex = RegExp(
    r'(?<=Hardware	: )(.*)(?=\n)',
  );

  late final CoreProviders coreProviders;
  CpuProviderAndroid() {
    coreProviders = CoreProviderAndroid();
  }
  @override
  Future<List<List<int>>> getCoreStructure() async {
    //TODO improve the logic and use better algorithm to get the core structure
    int cluster = 0;
    final List<List<int>> cpuMask = [];
    final List<String> availableFrequenciesOfCores = [];
    for (int coreNum = 0; coreNum < Platform.numberOfProcessors; coreNum++) {
      availableFrequenciesOfCores.add(
        await ReadUtil.ioRead(
          '/sys/devices/system/cpu/cpu$coreNum/cpufreq/scaling_available_frequencies',
        ),
      );
    }

    for (int coreNumber = 0;
        coreNumber < Platform.numberOfProcessors;
        coreNumber++) {
      if (coreNumber == 0) {
        cpuMask.add([coreNumber]);
      } else {
        if (availableFrequenciesOfCores[coreNumber] ==
            availableFrequenciesOfCores[coreNumber - 1]) {
          cpuMask[cluster].add(coreNumber);
        } else {
          cpuMask.add([coreNumber]);
          cluster++;
        }
      }
    }

    return cpuMask;
  }

  @override
  Future<String> getCpuArchitecture() async {
    final String procInfo = await ReadUtil.ioRead('/proc/cpuinfo');

    final String? arch = arcRegex.firstMatch(procInfo)?.group(0);

    return arch ?? 'Unknown';
  }

  @override
  Future<String> getCpuBuildProcess() async {
    return 'Not Implemented';
  }

  @override
  Future<List<CpuCore>> getCpuCores(final List<List<int>> coreStructure) async {
    final List<CpuCore> cpuCores = [];
    for (final List<int> cluster in coreStructure) {
      cpuCores.add(
        CpuCore(
          await coreProviders.getAvailableFrequencies(cluster.first),
          cluster.first,
          await coreProviders.getCoreFrequency(cluster.first),
          await coreProviders.getAvailableGovernor(cluster.first),
          await coreProviders.getCoreStates(cluster.first),
        ),
      );
    }

    return cpuCores;
  }

  @override
  Future<String> getCpuName() async {
    final String procInfo = await ReadUtil.ioRead('/proc/cpuinfo');
    final String? name = cpuNameRegex.firstMatch(procInfo)?.group(0);

    return name ?? 'Unknown';
  }
}
