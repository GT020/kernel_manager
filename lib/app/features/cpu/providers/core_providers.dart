import 'package:penguin_kernel_manager/app/features/cpu/model/core_state_model.dart';

abstract class CoreProviders {
  Future<String> getCoreFrequency(int coreNumber);
  Future<List<double>> getAvailableFrequencies(int coreNumber);
  Future<List<String>> getAvailableGovernor(int coreNumber);
  Future<List<CoreStateModel>> getCoreStates(int coreNumber);
}
