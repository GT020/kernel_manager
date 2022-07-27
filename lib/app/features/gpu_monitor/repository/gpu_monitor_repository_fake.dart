import 'package:penguin_kernel_manager/app/features/gpu_monitor/model/gpu_monitor_model.dart';

import 'package:penguin_kernel_manager/app/features/gpu_monitor/repository/gpu_monitor_repository.dart';

class GpuRepositoryFake extends GpuRepository {
  @override
  Future<GpuMonitorModel> getGpu() {
    // TODO: implement getGpu
    throw UnimplementedError();
  }
}
