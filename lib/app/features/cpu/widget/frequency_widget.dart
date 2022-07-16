import 'package:flutter/material.dart';

class FrequencyWidget extends StatelessWidget {
  final Stream<String> frequencyStream;
  final TextStyle? textStyle;
  const FrequencyWidget({
    final Key? key,
    required this.frequencyStream,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return StreamBuilder<String>(
      stream: frequencyStream,
      builder: (final context, final snapshot) {
        return snapshot.hasData
            ? Text(snapshot.requireData, style: textStyle)
            : const Text('...');
      },
    );
  }
}
