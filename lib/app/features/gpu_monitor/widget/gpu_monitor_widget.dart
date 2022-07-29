import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/model/gpu_monitor_model.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/widget/gpu_live_frequency_widget.dart';

class GpuMonitorWidget extends StatelessWidget {
  final GpuMonitorModel gpu;

  /// Gpu Widget
  const GpuMonitorWidget({
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
        RepaintBoundary(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GpuLiveFrequencyWidget(
                gpuCurrentFrequencyNode: gpu.currentFrequencyNode,
                minFrequency: gpu.minFrequency,
                maxFrequency: gpu.maxFrequency,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
