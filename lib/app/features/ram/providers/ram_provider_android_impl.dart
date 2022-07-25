import 'package:penguin_kernel_manager/app/features/ram/providers/ram_providers.dart';

class RamProviderAndroid extends RamProvider {
  @override
  Future<double> getTotalCapacity() async {
    return 8000000.0;
  }

  @override
  Future<String> getUsedRamNode() async {
    return 'proc/meminfo';
  }

  @override
  Future<String> getZramNode() async {
    return '/sys/block/zram0/disksize';
  }
}
