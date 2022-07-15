import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';
import 'package:rxdart/rxdart.dart';

final liveFrequencyProvider = StreamProvider.family<double, String>(
  (ref, arg) {
    final BehaviorSubject<double> subject = BehaviorSubject<double>();
    Stream stream = ReadUtil.readStream(arg);
    stream.listen((data) {
      subject.add(double.parse(data));
    });
    return subject;
  },
);

class LiveFrequencyGraphWidget extends StatelessWidget {
  final Queue<double> last10Frequencies = Queue<double>();
  final Stream<String> currentFrequencyStream;
  final double maxFrequency;
  final double height;
  final double width;
  final Color color;
  LiveFrequencyGraphWidget(
      {Key? key,
      required this.color,
      required this.height,
      required this.width,
      required this.currentFrequencyStream,
      required this.maxFrequency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        builder: (context, snap) {
          if (snap.hasData) {
            if (last10Frequencies.length > 10) {
              last10Frequencies.removeFirst();
            }
            last10Frequencies.add(double.parse(snap.requireData));
            return GridPaper(
              child: CustomPaint(
                size: Size(width, height),
                painter: FrequencyGraphPainter(
                    color: color,
                    freqs: last10Frequencies,
                    maxF: (maxFrequency).toDouble()),
              ),
            );
          }
          return GridPaper(
            child: SizedBox(
              height: height,
              width: width,
            ),
          );
        },
        stream: currentFrequencyStream);
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
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 2.0;
    Offset startingPoint = Offset(0, size.height);
    double lineLength = size.width / freqs.length;
    final backgroundPaint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = color;

    for (int i = 0; i < freqs.length; i++) {
      final double freq = freqs.elementAt(i);
      final y = size.height - (freq / maxF) * size.height;
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
