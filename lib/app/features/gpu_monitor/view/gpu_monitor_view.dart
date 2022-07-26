import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/model/gpu_monitor_model.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/repository/gpu_monitor_repository_impl.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/widget/gpu_monitor_widget.dart';

final FutureProvider<GpuMonitorModel> gpuProvider = FutureProvider((final ref) {
  return ref.read(gpuRepositoryProvider).getGpu();
});

class GpuMonitorView extends ConsumerWidget {
  const GpuMonitorView({final Key? key}) : super(key: key);

  static const routeName = '/gpu';

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<GpuMonitorModel> asyncGpu = ref.watch(gpuProvider);

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
