import 'package:penguin_kernel_manager/app/features/cpu/model/core_state_model.dart';

abstract class CoreProviders {
  Future<String> getCoreFrequency(final int coreNumber);
  Future<List<double>> getAvailableFrequencies(final int coreNumber);
  Future<List<String>> getAvailableGovernor(final int coreNumber);
  Future<List<CoreStateModel>> getCoreStates(final int coreNumber);
}
