import 'package:kernel_manager/app/features/cpu/providers/core_providers.dart';

class CoreProviderLinux implements CoreProviders {
  @override
  Future<List<int>> getAvailableFrequencies(int coreNumber) {
    // TODO: implement getAvailableFrequencies
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getAvailableGovernor(int coreNumber) {
    // TODO: implement getAvailableGovernor
    throw UnimplementedError();
  }

  @override
  Future<String> getCoreFrequency(int coreNumber) {
    // TODO: implement getCoreFrequency
    throw UnimplementedError();
  }
}