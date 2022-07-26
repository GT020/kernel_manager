import 'package:penguin_kernel_manager/app/features/gpu_monitor/model/gpu_model.dart';

import 'package:penguin_kernel_manager/app/features/gpu_monitor/repository/gpu_repository.dart';

class GpuRepositoryFake extends GpuRepository {
  @override
  Future<GpuMonitorModel> getGpu() {
    // TODO: implement getGpu
    throw UnimplementedError();
  }
}
