import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/battery_monitor/view/battery_monitor_view.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/view/cpu_monitor_view.dart';
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
              context.push(BatteryMonitor.routeName);
            },
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Battery Monitor'),
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
          MaterialButton(
            onPressed: () {
              context.push(CpuMonitorView.routeName);
            },
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Cpu Monitor'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
