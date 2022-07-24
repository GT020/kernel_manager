import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/battery/model/battery_model.dart';
import 'package:penguin_kernel_manager/app/features/battery/widget/battery_current_now_widget.dart';
import 'package:penguin_kernel_manager/app/features/battery/widget/battery_percentage_widget.dart';
import 'package:penguin_kernel_manager/app/features/battery/widget/battery_voltage_now_widget.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

final chargingStatusProvider =
    StreamProvider.family<String, String>((final ref, final String node) {
  return ReadUtil.readStream(node);
});

class BatteryWidget extends StatelessWidget {
  final BatteryModel battery;
  const BatteryWidget({final Key? key, required this.battery})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final width = MediaQuery.of(context).size.width - 16;

    return Wrap(
      children: [
        Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer(
                builder: (final context, final ref, final widget) {
                  final asyncChargingStatus =
                      ref.watch(chargingStatusProvider(battery.statusNode));
                  final chargingStatus = asyncChargingStatus.when(
                    data: (final data) => data,
                    error: (final e, final s) => '',
                    loading: () => '',
                  );

                  return Text(
                    'Status : $chargingStatus',
                  );
                },
              ),
            ),
          ),
        ),
        Card(
          child: BatteryPercentageWidget(
            height: 150,
            width: width / 2,
            batteryPercentageNode: battery.percentageNode,
          ),
        ),
        SizedBox(
          height: 158,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Battery Technology${battery.technology}'),
                  Text('Battery Health : ${battery.health}'),
                  Text('Battery TotalCapacity : ${battery.totalCapacity}'),
                ],
              ),
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Max Current : ${battery.currentMax}'),
          ),
        ),
        Card(
          child: BatteryCurrentNowWidget(
            currentNowNode: battery.currentNode,
            currentMax: battery.currentMax,
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Max Voltage : ${battery.voltageMax}'),
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
