import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/gpu/model/gpu_model.dart';
import 'package:penguin_kernel_manager/app/features/gpu/repository/gpu_repository_impl.dart';

final FutureProvider<GpuModel> gpuProvider = FutureProvider((ref) {
  return GpuRepositoryImpl().getGpu();
});

class GpuView extends ConsumerWidget {
  const GpuView({Key? key}) : super(key: key);

  static const routeName = '/gpu';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<GpuModel> asyncGpu = ref.watch(gpuProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPU'),
      ),
      body: asyncGpu.when(
          data: (gpu) {
            return Text(gpu.name);
          },
          error: (e, s) {
            return Text(e.toString());
          },
          loading: () => const LinearProgressIndicator()),
    );
  }
}
