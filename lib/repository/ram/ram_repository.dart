import 'package:kernel_manager/models/ram_model.dart';
import 'package:kernel_manager/providers/ram_providers/total_ram_provider.dart';

abstract class RamRepository {
  Future<Ram> getRam();
}

class RamRepositoryAndroid extends RamRepository {
  @override
  Future<Ram> getRam() async {
    return Ram(await TotalMemoryProviderAndroid().getTotalMemory(), ' ', ' ');
  }
}
