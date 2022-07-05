import 'package:flutter/material.dart';
import 'package:kernel_manager/app/features/cpu/model/core_model.dart';
import 'package:kernel_manager/app/features/cpu/widget/frequency_widget.dart';

class CoreWidget extends StatelessWidget {
  final CpuCore core;
  const CoreWidget({Key? key, required this.core}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FrequencyWidget(
          frequencyNode: core.currentFrequencyNode,
        ),
      ],
    );
  }
}
