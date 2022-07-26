import 'dart:io';

import 'package:flutter/services.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/model/core_state_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/providers/core_monitor_providers.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

class CoreMonitorProvidersAndroid extends CoreMonitorProviders {
  static const MethodChannel channel = MethodChannel('penguin_kernel_manager');

  @override
  Future<String> getCurrentFrequencyNode(final int coreNumber) async {
    return '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/scaling_cur_freq';
  }

  @override
  Future<String> getCurrentGovernorNode(final int coreNumber) async {
    return '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/scaling_governor';
  }

  @override
  Future<String> getCurrentTemperatureNode(final int coreNumber) async {
    return '/sys/class/thermal/thermal_zone0/temp';
  }

  /// return a list of CoreStateModel
  /// each element of the list is a CoreStateModel for a core
  @override
  Future<List<CoreStateModel>> getStates(final int coreNumber) async {
    //list for coreStates
    final List<CoreStateModel> coreStates = [];

    //get total uptime of system
    final double totalUptime = await getUptime();

    //to get the time state of frequencies
    final String state = await ReadUtil.ioRead(
      '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/stats/time_in_state',
    );

    // date comes in the format of: frequency time /n then frequency time /n etc.

    //split the string into a list of strings: frequency time
    final List<String> listStates = state.split('\n');

    for (final String st in listStates) {
      if (st.isEmpty) {
        continue;
      }
      //split string to frequency and time
      final List<String> list = st.split(' ');
      // get the frequency but as string to avoid multiple interpolation from and to string
      final String freq = list.first;
      // parse the time to double
      final double time = double.parse(list[1]);
      // we calculate the percentage of time the

      final double percentage = time / totalUptime;
      coreStates.add(CoreStateModel(freq, time, percentage));
    }
    //add deep sleep too
    final double deepSleep = await getDeepSleep();
    final double deepSleepPercentage = deepSleep / totalUptime;
    coreStates
        .add(CoreStateModel('Deep Sleep', deepSleep, deepSleepPercentage));

    // return the list of coreStates

    return coreStates;
  }

  Future<double> getUptime() async {
    late final double uptime;
    final ProcessResult processResult = await Process.run('uptime', ['-s']);
    String uptString = processResult.stdout.toString();
    if (uptString.isNotEmpty) {
      uptString = uptString.substring(0, uptString.length - 1);
    }

    final DateTime uptimeDateTime = DateTime.parse(uptString);
    final currentDate = DateTime.now();
    uptime = currentDate.difference(uptimeDateTime).inSeconds.toDouble();

    return uptime;
  }

  Future<double> getDeepSleep() async {
    final int deepSleep =
        (await channel.invokeMethod<int>('getDeepSleep')) ?? 0;

    return deepSleep.toDouble();
  }

  @override
  Future<double> getMaxFrequency(final int coreNumber) async {
    final String maxFrequency = await ReadUtil.cat(
      '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/scaling_max_freq',
    );

    return double.parse(maxFrequency);
  }

  @override
  Future<double> getMinFrequency(final int coreNumber) async {
    final String minFrequency = await ReadUtil.cat(
      '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/scaling_min_freq',
    );

    return double.parse(minFrequency);
  }
}
