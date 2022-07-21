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
      painter: BatteryBarPainter(
        batteryPercentage: asyncBatteryPercentage.when(
          data: (final data) => data,
          error: (final e, final s) => '0',
          loading: () => '0',
        ),
      ),
      size: const Size(20, 20),
    );
  }
}

class BatteryBarPainter extends CustomPainter {
  final String batteryPercentage;
  BatteryBarPainter({required this.batteryPercentage});
  @override
  void paint(final Canvas canvas, final Size size) {
    final double percentage = double.parse(batteryPercentage) / 100;
    if (batteryPercentage == '0') {
      return;
    }
    final double strokeWidth = size.height / 2;
    final Offset startingPoint = Offset(strokeWidth, strokeWidth);
    final length = size.width * percentage;
    final Offset endingPoint = Offset(length - strokeWidth, strokeWidth);
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [
          appOrange,
          appGreenYellow,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTRB(0, 0, size.width, 0));

    final textPainter = TextPainter(
      text: TextSpan(
        text: batteryPercentage,
        style: TextStyle(fontSize: strokeWidth, color: Colors.black),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      textScaleFactor: 1,
    );

    canvas.drawLine(startingPoint, endingPoint, paint);

    textPainter
      ..layout(minWidth: 0, maxWidth: strokeWidth * 5)
      ..paint(canvas, Offset(strokeWidth, strokeWidth / 2));
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) {
    return true;
  }
}
