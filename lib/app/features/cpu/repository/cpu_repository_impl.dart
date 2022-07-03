import 'dart:io';

import 'package:kernel_manager/app/features/cpu/model/cpu_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'cpu_repository.dart';

class CpuRepositoryImpl extends CpuRepository {
  @override
  Future<CpuModel> getCpu() async {
    return CpuModel(
        numberOfCores: Platform.numberOfProcessors,
        architecture: "",
        process: '7nm',
        coreStructure: [[]],
        name: "SM8150",
        cores: []);
  }
}

final cpuRepositoryProvider = Provider<CpuRepository>((ref) {
  return CpuRepositoryImpl();
});
