import 'package:kernel_manager/app/features/cpu/model/core_model.dart';

class CpuModel {
  final String name;
  final int numberOfCores;
  final String architecture;
  final String process;
  final List<List<int>> coreStructure;
  final List<CpuCore> cores;

  CpuModel(
      {required this.numberOfCores,
      required this.architecture,
      required this.process,
      required this.coreStructure,
      required this.name,
      required this.cores});
}
