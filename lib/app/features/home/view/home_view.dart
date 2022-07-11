import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/cpu/view/cpu_view.dart';
import 'package:penguin_kernel_manager/app/features/gpu/view/gpu_view.dart';

class HomeView extends ConsumerWidget {
  /// Home View
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                context.push(CpuView.routeName);
              },
              child: const Text('Go to CPU')),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                context.push(GpuView.routeName);
              },
              child: const Text('Go to GPU')),
        ],
      ),
    );
  }
}
