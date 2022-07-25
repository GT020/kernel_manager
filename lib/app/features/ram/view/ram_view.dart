import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/ram/model/ram_model.dart';
import 'package:penguin_kernel_manager/app/features/ram/repository/ram_repository_impl.dart';
import 'package:penguin_kernel_manager/app/features/ram/widget/ram_widget.dart';

final ramProvider = FutureProvider<RamModel>((final ref) async {
  return RamRepositoryImpl().getRam();
});

class RamView extends ConsumerWidget {
  const RamView({final Key? key}) : super(key: key);

  static const routeName = '/ram';

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<RamModel> asyncRam = ref.watch(ramProvider);

    return asyncRam.when(
      data: (final ram) => RamWidget(ram: ram),
      error: (final e, final s) => Text('$e'),
      loading: CircularProgressIndicator.new,
    );
  }
}
