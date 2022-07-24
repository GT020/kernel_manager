import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/core/theme/app_theme.dart';
import 'package:penguin_kernel_manager/app/utils/root_utils.dart';

final gpuFrequencyStreamProvider =
    StreamProvider.family<String, String>((final ref, final gpuFrequencyNode) {
  return RootUtils.catStream(
    gpuFrequencyNode,
    interval: 1,
  );
});

class GpuLiveFrequencyWidget extends ConsumerWidget {
  final String gpuCurrentFrequencyNode;
  final double minFrequency;
  final double maxFrequency;
  const GpuLiveFrequencyWidget({
    final Key? key,
    required this.gpuCurrentFrequencyNode,
    required this.minFrequency,
    required this.maxFrequency,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AsyncValue<String> asyncGpuFrequency =
        ref.watch(gpuFrequencyStreamProvider(gpuCurrentFrequencyNode));

    return CustomPaint(
      size: const Size(200, 200),
      painter: GpuBackgroundFrequencyPainter(
        minFrequency,
        maxFrequency,
      ),
      foregroundPainter: GpuFrequencyForegroundPainter(
        asyncGpuFrequency.value ?? '0',
        maxFrequency,
      ),
    );
  }
}

class GpuBackgroundFrequencyPainter extends CustomPainter {
  final double minFrequency;
  final double maxFrequency;

  GpuBackgroundFrequencyPainter(
    this.minFrequency,
    this.maxFrequency,
  );

  @override
  void paint(final Canvas canvas, final Size size) {
    final backgroundStrokeWidth = size.width / 75;
    final radius = size.width / 5;
    final center = Offset(size.width / 2, size.height / 2);
    final double fontSize = size.width / 25;
    // paint currentFrequency Text a top left corner

    // print max Frequency in the corner of the screen

    TextPainter(
      text: TextSpan(
        text: 'Max \n${(maxFrequency / 1000000).toStringAsFixed(2)} MHz',
        style: TextStyle(
          fontSize: fontSize,
          color: appLightBlue,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )
      ..layout(
        minWidth: 0,
        maxWidth: size.width,
      )
      ..paint(
        canvas,
        Offset.zero,
      );
    TextPainter(
      text: TextSpan(
        text: 'Min \n${(minFrequency / 1000000).toStringAsFixed(2)} MHz',
        style: TextStyle(
          fontSize: fontSize,
          color: appLightBlue,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )
      ..layout(
        minWidth: 0,
        maxWidth: size.width,
      )
      ..paint(
        canvas,
        Offset(0, size.height - fontSize * 2),
      );
    // draw full Circle
    final backgroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = backgroundStrokeWidth
      ..color = appLightBlue
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) {
    return false;
  }
}

class GpuFrequencyForegroundPainter extends CustomPainter {
  final String currentFrequency;
  final double maxFrequency;

  GpuFrequencyForegroundPainter(this.currentFrequency, this.maxFrequency);
  @override
  void paint(final Canvas canvas, final Size size) {
    final double foreStrokeWidth = size.width / 37;
    final radius = size.width / 5;
    final center = Offset(size.width / 2, size.height / 2);
    final foregroundPaint = Paint()
      ..color = appGreenYellow
      ..strokeWidth = foreStrokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final currentFrequency = double.parse(this.currentFrequency);
    final currentFrequencyPercentage = currentFrequency / maxFrequency;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      pi * 2 * currentFrequencyPercentage,
      false,
      foregroundPaint,
    );
    final TextPainter curFrequencyTextPainter = TextPainter(
      text: TextSpan(
        text: this.currentFrequency,
        style: TextStyle(
          fontSize: size.width / 25,
          color: appGreenYellow,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );

    curFrequencyTextPainter
      ..layout(
        minWidth: 0,
        maxWidth: size.width,
      )
      ..paint(
        canvas,
        center -
            Offset(
              curFrequencyTextPainter.width / 2,
              curFrequencyTextPainter.height / 2,
            ),
      );
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) {
    return true;
  }
}
