import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/cpu/model/core_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/frequency_history_widget.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/frequency_widget.dart';

class CoreWidget extends StatelessWidget {
  final CpuCore core;
  const CoreWidget({Key? key, required this.core}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
            title: FrequencyWidget(frequencyNode: core.currentFrequencyNode),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FrequencyHistory(history: core.state),
              )
            ]),
      ],
    );
  }
}