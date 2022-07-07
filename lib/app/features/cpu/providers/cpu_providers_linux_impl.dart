import 'package:penguin_kernel_manager/app/features/cpu/model/core_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu/providers/cpu_providers.dart';

class CpuProviderLinux implements CpuProviders {
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
