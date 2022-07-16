import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/battery/view/battery_view.dart';
import 'package:penguin_kernel_manager/app/features/cpu/view/cpu_view.dart';
import 'package:penguin_kernel_manager/app/features/gpu/view/gpu_view.dart';
import 'package:penguin_kernel_manager/app/features/home/view/home_view.dart';

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
          path: CpuView.routeName,
          builder: (final context, final state) => const CpuView(),
        ),
        GoRoute(
          path: GpuView.routeName,
          builder: (final context, final state) => const GpuView(),
        ),
        GoRoute(
          path: BatteryView.routeName,
          builder: (final context, final state) => const BatteryView(),
        ),
      ],
    );
  },
);
