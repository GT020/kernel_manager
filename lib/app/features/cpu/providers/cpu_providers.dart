import 'package:kernel_manager/app/features/cpu/model/core_model.dart';

abstract class CpuProviders {
  Future<String> getCpuArchitecture();
  Future<String> getCpuBuildProcess();
  Future<List<CpuCore>> getCpuCores(List<List<int>> coreStructure);
  Future<List<List<int>>> getCoreStructure();
  Future<String> getCpuName();
}
