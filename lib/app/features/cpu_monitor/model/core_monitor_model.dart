import 'package:penguin_kernel_manager/app/features/cpu_monitor/model/core_state_model.dart';

class CoreMonitorModel {
  final int coreNumber;
  final double minFrequency;
  final double maxFrequency;
  final String currentFrequencyNode;
  final String currentTemperatureNode;
  final String currentGovernorNode;
  final List<CoreStateModel> states;
  CoreMonitorModel({
    required this.coreNumber,
    required this.currentFrequencyNode,
    required this.currentTemperatureNode,
    required this.currentGovernorNode,
    required this.states,
    required this.minFrequency,
    required this.maxFrequency,
  });
}
