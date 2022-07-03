import 'package:kernel_manager/app/features/cpu/model/cpu_model.dart';

abstract class CpuRepository {
  Future<CpuModel> getCpu();
}
