import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/cpu/model/cpu_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/core_widget.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/frequency_history_widget.dart';

class CpuWidget extends StatelessWidget {
  final CpuModel cpu;
  const CpuWidget({Key? key, required this.cpu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(cpu.architecture),
          Text(cpu.name),
          Text(cpu.process),
          Text(cpu.numberOfCores.toString()),
          ...cpu.cores.map((core) => CoreWidget(core: core)),
        ],
      ),
    );
  }
}
