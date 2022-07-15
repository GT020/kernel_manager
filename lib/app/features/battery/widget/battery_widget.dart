import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/battery/model/battery_model.dart';
import 'package:penguin_kernel_manager/app/features/battery/widget/battery_percentage_widget.dart';

class BatteryWidget extends StatelessWidget {
  final BatteryModel battery;
  const BatteryWidget({Key? key, required this.battery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Text(battery.technology),
        ),
        Card(
          child: Text(battery.health),
        ),
        Card(
          child: Text(battery.totalCapacity),
        ),
        Card(
          child: BatteryPercentageWidget(
              batteryPercentageNode: battery.percentageNode),
        ),
      ],
    );
  }
}
