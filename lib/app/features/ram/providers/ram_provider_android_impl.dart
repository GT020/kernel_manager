import 'package:penguin_kernel_manager/app/features/ram/providers/ram_providers.dart';

class RamProviderAndroid extends RamProvider {
  @override
  Future<double> getTotalCapacity() {
    // TODO: implement getTotalCapacity
    throw UnimplementedError();
  }

  @override
  Future<String> getUsedRamNode() {
    // TODO: implement getUsedRamNode
    throw UnimplementedError();
  }

  @override
  Future<String> getZramNode() {
    // TODO: implement getZramNode
    throw UnimplementedError();
  }
}
