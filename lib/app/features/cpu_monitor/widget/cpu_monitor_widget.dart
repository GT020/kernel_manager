import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/widget/core_monitor_widget.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/widget/frequency_history_widget.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/model/cpu_monitor_model.dart';

class CpuMonitorWidget extends StatelessWidget {
  final CpuMonitorModel cpu;
  const CpuMonitorWidget({final Key? key, required this.cpu}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return ListView(
      children: [
        Card(child: Text(cpu.name)),
        Card(child: Text(' ${cpu.architecture}')),
        Card(child: Text(' ${cpu.fabrication}')),
        ...cpu.coreMonitors
            .map((final core) => Card(child: CoreMonitorWidget(core: core)))
            .toList(),
      ],
    );
  }
}
