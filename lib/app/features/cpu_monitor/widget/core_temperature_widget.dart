import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

final temperatureProvider =
    StreamProvider.family.autoDispose<String, String>((final ref, final arg) {
  return ReadUtil.readStream(arg);
});

class CoreTemperatureWidget extends ConsumerWidget {
  final String coreTemperatureNode;
  const CoreTemperatureWidget(this.coreTemperatureNode, {final Key? key})
      : super(key: key);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<String> asyncTemp =
        ref.watch(temperatureProvider(coreTemperatureNode));

    return Text(asyncTemp.value ?? '');
  }
}
