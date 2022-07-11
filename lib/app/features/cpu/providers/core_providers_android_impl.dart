import 'dart:io';

import 'package:penguin_kernel_manager/app/features/cpu/model/core_state_model.dart';
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
  Future<List<CoreStateModel>> getCoreStates(int coreNumber) async {
    /// return a list of CoreStateModel
    /// each element of the list is a CoreStateModel for a core

    //list for coreStates
    final List<CoreStateModel> coreStates = [];

    //get total uptime of system
    double totalUptime = await getUptime();

    //to get the time state of frequencies
    String state = await ReadUtil.ioRead(
        '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/stats/time_in_state');

    // date comes in the format of: frequency time /n then frequency time /n etc.

    //split the string into a list of strings: frequency time
    List<String> listStates = state.split("\n");

    for (String st in listStates) {
      if (st.isEmpty) {
        continue;
      }
      //split string to frequency and time
      List<String> list = st.split(" ");
      // get the frequency but as string to avoid multiple interpolation from and to string
      String freq = list[0];
      // parse the time to double
      double time = double.parse(list[1]);
      // we calculate the percentage of time the

      final double percentage = (time / totalUptime);
      coreStates.add(CoreStateModel(freq, time, percentage));
    }
    // return the list of coreStates
    return coreStates;
  }

  Future<double> getUptime() async {
    late final double uptime;
    String uptString =
        await Process.run('uptime', ['-s']).then((value) => value.stdout);
    if (uptString.isNotEmpty) {
      uptString = uptString.substring(0, uptString.length - 1);
    }

    final DateTime uptimeDateTime = DateTime.parse(uptString);
    var currentDate = DateTime.now();
    uptime = currentDate.difference(uptimeDateTime).inSeconds.toDouble();

    return uptime;
  }
}
