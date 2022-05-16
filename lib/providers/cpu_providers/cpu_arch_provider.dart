import 'package:kernel_manager/utils/read_utils.dart';

abstract class CpuArchitectureProvider {
  Future<String> getCpuArchitecture();
}

class CpuArchitectureProviderAndroid extends CpuArchitectureProvider {
  RegExp arcRegex = RegExp(
    r"(?<=Processor	: )(.*)(?=\n)",
  );
  @override
  Future<String> getCpuArchitecture() async {
    String procInfo = await ReadUtil.ioRead('/proc/cpuinfo');

    String? arch = arcRegex.firstMatch(procInfo)?.group(0);

    return arch ?? "Unknown";
  }
}
