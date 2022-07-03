import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'cpu_repository.dart';

class CpuRepositoryImpl extends CpuRepository {
  // TODO add your methods here
}

final cpuRepositoryProvider = Provider<CpuRepository>((ref) {
  return CpuRepositoryImpl();
});
