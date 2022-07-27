import 'dart:collection';

import 'package:flutter/material.dart';

class LiveFrequencyGraphWidget extends StatelessWidget {
  final Queue<double> last10Frequencies = Queue<double>();
  final Stream<String> currentFrequencyStream;
  final double maxFrequency;
  final double height;
  final double width;
  final Color color;
  LiveFrequencyGraphWidget({
    final Key? key,
    required this.color,
    required this.height,
    required this.width,
    required this.currentFrequencyStream,
    required this.maxFrequency,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return GridPaper(
      child: StreamBuilder<String>(
        builder: (final context, final snap) {
          if (snap.hasData) {
            if (last10Frequencies.length > 10) {
              last10Frequencies.removeFirst();
            }
            last10Frequencies.add(double.parse(snap.requireData));

            return CustomPaint(
              size: Size(width, height),
              painter: FrequencyGraphPainter(
                color: color,
                freqs: last10Frequencies,
                maxF: maxFrequency,
              ),
            );
          }

          return SizedBox(
            height: height,
            width: width,
          );
        },
        stream: currentFrequencyStream,
      ),
    );
  }
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
    Offset startingPoint = Offset(0, size.height);
    final double lineLength = size.width / freqs.length;
    final backgroundPaint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = color;

    // ignore: prefer-correct-identifier-length
    for (int i = 0; i < freqs.length; i++) {
      final double freq = freqs.elementAt(i);
      // ignore: prefer-correct-identifier-length
      final y = size.height - (freq / maxF) * size.height;
      // ignore: prefer-correct-identifier-length
      final x = i * lineLength;

      if (i == 0) {
        canvas.drawLine(Offset(x, y), Offset(x, y), backgroundPaint);
        startingPoint = Offset(x, y);
      } else {
        canvas.drawLine(startingPoint, Offset(x, y), backgroundPaint);
        startingPoint = Offset(x, y);
      }
    }
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) {
    return true;
  }
}
