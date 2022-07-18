import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/battery/model/battery_model.dart';
import 'package:penguin_kernel_manager/app/features/battery/widget/battery_current_now_widget.dart';
import 'package:penguin_kernel_manager/app/features/battery/widget/battery_percentage_widget.dart';
import 'package:penguin_kernel_manager/app/features/battery/widget/battery_voltage_now_widget.dart';

class BatteryWidget extends StatelessWidget {
  final BatteryModel battery;
  const BatteryWidget({final Key? key, required this.battery})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Text('Battery Technology : ${battery.technology}'),
        ),
        Card(
          child: Text('Battery Health : ${battery.health}'),
        ),
        Card(
          child: Text('Battery TotalCapacity : ${battery.totalCapacity}'),
        ),
        Card(
          child: BatteryPercentageWidget(
            batteryPercentageNode: battery.percentageNode,
          ),
        ),
        Card(
          child: Text('Max Current : ${battery.currentMax}'),
        ),
        Card(
          child: Text('Max Voltage : ${battery.voltageMax}'),
        ),
        Card(
          child: BatteryCurrentNowWidget(
            currentNowNode: battery.currentNode,
            currentMax: battery.currentMax,
          ),
        ),
        Card(
          child: BatteryVoltageNowWidget(
            voltageNowNode: battery.voltageNode,
            voltageMax: battery.voltageMax,
          ),
        ),
      ],
    );
  }
}
