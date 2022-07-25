import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/ram/model/ram_model.dart';
import 'package:penguin_kernel_manager/app/features/ram/providers/ram_provider_android_impl.dart';
import 'package:penguin_kernel_manager/app/features/ram/providers/ram_providers.dart';
import 'ram_repository.dart';

class RamRepositoryImpl extends RamRepository {
  late final RamProvider ramProvider;
  RamRepositoryImpl() {
    if (Platform.isAndroid) {
      ramProvider = RamProviderAndroid();
    }
  }
  @override
  Future<RamModel> getRam() async {
    return RamModel(
      totalCapacity: await ramProvider.getTotalCapacity(),
      zramNode: await ramProvider.getZramNode(),
      usedRamNode: await ramProvider.getUsedRamNode(),
    );
  }
}

final ramRepositoryProvider = Provider<RamRepository>((final ref) {
  return RamRepositoryImpl();
});
