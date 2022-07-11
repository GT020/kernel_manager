import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/cpu/model/core_state_model.dart';

class FrequencyHistory extends StatelessWidget {
  final List<CoreStateModel> history;
  const FrequencyHistory({Key? key, required this.history}) : super(key: key);

  List<Widget> coreHistoryWidgetList() {
    List<Widget> coreHistoryWidgetList = [];
    for (CoreStateModel coreState in history) {
      coreHistoryWidgetList.add(CustomPaint(
        size: const Size(double.infinity, 15),
        painter: FrequencyHistoryBarPainter(coreState),
      ));
    }
    return coreHistoryWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: coreHistoryWidgetList(),
    );
  }
}

class FrequencyHistoryBarPainter extends CustomPainter {
  final CoreStateModel coreState;
  FrequencyHistoryBarPainter(this.coreState);
  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = size.height - 2;
    Rect rect = Offset.zero & size;
    const foregroundGradient =
        LinearGradient(colors: [Color(0xFF30c5d2), Color(0xFF471069)]);

    final backgroundPaint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = const Color.fromARGB(255, 229, 229, 233);

    final foregroundPaint = Paint()
      ..shader = foregroundGradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final textPainterFrequency = TextPainter(
      text: TextSpan(
          text: coreState.frequency,
          style: TextStyle(
              color: const Color(0xFF471069), fontSize: strokeWidth - 2)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      textScaleFactor: 1,
    );
    final textPainterPercentage = TextPainter(
      text: TextSpan(
          text: '${coreState.percentage.toStringAsFixed(2)} %',
          style: TextStyle(
              color: const Color(0xFF30c5d2), fontSize: strokeWidth - 2)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      textScaleFactor: 1,
    );
    double startingPoint = 10.0;
    double endingPoint = size.width - strokeWidth;

    double percentageEndpoint =
        ((coreState.percentage / 100) * size.width) + 10;

    canvas.drawLine(
        Offset(startingPoint, 0), Offset(endingPoint, 0), backgroundPaint);
    canvas.drawLine(Offset(startingPoint, 0), Offset(percentageEndpoint, 0),
        foregroundPaint);

    textPainterFrequency.layout(minWidth: 0, maxWidth: strokeWidth * 5);
    textPainterFrequency.paint(
        canvas, Offset(startingPoint, 0 - (strokeWidth / 2)));

    textPainterPercentage.layout(minWidth: 0, maxWidth: strokeWidth * 5);
    textPainterPercentage.paint(
        canvas, Offset(endingPoint - strokeWidth * 3, -strokeWidth / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
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

// class FrequencyHistoryPainter extends CustomPainter {
//   final Map<double, double> history;
//   double sum = 0;
//   final Color backgroundColor;
//   final Color foregroundColor;
//   FrequencyHistoryPainter(
//       {required this.history,
//       this.backgroundColor = Colors.black,
//       this.foregroundColor = Colors.amber}) {
//     history.forEach((key, value) {
//       sum += value;
//     });
//   }
//   @override
//   void paint(Canvas canvas, Size size) {
//     double strokeWidth = (size.height - (history.length * 2)) / history.length;

//     double startingPoint = 0;
//     double nextLine = size.height / 8;
//     final backgroundPaint = Paint()
//       ..isAntiAlias = true
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke
//       ..color = backgroundColor;

//     final foregroundPaint = Paint()
//       ..isAntiAlias = true
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke
//       ..color = foregroundColor;

//     history.forEach(
//       (key, value) {
//         final textPainterFrequency = TextPainter(
//           text: TextSpan(
//               text: key.toString(),
//               style: TextStyle(color: Colors.white, fontSize: strokeWidth - 2)),
//           textDirection: TextDirection.ltr,
//           textAlign: TextAlign.center,
//           textScaleFactor: 1,
//         );
//         final textPainterPercentage = TextPainter(
//           text: TextSpan(
//               text: (value / sum * 100).toStringAsFixed(2) + "%",
//               style: TextStyle(color: Colors.white, fontSize: strokeWidth - 2)),
//           textDirection: TextDirection.ltr,
//           textAlign: TextAlign.center,
//           textScaleFactor: 1,
//         );
//         canvas.drawLine(Offset(startingPoint, nextLine),
//             Offset(size.width, nextLine), backgroundPaint);

//         canvas.drawLine(Offset(startingPoint, nextLine),
//             Offset(size.width * (value / sum), nextLine), foregroundPaint);
//         textPainterFrequency.layout();
//         textPainterFrequency.paint(
//             canvas, Offset(startingPoint + 2, nextLine - (strokeWidth / 2)));
//         textPainterPercentage.layout();
//         textPainterPercentage.paint(
//             canvas,
//             Offset(
//                 size.width - strokeWidth - 30, nextLine - (strokeWidth / 2)));
//         nextLine += strokeWidth + 2;
//       },
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
