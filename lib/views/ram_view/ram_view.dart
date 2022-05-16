import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kernel_manager/models/ram_model.dart';
import 'package:kernel_manager/repository/ram/ram_repository.dart';

final ramProvider = FutureProvider<Ram>((ref) async {
  return await RamRepositoryAndroid().getRam();
});

class RamView extends ConsumerWidget {
  const RamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Ram> asyncRam = ref.watch(ramProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ram'),
      ),
      body: asyncRam.when(
          data: (ram) => Column(
                children: [Text(ram.total.toString())],
              ),
          error: (e, s) => Text(e.toString()),
          loading: () => const CircularProgressIndicator()),
    );
  }
}
