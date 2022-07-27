import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/battery_monitor/view/battery_monitor_view.dart';
import 'package:penguin_kernel_manager/app/features/cpu_monitor/view/cpu_monitor_view.dart';
import 'package:penguin_kernel_manager/app/features/gpu_monitor/view/gpu_monitor_view.dart';
import 'package:penguin_kernel_manager/app/features/home/view/home_view.dart';
import 'package:penguin_kernel_manager/app/features/ram_monitor/view/ram_monitor_view.dart';

///
/// for getting routers that are present in the app
///
final Provider<GoRouter> routerProvider = Provider<GoRouter>(
  (final ref) {
    return GoRouter(
      routes: [
        /// for showing onboarding
        GoRoute(
          path: HomeView.routeName,
          builder: (final context, final state) => const HomeView(),
        ),

        GoRoute(
          path: GpuMonitorView.routeName,
          builder: (final context, final state) => const GpuMonitorView(),
        ),
        GoRoute(
          path: BatteryMonitor.routeName,
          builder: (final context, final state) => const BatteryMonitor(),
        ),
        GoRoute(
          path: RamMonitorView.routeName,
          builder: (final context, final state) => const RamMonitorView(),
        ),
        GoRoute(
          path: CpuMonitorView.routeName,
          builder: (final context, final state) => const CpuMonitorView(),
        ),
      ],
    );
  },
);
