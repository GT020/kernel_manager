import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/cpu/model/cpu_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/core_widget.dart';

class CpuWidget extends StatelessWidget {
  final CpuModel cpu;
  const CpuWidget({final Key? key, required this.cpu}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Architecture : ${cpu.architecture}'),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Model : ${cpu.name}'),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Fabrication Node : ${cpu.process}'),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Number of Cores : ${cpu.numberOfCores}'),
            ),
          ),
          ...cpu.cores.map((final core) => Card(child: CoreWidget(core: core))),
        ],
      ),
    );
  }
}
