import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/battery/view/battery_view.dart';
import 'package:penguin_kernel_manager/app/features/cpu/view/cpu_view.dart';
import 'package:penguin_kernel_manager/app/features/gpu/view/gpu_view.dart';
import 'package:penguin_kernel_manager/app/features/ram/view/ram_view.dart';

class HomeView extends ConsumerWidget {
  /// Home View
  const HomeView({final Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Wrap(
        children: [
          MaterialButton(
            onPressed: () {
              context.push(CpuView.routeName);
            },
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('CPU'),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              context.push(GpuView.routeName);
            },
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('GPU'),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              context.push(BatteryView.routeName);
            },
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Battery'),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              context.push(RamView.routeName);
            },
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Ram'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
