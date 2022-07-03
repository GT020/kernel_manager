import 'package:flutter_application_1/app/features/cpu/view/cpu_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// for getting routers that are present in the app
///
final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      // TODO: add your router here
      routes: [
        /// for showing onboarding
        GoRoute(
          path: CpuView.routeName,
          builder: (context, state) => const CpuView(),
        ),
      ],
    );
  },
);
