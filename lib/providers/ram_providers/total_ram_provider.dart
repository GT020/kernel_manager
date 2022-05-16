import 'package:kernel_manager/utils/read_utils.dart';

abstract class TotalMemoryProvider {
  Future<double> getTotalMemory();
}

class TotalMemoryProviderAndroid extends TotalMemoryProvider {
  RegExp totalMemRegex = RegExp(
    r"(?<=MemTotal:\s+)[0-9]*(?= kB)",
  );
  @override
  Future<double> getTotalMemory() async {
    final String meminfo = await ReadUtil.ioRead('/proc/meminfo');
    String? totalMem = totalMemRegex.firstMatch(meminfo)?.group(0);
    return double.parse(totalMem!);
  }
}
