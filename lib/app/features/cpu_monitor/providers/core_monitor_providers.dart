import 'package:penguin_kernel_manager/app/features/cpu_monitor/model/core_state_model.dart';

abstract class CoreMonitorProviders {
  Future<String> getCurrentFrequencyNode(final int coreNumber);
  Future<String> getCurrentTemperatureNode(final int coreNumber);
  Future<String> getCurrentGovernorNode(final int coreNumber);
  Future<List<CoreStateModel>> getStates(final int coreNumber);
  Future<double> getMaxFrequency(final int coreNumber);
  Future<double> getMinFrequency(final int coreNumber);
}
