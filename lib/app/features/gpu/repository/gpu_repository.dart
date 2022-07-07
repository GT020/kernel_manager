import 'package:penguin_kernel_manager/app/features/gpu/model/gpu_model.dart';

abstract class GpuRepository {
  Future<GpuModel> getGpu();
}
