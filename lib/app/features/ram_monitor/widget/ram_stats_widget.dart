import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

final ramStatsProvider =
    StreamProvider.family<String, String>((final ref, final node) {
  return ReadUtil.catStream(node);
});

class RamStatsWidget extends ConsumerWidget {
  final String node;
  const RamStatsWidget({final Key? key, required this.node}) : super(key: key);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<String> ramStats = ref.watch(ramStatsProvider(node));

    return ramStats.when(
      data: (final stats) {
        return Column(
          children: stats
              .split('/n')
              .map(
                (final s) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(child: Text(s)),
                ),
              )
              .toList(),
        );
      },
      error: (final e, final s) => Card(child: Text(e.toString())),
      loading: CircularProgressIndicator.new,
    );
  }
}
