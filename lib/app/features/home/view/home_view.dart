import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/battery_monitor/view/battery_monitor_view.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/view/cpu_monitor_view.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/view/gpu_monitor_view.dart';
import 'package:penguin_kernel_manager/app/features/ram_monitor/view/ram_monitor_view.dart';

class HomeView extends ConsumerWidget {
  /// Home View
  const HomeView({final Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Home'),
    //   ),
    //   body: Wrap(
    //     children: [
    //       const SizedBox(
    //         height: 10,
    //       ),
    //       MaterialButton(
    //         onPressed: () {
    //           context.push(GpuMonitorView.routeName);
    //         },
    //         child: const Card(
    //           child: Padding(
    //             padding: EdgeInsets.all(8.0),
    //             child: Text('GPU Monitor'),
    //           ),
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 10,
    //       ),
    //       MaterialButton(
    //         onPressed: () {
    //           context.push(BatteryMonitor.routeName);
    //         },
    //         child: const Card(
    //           child: Padding(
    //             padding: EdgeInsets.all(8.0),
    //             child: Text('Battery Monitor'),
    //           ),
    //         ),
    //       ),
    //       MaterialButton(
    //         onPressed: () {
    //           context.push(RamMonitorView.routeName);
    //         },
    //         child: const Card(
    //           child: Padding(
    //             padding: EdgeInsets.all(8.0),
    //             child: Text('Ram Monitor'),
    //           ),
    //         ),
    //       ),
    //       MaterialButton(
    //         onPressed: () {
    //           context.push(CpuMonitorView.routeName);
    //         },
    //         child: const Card(
    //           child: Padding(
    //             padding: EdgeInsets.all(8.0),
    //             child: Text('Cpu Monitor'),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Text('Cpu'),
              Text('Gpu'),
              Text('Battery'),
              Text('Ram'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CpuMonitorView(),
            GpuMonitorView(),
            BatteryMonitor(),
            RamMonitorView(),
          ],
        ),
      ),
    );
  }
}
