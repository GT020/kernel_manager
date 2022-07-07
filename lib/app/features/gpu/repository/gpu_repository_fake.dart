import 'package:penguin_kernel_manager/app/features/gpu/model/gpu_model.dart';

import 'gpu_repository.dart';

class GpuRepositoryFake extends GpuRepository {
  @override
  Future<GpuModel> getGpu() {
    // TODO: implement getGpu
    throw UnimplementedError();
  }
}
