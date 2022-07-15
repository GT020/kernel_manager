import 'package:penguin_kernel_manager/app/features/battery/view/battery_view.dart';
import 'package:penguin_kernel_manager/app/features/cpu/view/cpu_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/features/gpu/view/gpu_view.dart';
import 'package:penguin_kernel_manager/app/features/home/view/home_view.dart';

///
/// for getting routers that are present in the app
///
final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      routes: [
        /// for showing onboarding
        GoRoute(
          path: HomeView.routeName,
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          path: CpuView.routeName,
          builder: (context, state) => const CpuView(),
        ),
        GoRoute(
          path: GpuView.routeName,
          builder: (context, state) => const GpuView(),
        ),
        GoRoute(
          path: BatteryView.routeName,
          builder: (context, state) => const BatteryView(),
        )
      ],
    );
  },
);
