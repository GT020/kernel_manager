import 'package:flutter/material.dart';
import 'package:kernel_manager/app/app_routes.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Lottie.asset(
                  'assets/lottie/cpu.json',
                ),
                LottieBuilder.asset(
                  'assets/lottie/gpu.json',
                ),
              ],
            ),
            Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  Card(
                    color: Colors.transparent,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoute.cpuRoute);
                          },
                          child: const Text('CPU')),
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoute.gpuRoute);
                          },
                          child: const Text('GPU')),
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoute.ramRoute);
                          },
                          child: const Text('RAM')),
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoute.batteryRoute);
                          },
                          child: const Text('Battery')),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
