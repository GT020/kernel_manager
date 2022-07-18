import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

final currentNowStreamProvider = StreamProvider.family<String, String>(
  (final ref, final String currentNode) {
    return ReadUtil.readStream(currentNode);
  },
);

class BatteryCurrentNowWidget extends ConsumerWidget {
  final String currentNowNode;
  final double currentMax;
  const BatteryCurrentNowWidget({
    final Key? key,
    required this.currentNowNode,
    required this.currentMax,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final asyncCurrent = ref.watch(currentNowStreamProvider(currentNowNode));

    return CustomPaint(
      size: const Size(20, 20),
      painter: BatteryCurrentBarPainter(
        currentNow: asyncCurrent.when(
          data: (final data) => data,
          error: (final e, final s) => '0',
          loading: () => '0',
        ),
        currentMax: currentMax,
      ),
    );
  }
}

class BatteryCurrentBarPainter extends CustomPainter {
  final String currentNow;
  final double currentMax;
  const BatteryCurrentBarPainter({
    required this.currentNow,
    required this.currentMax,
  });

  TextSpan getCurrentTextSpan() {
    return TextSpan(
      text: currentNow,
      style: const TextStyle(
        fontSize: 10,
        color: Colors.white,
      ),
    );
  }

  @override
  void paint(final Canvas canvas, final Size size) {
    final current = double.parse(currentNow);
    final Color color = current > 0 ? Colors.red : Colors.green;
    final currentPercentage = (current.abs() / currentMax) * 100;
    final strokeWidth = size.height / 2;
    final length = size.width * currentPercentage;
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = color;
    // draw the current bar
    canvas.drawLine(
      Offset(strokeWidth, strokeWidth),
      Offset(length, strokeWidth),
      paint,
    );
    // draw the current text
    TextPainter(
      text: getCurrentTextSpan(),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      textScaleFactor: 1,
    )
      ..layout(minWidth: 0, maxWidth: strokeWidth * 5)
      ..paint(canvas, Offset(strokeWidth, strokeWidth / 2));
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) {
    return true;
  }
}
