import 'package:flutter/material.dart';
import 'package:kernel_manager/helper_widgets/consumer_text.dart';
import 'package:kernel_manager/models/battery_model.dart';
import 'package:kernel_manager/repository/battery/battery_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kernel_manager/utils/read_utils.dart';

final batteryProvider = FutureProvider<Battery>((ref) async {
  return await BatteryRepositoryAndroid().getBattery();
});

class BatteryView extends ConsumerWidget {
  const BatteryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Battery> asyncBattery = ref.watch(batteryProvider);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Center(
            child: Text(
              'Battery',
            ),
          ),
        ),
        body: asyncBattery.when(
            data: ((battery) {
              return Wrap(
                children: [
                  Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Health'),
                            Text(battery.health),
                          ],
                        ),
                      )),
                  Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Capacity'),
                            Text(battery.totalCapacity),
                          ],
                        ),
                      )),
                  Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Technology'),
                            Text(battery.technology),
                          ],
                        ),
                      )),
                  Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Current'),
                          ConsumerStreamText(ProviderReadUtil.readIoAsStream(
                              battery.currentNode)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Voltage"),
                          ConsumerStreamText(ProviderReadUtil.readIoAsStream(
                              battery.voltageNode)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Status"),
                          ConsumerStreamText(ProviderReadUtil.readIoAsStream(
                              battery.statusNode)),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
            error: (e, s) {
              return Text(e.toString());
            },
            loading: () => const CircularProgressIndicator()));
  }
}
