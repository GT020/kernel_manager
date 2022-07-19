import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/gpu/model/gpu_model.dart';
import 'package:penguin_kernel_manager/app/features/gpu/repository/gpu_repository_impl.dart';
import 'package:penguin_kernel_manager/app/features/gpu/widget/gpu_widget.dart';

final FutureProvider<GpuModel> gpuProvider = FutureProvider((final ref) {
  return ref.read(gpuRepositoryProvider).getGpu();
});

class GpuView extends ConsumerWidget {
  const GpuView({final Key? key}) : super(key: key);

  static const routeName = '/gpu';

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<GpuModel> asyncGpu = ref.watch(gpuProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GPU'),
      ),
      body: asyncGpu.when(
        data: (final gpu) {
          return GpuWidget(gpu: gpu);
        },
        error: (final e, final s) {
          return Text(e.toString());
        },
        loading: () => const LinearProgressIndicator(),
      ),
    );
  }
}
