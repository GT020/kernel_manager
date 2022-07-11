import 'package:penguin_kernel_manager/app/features/cpu/model/core_state_model.dart';

class CpuCore {
  final int coreNumber;
  final String currentFrequencyNode;
  final List<int> availableFrequencies;
  final List<String> availableGovernor;
  final List<CoreStateModel> state;
  CpuCore(this.availableFrequencies, this.coreNumber, this.currentFrequencyNode,
      this.availableGovernor, this.state);
}
