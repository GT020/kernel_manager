import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kernel_manager/app/app_route_generator.dart';
import 'package:kernel_manager/views/home_view/home_view.dart';

void main() {
  runApp(const ProviderScope(child: KernelManager()));
}

class KernelManager extends StatelessWidget {
  const KernelManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: const HomeView(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
