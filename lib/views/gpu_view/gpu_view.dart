import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kernel_manager/models/gpu_model.dart';
import 'package:kernel_manager/repository/gpu/gpu_repository.dart';

final gpuProvider = FutureProvider<GPU>((ref) async {
  return await GpuRepository().getGpu();
});

class GpuView extends ConsumerWidget {
  const GpuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<GPU> asyncGpu = ref.watch(gpuProvider);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Center(
            child: Text(
              'GPU',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: asyncGpu.when(
            data: (GPU gpu) => Wrap(
                  children: [
                    Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text("Name"),
                              Text(gpu.name),
                            ],
                          ),
                        ))
                  ],
                ),
            error: (o, s) {
              return Text(o.toString());
            },
            loading: () => const CircularProgressIndicator()));
  }
}
