import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/core/theme/app_theme.dart';

class LiveFrequencyGraphWidget extends StatefulWidget {
  final Stream<String> currentFrequencyStream;
  final double maxFrequency;
  final double height;
  final double width;
  final Color color;
  const LiveFrequencyGraphWidget({
    final Key? key,
    required this.color,
    required this.height,
    required this.width,
    required this.currentFrequencyStream,
    required this.maxFrequency,
  }) : super(key: key);

  @override
  State<LiveFrequencyGraphWidget> createState() =>
      _LiveFrequencyGraphWidgetState();
}

class _LiveFrequencyGraphWidgetState extends State<LiveFrequencyGraphWidget>
    with AutomaticKeepAliveClientMixin {
  final Queue<double> last10Frequencies = Queue<double>();

  @override
  @mustCallSuper
  Widget build(final BuildContext context) {
    return StreamBuilder<String>(
      builder: (final context, final snap) {
        if (snap.hasData) {
          if (last10Frequencies.length > 20) {
            last10Frequencies.removeFirst();
          }
          last10Frequencies.add(double.parse(snap.requireData));

          return CustomPaint(
            size: Size(widget.width, widget.height),
            painter: FrequencyGraphPainter(
              color: widget.color,
              freqs: last10Frequencies,
              maxF: widget.maxFrequency,
            ),
          );
        }

        return SizedBox(
          height: widget.height,
          width: widget.width,
        );
      },
      stream: widget.currentFrequencyStream,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FrequencyGraphPainter extends CustomPainter {
  late Queue<double> freqs;
  final double maxF;
  final Color color;
  FrequencyGraphPainter({
    required this.color,
    required this.freqs,
    required this.maxF,
  });

  @override
  void paint(final Canvas canvas, final Size size) {
    const strokeWidth = 2.0;
    final double lineLength = size.width / 20;

    final backgroundPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..color = appLightBlue.withOpacity(0.2);

    final foregroundPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..color = appLightBlue;

    Offset previous =
        Offset(0, size.height - ((freqs.first / maxF) * size.height));
    final Path path = Path()..moveTo(0, previous.dy);
    double nextX = lineLength;
    for (int index = 1; index < freqs.length; index++) {
      // ignore: prefer-correct-identifier-length
      final y = (freqs.elementAt(index) / maxF) * size.height;

      path.lineTo(nextX, size.height - y);
      canvas.drawLine(
        previous,
        Offset(nextX, size.height - y),
        foregroundPaint,
      );
      previous = Offset(nextX, size.height - y);
      nextX += lineLength;
    }
    path
      ..lineTo(nextX - lineLength, size.height)
      ..lineTo(0, size.height);
    canvas.drawPath(path, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) {
    return true;
  }
}
