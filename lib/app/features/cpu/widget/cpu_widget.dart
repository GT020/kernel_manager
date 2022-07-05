import 'package:flutter/material.dart';
import 'package:kernel_manager/app/features/cpu/model/cpu_model.dart';
import 'package:kernel_manager/app/features/cpu/widget/core_widget.dart';

class CpuWidget extends StatelessWidget {
  final CpuModel cpu;
  const CpuWidget({Key? key, required this.cpu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(cpu.architecture),
        Text(cpu.name),
        Text(cpu.process),
        Text(cpu.numberOfCores.toString()),
        CoreWidget(core: cpu.cores[0])
      ],
    );
  }
}
