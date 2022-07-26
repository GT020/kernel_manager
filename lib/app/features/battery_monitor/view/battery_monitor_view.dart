import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/battery_monitor/model/battery_model.dart';
import 'package:penguin_kernel_manager/app/features/battery_monitor/repository/battery_monitor_repository_impl.dart';
import 'package:penguin_kernel_manager/app/features/battery_monitor/widget/battery_monitor_widget.dart';

final batteryProvider = FutureProvider<BatteryMonitorModel>((final ref) async {
  return ref.read(batteryRepositoryProvider).getBattery();
});

class BatteryMonitor extends ConsumerWidget {
  const BatteryMonitor({final Key? key}) : super(key: key);

  static const routeName = '/battery';

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<BatteryMonitorModel> asyncBattery =
        ref.watch(batteryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery'),
      ),
      body: asyncBattery.when(
        data: (final battery) {
          return BatteryWidget(battery: battery);
        },
        error: (final e, final s) {
          return Text(e.toString());
        },
        loading: () => const LinearProgressIndicator(),
      ),
    );
  }
}
