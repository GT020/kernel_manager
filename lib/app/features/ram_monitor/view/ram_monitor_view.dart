import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/ram_monitor/model/ram_monitor_model.dart';
import 'package:penguin_kernel_manager/app/features/ram_monitor/repository/ram_monitor_repository_impl.dart';
import 'package:penguin_kernel_manager/app/features/ram_monitor/widget/ram_monitor_widget.dart';

final ramProvider = FutureProvider<RamMonitorModel>((final ref) async {
  return ref.read(ramMonitorRepositoryProvider).getRamMonitorModel();
});

class RamMonitorView extends ConsumerWidget {
  const RamMonitorView({final Key? key}) : super(key: key);

  static const routeName = '/ramMonitor';

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<RamMonitorModel> asyncRam = ref.read(ramProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ram Monitor'),
      ),
      body: asyncRam.when(
        data: (final ram) => RamMonitorWidget(ram: ram),
        error: (final e, final s) => Text(e.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
