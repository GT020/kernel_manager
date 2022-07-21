import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/gpu/model/gpu_model.dart';
import 'package:penguin_kernel_manager/app/features/gpu/widget/gpu_frequency_widget.dart';
import 'package:penguin_kernel_manager/app/features/gpu/widget/gpu_governor_widget.dart';
import 'package:penguin_kernel_manager/app/features/gpu/widget/gpu_live_frequency_widget.dart';

class GpuWidget extends StatelessWidget {
  final GpuModel gpu;

  /// Gpu Widget
  const GpuWidget({
    final Key? key,
    required this.gpu,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Gpu : ${gpu.name}'),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GpuLiveFrequencyWidget(
              gpuCurrentFrequencyNode: gpu.currentFrequencyNode,
            ),
          ),
        ),
        GpuFrequencyWidget(availableFrequencies: gpu.availableFrequencies),
        GpuGovernorWidget(availableGovernors: gpu.availableGovernors),
      ],
    );
  }
}
