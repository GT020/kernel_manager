import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kernel_manager/models/cpu_model.dart';
import 'package:kernel_manager/providers/cpu_providers/core_provider.dart';
import 'package:kernel_manager/providers/cpu_providers/core_structure_provider.dart';
import 'package:kernel_manager/providers/cpu_providers/cpu_arch_provider.dart';
import 'package:kernel_manager/providers/cpu_providers/cpu_name_provider.dart';

abstract class CpuRepository {
  Future<CPU> getCPU();
}

class CpuRepositoryAndroid extends CpuRepository {
  @override
  Future<CPU> getCPU() async {
    List<List<int>> coreStructure =
        await CoreStructureProviderByCompare().getCoreStructure();
    return CPU(
        numberOfCores: Platform.numberOfProcessors,
        architecture:
            await CpuArchitectureProviderAndroid().getCpuArchitecture(),
        process: '7nm',
        coreStructure: coreStructure,
        name: await CpuNameProviderAndroid().getCpuName(),
        cores:
            await compute(CoresProviderAndroid().getCpuCores, coreStructure));
  }
}
