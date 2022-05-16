import 'package:flutter/material.dart';
import 'package:kernel_manager/app/app_routes.dart';
import 'package:kernel_manager/views/battery_view/battery_view.dart';
import 'package:kernel_manager/views/cpu_view/cpu_view.dart';
import 'package:kernel_manager/views/gpu_view/gpu_view.dart';
import 'package:kernel_manager/views/ram_view/ram_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    // ignore: unused_local_variable
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case AppRoute.cpuRoute:
        return MaterialPageRoute(builder: (context) => const CpuView());
      case AppRoute.gpuRoute:
        return MaterialPageRoute(builder: (context) => const GpuView());
      case AppRoute.batteryRoute:
        return MaterialPageRoute(builder: (context) => const BatteryView());
      case AppRoute.ramRoute:
        return MaterialPageRoute(builder: (context) => const RamView());
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(child: Text("Error")),
      );
    });
  }
}
