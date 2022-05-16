import 'package:kernel_manager/utils/read_utils.dart';

abstract class GpuNameProvider {
  Future<String> getGpuName();
}

class GpuNameProviderDefault extends GpuNameProvider {
  @override
  Future<String> getGpuName() {
    return ReadUtil.ioRead('/sys/kernel/gpu/gpu_model');
  }
}
