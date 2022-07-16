import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

    return asyncBatteryPercentage.when(
      data: (final percentage) {
        return CustomPaint(
          painter: BatteryBarPainter(batteryPercentage: percentage),
          size: const Size(20, 40),
        );
      },
      error: (final e, final s) {
        return Text(e.toString());
      },
      loading: () => const Text('..'),
    );
  }
}

class BatteryBarPainter extends CustomPainter {
  final String batteryPercentage;
  BatteryBarPainter({required this.batteryPercentage});
  @override
  void paint(final Canvas canvas, final Size size) {
    final double strokeWidth = size.height / 2;
    final Offset startingPoint = Offset(strokeWidth, strokeWidth);
    final length = size.width * (double.parse(batteryPercentage) / 100);
    final Offset endingPoint = Offset(length - strokeWidth, strokeWidth);
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [
          Colors.red,
          Colors.yellow,
          Colors.green,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTRB(0, 0, size.width, 0));

    final textPainter = TextPainter(
      text: TextSpan(
        text: batteryPercentage,
        style: TextStyle(fontSize: strokeWidth, color: Colors.white),
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
