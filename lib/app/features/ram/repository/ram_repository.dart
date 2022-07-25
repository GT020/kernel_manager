import 'package:penguin_kernel_manager/app/features/ram/model/ram_model.dart';

abstract class RamRepository {
  Future<RamModel> getRam();
}
