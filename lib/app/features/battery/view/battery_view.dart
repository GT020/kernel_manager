import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/battery/model/battery_model.dart';
import 'package:penguin_kernel_manager/app/features/battery/repository/battery_repository_impl.dart';
import 'package:penguin_kernel_manager/app/features/battery/widget/battery_widget.dart';

final batteryProvider = FutureProvider<BatteryModel>((ref) async {
  return await ref.read(batteryRepositoryProvider).getBattery();
});

class BatteryView extends ConsumerWidget {
  const BatteryView({Key? key}) : super(key: key);

  static const routeName = '/battery';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<BatteryModel> asyncBattery = ref.watch(batteryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery'),
      ),
      body: asyncBattery.when(
          data: (battery) {
            return BatteryWidget(battery: battery);
          },
          error: (e, s) {
            return Text(e.toString());
          },
          loading: () => const LinearProgressIndicator()),
    );
  }
}
