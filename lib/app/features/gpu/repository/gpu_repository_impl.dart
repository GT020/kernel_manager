import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'gpu_repository.dart';

class GpuRepositoryImpl extends GpuRepository {
  // TODO add your methods here
}

final gpuRepositoryProvider = Provider<GpuRepository>((ref) {
  return GpuRepositoryImpl();
});
