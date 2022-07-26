import 'package:penguin_kernel_manager/app/features/gpu_monitor/model/gpu_monitor_model.dart';

abstract class GpuRepository {
  Future<GpuMonitorModel> getGpu();
}
