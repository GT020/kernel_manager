import 'dart:io';

import 'package:penguin_kernel_manager/app/features/cpu_monitor/model/core_monitor_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/providers/core_monitor_providers.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/providers/core_monitor_providers_android.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/providers/cpu_monitor_providers.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

class CpuMonitorProvidersAndroidImpl extends CpuMonitorProviders {
  final RegExp arcRegex = RegExp(
    r'(?<=Processor	: )(.*)(?=\n)',
  );

  final RegExp cpuNameRegex = RegExp(
    r'(?<=Hardware	: )(.*)(?=\n)',
  );

  @override
  Future<String> getArchitecture() async {
    final String procInfo = await ReadUtil.ioRead('/proc/cpuinfo');

    final String? arch = arcRegex.firstMatch(procInfo)?.group(0);

    return arch ?? 'Unknown';
  }

  @override
  Future<List<CoreMonitorModel>> getCoreMonitors() async {
    final CoreMonitorProviders coreMonitorProviders =
        CoreMonitorProvidersAndroid();

    final uniqueCoreList = await getCoreStructure();

    final List<CoreMonitorModel> coreMonitors = [];
    for (final int coreNumber in uniqueCoreList) {
      final CoreMonitorModel coreMonitorModel = CoreMonitorModel(
        coreNumber: coreNumber,
        currentFrequencyNode:
            await coreMonitorProviders.getCurrentFrequencyNode(coreNumber),
        currentTemperatureNode:
            await coreMonitorProviders.getCurrentTemperatureNode(coreNumber),
        currentGovernorNode:
            await coreMonitorProviders.getCurrentGovernorNode(coreNumber),
        states: await coreMonitorProviders.getStates(coreNumber),
        maxFrequency: await coreMonitorProviders.getMaxFrequency(coreNumber),
        minFrequency: await coreMonitorProviders.getMinFrequency(coreNumber),
      );
      coreMonitors.add(coreMonitorModel);
    }

    return coreMonitors;
  }

  @override
  Future<String> getCpuName() async {
    final String procInfo = await ReadUtil.ioRead('/proc/cpuinfo');
    final String? name = cpuNameRegex.firstMatch(procInfo)?.group(0);

    return name ?? 'Unknown';
  }

  @override
  Future<String> getFabrication() async {
    return 'Unknown';
  }

  @override
  Future<String> getNumberOfCores() async {
    return Platform.numberOfProcessors.toString();
  }

  /// this is required for getting cores
  Future<List<int>> getCoreStructure() async {
    final Map<String, int> uniqueCoresMap = {};
    final List<int> uniqueCoresList = [];

    for (int coreNum = 0; coreNum < Platform.numberOfProcessors; coreNum++) {
      uniqueCoresMap[await ReadUtil.ioRead(
        '/sys/devices/system/cpu/cpu$coreNum/cpufreq/scaling_available_frequencies',
      )] = coreNum;
    }

    uniqueCoresMap.forEach((final key, final value) {
      uniqueCoresList.add(value);
    });

    return uniqueCoresList;
  }
}
