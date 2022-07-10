import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sizeProvider = Provider.family<Size, Size>((ref, n) {
  return n;
});

class FrequencyHistory extends ConsumerWidget {
  final Map<double, double> history;
  const FrequencyHistory({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = ref.read(sizeProvider(const Size(200, 300)));
    return GestureDetector(
      onTap: () {},
      child: CustomPaint(
        size: size,
        painter: FrequencyHistoryPainter(history: history),
      ),
    );
  }
}

// class FrequencyHistoryPainter extends CustomPainter {
//   final Map<double, double> history;
//   double sum = 0;
//   FrequencyHistoryPainter(this.history) {
//     history.forEach((key, value) {
//       sum += value;
//     });
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     const strokeWidth = 30.0;
//     final center = Offset(size.width / 2, size.height / 2);
//     double textLocationY = center.dx;
//     double radius = (size.width - strokeWidth) / 2;

//     double startingAngle = -pi / 2;
//     history.forEach(
//       (key, value) {
//         final randomColor = Color.fromARGB(255, Random().nextInt(256),
//             Random().nextInt(256), Random().nextInt(256));
//         final foregroundPaint = Paint()
//           ..isAntiAlias = true
//           ..strokeWidth = strokeWidth
//           ..style = PaintingStyle.stroke
//           ..color = randomColor;
//         // text painter to draw key with arc length
//         final textPainter = TextPainter(
//           text: TextSpan(
//               text: key.toString(),
//               style: TextStyle(color: randomColor, fontSize: 15)),
//           textDirection: TextDirection.ltr,
//           textAlign: TextAlign.center,
//           textScaleFactor: 1,
//         );

//         double arcLength = 2 * pi * value / sum;

//         canvas.drawArc(
//           Rect.fromCircle(center: center, radius: radius),
//           startingAngle,
//           arcLength,
//           false,
//           foregroundPaint,
//         );
//         textPainter.layout();
//         textPainter.paint(canvas, Offset(center.dx + radius, textLocationY));
//         startingAngle += arcLength;
//         textLocationY += 12;
//       },
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

class FrequencyHistoryPainter extends CustomPainter {
  final Map<double, double> history;
  double sum = 0;
  final Color backgroundColor;
  final Color foregroundColor;
  FrequencyHistoryPainter(
      {required this.history,
      this.backgroundColor = Colors.black,
      this.foregroundColor = Colors.amber}) {
    history.forEach((key, value) {
      sum += value;
    });
  }
  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = (size.height - (history.length * 2)) / history.length;

    double startingPoint = 0;
    double nextLine = size.height / 8;
    final backgroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = backgroundColor;

    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = foregroundColor;

    history.forEach(
      (key, value) {
        final textPainterFrequency = TextPainter(
          text: TextSpan(
              text: key.toString(),
              style: TextStyle(color: Colors.white, fontSize: strokeWidth - 2)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          textScaleFactor: 1,
        );
        final textPainterPercentage = TextPainter(
          text: TextSpan(
              text: (value / sum * 100).toStringAsFixed(2) + "%",
              style: TextStyle(color: Colors.white, fontSize: strokeWidth - 2)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          textScaleFactor: 1,
        );
        canvas.drawLine(Offset(startingPoint, nextLine),
            Offset(size.width, nextLine), backgroundPaint);

        canvas.drawLine(Offset(startingPoint, nextLine),
            Offset(size.width * (value / sum), nextLine), foregroundPaint);
        textPainterFrequency.layout();
        textPainterFrequency.paint(
            canvas, Offset(startingPoint + 2, nextLine - (strokeWidth / 2)));
        textPainterPercentage.layout();
        textPainterPercentage.paint(
            canvas,
            Offset(
                size.width - strokeWidth - 30, nextLine - (strokeWidth / 2)));
        nextLine += strokeWidth + 2;
      },
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
