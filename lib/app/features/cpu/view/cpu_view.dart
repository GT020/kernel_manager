import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/cpu/model/cpu_model.dart';
import 'package:penguin_kernel_manager/app/features/cpu/repository/cpu_repository_impl.dart';
import 'package:penguin_kernel_manager/app/features/cpu/widget/cpu_widget.dart';

final FutureProvider<CpuModel> cpuProvider = FutureProvider((final ref) {
  return ref.read(cpuRepositoryProvider).getCpu();
});

class CpuView extends ConsumerWidget {
  /// Creates a [CpuView].
  const CpuView({final Key? key}) : super(key: key);

  static const routeName = '/cpu';

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<CpuModel> asyncCpu = ref.watch(cpuProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CPU'),
      ),
      body: asyncCpu.when(
        data: (final cpu) {
          return CpuWidget(cpu: cpu);
        },
        error: (final e, final s) {
          return Text(e.toString());
        },
        loading: () => const LinearProgressIndicator(),
      ),
    );
  }
}
