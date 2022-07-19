import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/gpu/model/gpu_model.dart';
import 'package:penguin_kernel_manager/app/utils/root_utils.dart';

final gpuFrequencyStreamProvider =
    StreamProvider.family<String, String>((final ref, final gpuFrequencyNode) {
  return RootUtils.catStream(
    gpuFrequencyNode,
    interval: 1,
  );
});

class GpuWidget extends ConsumerWidget {
  final GpuModel gpu;

  /// Gpu Widget
  const GpuWidget({
    final Key? key,
    required this.gpu,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<String> asyncGpuFrequency =
        ref.watch(gpuFrequencyStreamProvider(gpu.currentFrequencyNode));

    return Column(
      children: [
        Text(
          asyncGpuFrequency.when(
            data: (final gpuFrequency) => gpuFrequency,
            error: (final e, final s) => e.toString(),
            loading: () => 'Loading...',
          ),
        ),
        Text(gpu.availableGovernors.join(', ')),
        Text(gpu.availableFrequencies.join(', ')),
      ],
    );
  }
}
