import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/core/theme/app_theme.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

final voltageNowStreamProvider =
    StreamProvider.family.autoDispose<String, String>(
  (final ref, final String voltageNode) {
    return ReadUtil.readStream(voltageNode);
  },
);

class BatteryVoltageNowWidget extends ConsumerWidget {
  final String voltageNowNode;
  final double voltageMax;
  const BatteryVoltageNowWidget({
    final Key? key,
    required this.voltageNowNode,
    required this.voltageMax,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final asyncVoltage = ref.watch(voltageNowStreamProvider(voltageNowNode));

    return CustomPaint(
      size: const Size(double.infinity, 20),
      painter: BatteryVoltageBarPainter(
        voltageNow: asyncVoltage.when(
          data: (final data) => data,
          error: (final e, final s) => '0',
          loading: () => '0',
        ),
        voltageMax: voltageMax,
      ),
    );
  }
}

class BatteryVoltageBarPainter extends CustomPainter {
  final String voltageNow;
  final double voltageMax;
  const BatteryVoltageBarPainter({
    required this.voltageNow,
    required this.voltageMax,
  });

  TextSpan getVoltageTextSpan() {
    return TextSpan(
      text: voltageNow,
      style: const TextStyle(
        fontSize: 10,
        color: Colors.black,
      ),
    );
  }

  @override
  void paint(final Canvas canvas, final Size size) {
    final voltage = double.parse(voltageNow);
    if (voltage == 0) {
      return;
    }
    final Color color = voltage < 0 ? appOrange : appGreenYellow;
    final voltagePercentage = voltage.abs() / voltageMax;
    final strokeWidth = size.height / 2;
    final length = size.width * voltagePercentage - strokeWidth;
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = color;
    // draw the voltage bar
    canvas.drawLine(
      Offset(strokeWidth, strokeWidth),
      Offset(length, strokeWidth),
      paint,
    );
    // draw the voltage text
    TextPainter(
      text: getVoltageTextSpan(),
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
