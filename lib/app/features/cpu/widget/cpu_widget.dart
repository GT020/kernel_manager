import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/cpu/model/cpu_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/core_widget.dart';

class CpuWidget extends StatelessWidget {
  final CpuModel cpu;
  const CpuWidget({Key? key, required this.cpu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Architecture : ${cpu.architecture}'),
          )),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Model : ${cpu.name}'),
          )),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Fabrication Node : ${cpu.process}'),
          )),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Number of Cores : ${cpu.numberOfCores}"),
          )),
          ...cpu.cores.map((core) => Card(child: CoreWidget(core: core))),
        ],
      ),
    );
  }
}
