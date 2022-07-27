import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/ram_monitor/model/ram_monitor_model.dart';
import 'package:penguin_kernel_manager/app/features/ram_monitor/widget/ram_stats_widget.dart';

class RamMonitorWidget extends StatelessWidget {
  final RamMonitorModel ram;
  const RamMonitorWidget({final Key? key, required this.ram}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return ListView(
      children: [
        Text(ram.totalCapacity),
        RamStatsWidget(node: ram.ramUsageNode),
      ],
    );
  }
}
