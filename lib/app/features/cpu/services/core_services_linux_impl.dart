import 'package:kernel_manager/app/features/cpu/services/core_services.dart';

class CoreServiceLinux implements CoreServices {
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
