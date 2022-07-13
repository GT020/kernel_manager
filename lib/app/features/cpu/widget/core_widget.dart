import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/cpu/model/core_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/frequency_history_widget.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/frequency_widget.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/live_frequency_chart_widget.dart';

class CoreWidget extends StatelessWidget {
  final CpuCore core;

  const CoreWidget({Key? key, required this.core}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(
          'Core Number ${core.coreNumber} ',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: FrequencyWidget(frequencyNode: core.currentFrequencyNode),
        trailing: LiveFrequencyGraphWidget(
            color: Theme.of(context).primaryColor,
            height: 30,
            width: 80,
            currentFrequencyNode: core.currentFrequencyNode,
            maxFrequency: core.availableFrequencies.last.toDouble()),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FrequencyHistory(history: core.state),
          )
        ]);
  }
}
