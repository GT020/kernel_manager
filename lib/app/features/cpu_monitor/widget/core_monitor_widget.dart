import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/core/theme/app_theme.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/widget/core_temperature_widget.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/widget/live_frequency_chart_widget.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/model/core_monitor_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/widget/frequency_history_widget.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

class CoreMonitorWidget extends StatelessWidget {
  final CoreMonitorModel core;
  const CoreMonitorWidget({final Key? key, required this.core})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        RepaintBoundary(
          child: LiveFrequencyGraphWidget(
            color: appGreenYellow,
            height: 50,
            width: double.maxFinite,
            currentFrequencyStream:
                ReadUtil.readStream(core.currentFrequencyNode)
                    .asBroadcastStream(),
            maxFrequency: core.maxFrequency,
          ),
        ),
        Text(core.coreNumber.toString()),
        const SizedBox(height: 10),
        RepaintBoundary(child: FrequencyHistoryWidget(history: core.states)),
        RepaintBoundary(
          child: CoreTemperatureWidget(core.currentTemperatureNode),
        ),
      ],
    );
  }
}
