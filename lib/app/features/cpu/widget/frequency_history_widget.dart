import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/features/cpu/model/core_state_model.dart';

class FrequencyHistory extends StatelessWidget {
  final List<CoreStateModel> history;
  const FrequencyHistory({final Key? key, required this.history})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        ...history.map(
          (final coreState) => CustomPaint(
            size: const Size(double.infinity, 15),
            painter: FrequencyHistoryBarPainter(
              fillBarColor: Theme.of(context).primaryColor,
              coreState: coreState,
              frequencyTextColor: Theme.of(context).textTheme.bodyText1!.color,
              percentageTextColor: Theme.of(context).textTheme.bodyText2!.color,
            ),
          ),
        ),
      ],
    );
  }
}

class FrequencyHistoryBarPainter extends CustomPainter {
  final CoreStateModel coreState;
  final Color fillBarColor;
  final Color? frequencyTextColor;
  final Color? percentageTextColor;
  FrequencyHistoryBarPainter({
    this.frequencyTextColor = Colors.white,
    this.percentageTextColor = Colors.white,
    required this.coreState,
    required this.fillBarColor,
  });

  @override

  // ignore: long-method
  void paint(final Canvas canvas, final Size size) {
    //TODO: refactor this method
    final double strokeWidth = size.height - 2;

    final backgroundPaint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = const Color.fromARGB(24, 229, 229, 233);

    final foregroundPaint = Paint()
      ..color = fillBarColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final textPainterFrequency = TextPainter(
      text: TextSpan(
        text: coreState.frequency,
        style: TextStyle(color: frequencyTextColor, fontSize: strokeWidth - 2),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      textScaleFactor: 1,
    );
    final textPainterPercentage = TextPainter(
      text: TextSpan(
        text: '${coreState.percentage.toStringAsFixed(2)} %',
        style: TextStyle(color: percentageTextColor, fontSize: strokeWidth - 2),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      textScaleFactor: 1,
    );
    const double startingPoint = 10.0;
    final double endingPoint = size.width - strokeWidth;

    final double percentageEndpoint =
        ((coreState.percentage / 100) * size.width) + 10;

    canvas
      ..drawLine(
        const Offset(startingPoint, 0),
        Offset(endingPoint, 0),
        backgroundPaint,
      )
      ..drawLine(
        const Offset(startingPoint, 0),
        Offset(percentageEndpoint, 0),
        foregroundPaint,
      );

    textPainterFrequency
      ..layout(minWidth: 0, maxWidth: strokeWidth * 5)
      ..paint(
        canvas,
        Offset(startingPoint, 0 - (strokeWidth / 2)),
      );

    textPainterPercentage
      ..layout(minWidth: 0, maxWidth: strokeWidth * 5)
      ..paint(
        canvas,
        Offset(endingPoint - strokeWidth * 3, -strokeWidth / 2),
      );
  }

  @override
  bool shouldRepaint(covariant final CustomPainter oldDelegate) {
    return false;
  }
}
