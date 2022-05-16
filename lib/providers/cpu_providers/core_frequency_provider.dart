abstract class CoreFrequencyProvider {
  String getCoreFrequency(int coreNumber);
}

class CoreFrequencyProviderAndroid extends CoreFrequencyProvider {
  @override
  String getCoreFrequency(int coreNumber) {
    return '/sys/devices/system/cpu/cpu$coreNumber/cpufreq/scaling_cur_freq';
  }
}
