import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/utils/root_utils.dart';

final gpuFrequencyStreamProvider =
    StreamProvider.family<String, String>((final ref, final gpuFrequencyNode) {
  return RootUtils.catStream(
    gpuFrequencyNode,
    interval: 1,
  );
});

class GpuLiveFrequencyWidget extends ConsumerWidget {
  final String gpuCurrentFrequencyNode;
  const GpuLiveFrequencyWidget({
    final Key? key,
    required this.gpuCurrentFrequencyNode,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<String> asyncGpuFrequency =
        ref.watch(gpuFrequencyStreamProvider(gpuCurrentFrequencyNode));

    return Text(
      asyncGpuFrequency.value ?? '',
    );
  }
}
