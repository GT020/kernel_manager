import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/cpu/model/core_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/frequency_history_widget.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/frequency_widget.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/live_frequency_chart_widget.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

class CoreWidget extends StatefulWidget {
  final CpuCore core;
  const CoreWidget({final Key? key, required this.core}) : super(key: key);

  @override
  State<CoreWidget> createState() => _CoreWidgetState();
}

class _CoreWidgetState extends State<CoreWidget> {
  late final Stream<String> frequencyStream;

  @override
  void initState() {
    super.initState();
    frequencyStream = ReadUtil.readStream(widget.core.currentFrequencyNode)
        .asBroadcastStream();
  }

  @override
  Widget build(final BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Core Number ${widget.core.coreNumber} ',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: FrequencyWidget(
        frequencyStream: frequencyStream,
        textStyle: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: LiveFrequencyGraphWidget(
        color: Theme.of(context).primaryColor,
        height: 30,
        width: 80,
        currentFrequencyStream: frequencyStream,
        maxFrequency: widget.core.availableFrequencies.last,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FrequencyHistory(history: widget.core.state),
        ),
      ],
    );
  }
}
