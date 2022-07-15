import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

final batteryPercentageProvider =
    StreamProvider.family<String, String>((ref, percentageNode) {
  return ReadUtil.readStream(percentageNode, interval: 5000);
});

class BatteryPercentageWidget extends ConsumerWidget {
  final String batteryPercentageNode;
  const BatteryPercentageWidget({Key? key, required this.batteryPercentageNode})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<String> asyncBatteryPercentage =
        ref.watch(batteryPercentageProvider(batteryPercentageNode));
    return asyncBatteryPercentage.when(
        data: (percentage) {
          return Text(percentage);
        },
        error: (e, s) {
          return Text(e.toString());
        },
        loading: () => const Text('..'));
  }
}
