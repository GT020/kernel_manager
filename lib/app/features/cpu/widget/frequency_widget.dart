import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

class FrequencyWidget extends StatelessWidget {
  final Stream<String> frequencyStream;
  final TextStyle? textStyle;
  const FrequencyWidget(
      {Key? key, required this.frequencyStream, required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: frequencyStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.requireData, style: textStyle);
          } else {
            return const Text(
              '...',
            );
          }
        });
  }
}
