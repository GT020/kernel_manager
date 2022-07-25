import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/ram/model/ram_model.dart';
import 'ram_repository.dart';

class RamRepositoryImpl extends RamRepository {
  @override
  Future<RamModel> getRam() {
    // TODO: implement getRam
    throw UnimplementedError();
  }
  // TODO add your methods here
}

final ramRepositoryProvider = Provider<RamRepository>((ref) {
  return RamRepositoryImpl();
});
