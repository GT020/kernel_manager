import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kernel_manager/app/features/cpu/model/cpu_model.dart';
import 'package:kernel_manager/app/features/cpu/repository/cpu_repository_impl.dart';
import 'package:kernel_manager/app/features/cpu/widget/cpu_widget.dart';

final FutureProvider<CpuModel> cpuProvider = FutureProvider((ref) {
  return CpuRepositoryImpl().getCpu();
});

class CpuView extends ConsumerWidget {
  /// Creates a [CpuView].
  const CpuView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<CpuModel> asyncCpu = ref.watch(cpuProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CPU'),
      ),
      body: asyncCpu.when(
          data: (cpu) {
            return CpuWidget(cpu: cpu);
          },
          error: (e, s) {
            return Text(e.toString());
          },
          loading: () => const LinearProgressIndicator()),
    );
  }
}
