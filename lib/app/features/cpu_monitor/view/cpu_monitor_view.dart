import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/model/cpu_monitor_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/repository/cpu_monitor_repository_impl.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/widget/cpu_monitor_widget.dart';

final cpuProvider = FutureProvider<CpuMonitorModel>((final ref) async {
  return ref.read(cpuMonitorRepositoryProvider).getCpuMonitor();
});

class CpuMonitorView extends ConsumerWidget {
  const CpuMonitorView({final Key? key}) : super(key: key);

  static const routeName = '/cpuMonitor';

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<CpuMonitorModel> asyncCpu = ref.watch(cpuProvider);

    return asyncCpu.when(
      data: (final cpu) => CpuMonitorWidget(cpu: cpu),
      error: (final e, final s) => Text(e.toString()),
      loading: CircularProgressIndicator.new,
    );
  }
}
