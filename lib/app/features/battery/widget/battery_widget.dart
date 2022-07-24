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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              child: BatteryPercentageWidget(
                height: 150,
                width: 150,
                batteryPercentageNode: battery.percentageNode,
              ),
            ),
            SizedBox(
              height: 150,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Battery Technology : ${battery.technology}'),
                      Text('Battery Health : ${battery.health}'),
                      Text('Battery TotalCapacity : ${battery.totalCapacity}'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Card(
          child: Text('Max Current : ${battery.currentMax}'),
        ),
        Card(
          child: BatteryCurrentNowWidget(
            currentNowNode: battery.currentNode,
            currentMax: battery.currentMax,
          ),
        ),
        Card(
          child: Text('Max Voltage : ${battery.voltageMax}'),
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
