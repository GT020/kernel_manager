import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/ram/model/ram_model.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';
import 'package:penguin_kernel_manager/app/utils/root_utils.dart';

final ramStreamProvider = StreamProvider.family<String, String>(
  (final Ref ref, final node) {
    return ReadUtil.catStream(node);
  },
);

class RamWidget extends StatelessWidget {
  final RamModel ram;
  const RamWidget({final Key? key, required this.ram}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer(
        builder: (final context, final ref, final child) {
          final AsyncValue<String> asyncRam =
              ref.watch(ramStreamProvider(ram.usedRamNode));

          return ListView(
            children: [
              ...asyncRam.value!.split('\n').map((final line) {
                return Card(child: Text(line));
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
