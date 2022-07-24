import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/core/theme/app_theme.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

final batteryPercentageProvider =
    StreamProvider.family<String, String>((final ref, final percentageNode) {
  return ReadUtil.readStream(percentageNode, interval: 5000);
});

class BatteryPercentageWidget extends ConsumerWidget {
  final String batteryPercentageNode;
  const BatteryPercentageWidget({
    final Key? key,
    required this.batteryPercentageNode,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<String> asyncBatteryPercentage =
        ref.watch(batteryPercentageProvider(batteryPercentageNode));

    return CustomPaint(
      painter: BatteryPercentageBackgroundPainter(),
      foregroundPainter: BatteryPercentageForegroundPainter(
        asyncBatteryPercentage.value ?? '0',
      ),
      size: const Size(150, 150),
    );
  }
}

class BatteryPercentageBackgroundPainter extends CustomPainter {
  @override
  void paint(final Canvas canvas, final Size size) {
    final double strokeWidth = size.height / 40;
    final radius = size.height / 2.5;
    final center = Offset(size.width / 2, size.height / 2);
    final backgroundPaint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = appLightBlue;

    canvas.drawCircle(center, radius, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) {
    return false;
  }
}

class BatteryPercentageForegroundPainter extends CustomPainter {
  final String batteryPercentage;

  BatteryPercentageForegroundPainter(this.batteryPercentage);
  @override
  void paint(final Canvas canvas, final Size size) {
    if (batteryPercentage == '0') {
      return;
    }
    final double percentage = double.parse(batteryPercentage) / 100;
    final radius = size.height / 2.5;
    final center = Offset(size.width / 2, size.height / 2);
    final double fontSize = size.height / 10;
    final double strokeWidth = size.height / 20;

    final foregroundPaint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = appGreenYellow;

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -pi / 2,
      pi * 2 * percentage,
      false,
      foregroundPaint,
    );

    TextPainter(
      text: TextSpan(
        text: batteryPercentage,
        style: TextStyle(fontSize: fontSize, color: appLightBlue),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      textScaleFactor: 1,
    )
      ..layout(minWidth: 0, maxWidth: strokeWidth * 5)
      ..paint(canvas, center - Offset(fontSize / 2, fontSize / 2));
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) {
    return true;
  }
}
