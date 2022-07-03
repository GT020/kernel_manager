import 'package:kernel_manager/app/features/cpu/model/core_model.dart';
import 'package:kernel_manager/app/features/cpu/services/cpu_services.dart';

class CpuServiceLinux implements CpuServices {
  @override
  Future<List<List<int>>> getCoreStructure() {
    // TODO: implement getCoreStructure
    throw UnimplementedError();
  }

  @override
  Future<String> getCpuArchitecture() {
    // TODO: implement getCpuArchitecture
    throw UnimplementedError();
  }

  @override
  Future<String> getCpuBuildProcess() {
    // TODO: implement getCpuBuildProcess
    throw UnimplementedError();
  }

  @override
  Future<List<CpuCore>> getCpuCores(List<List<int>> coreStructure) {
    // TODO: implement getCpuCores
    throw UnimplementedError();
  }

  @override
  Future<String> getCpuName() {
    // TODO: implement getCpuName
    throw UnimplementedError();
  }
}
