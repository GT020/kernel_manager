import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/model/gpu_monitor_model.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/widget/gpu_frequency_widget.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/widget/gpu_governor_widget.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/widget/gpu_live_frequency_widget.dart';

class GpuWidget extends StatelessWidget {
  final GpuMonitorModel gpu;

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
              minFrequency: gpu.minFrequency,
              maxFrequency: gpu.maxFrequency,
            ),
          ),
        ),
        GpuFrequencyWidget(availableFrequencies: gpu.availableFrequencies),
        GpuGovernorWidget(availableGovernors: gpu.availableGovernors),
      ],
    );
  }
}
