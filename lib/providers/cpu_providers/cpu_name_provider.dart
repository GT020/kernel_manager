import 'package:kernel_manager/utils/read_utils.dart';

abstract class CpuNameProvider {
  Future<String> getCpuName();
}

class CpuNameProviderAndroid extends CpuNameProvider {
  RegExp arcRegex = RegExp(
    r"(?<=Hardware	: )(.*)(?=\n)",
  );
  @override
  Future<String> getCpuName() async {
    String procInfo = await ReadUtil.ioRead('/proc/cpuinfo');
    String? name = arcRegex.firstMatch(procInfo)?.group(0);

    return name ?? "Unknown";
  }
}
