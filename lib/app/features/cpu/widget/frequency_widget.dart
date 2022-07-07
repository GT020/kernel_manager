import 'package:flutter/material.dart';
import 'package:penguin_kernel_manager/app/utils/read_utils.dart';

class FrequencyWidget extends StatefulWidget {
  final String frequencyNode;
  final TextStyle? textStyle;
  const FrequencyWidget({Key? key, required this.frequencyNode, this.textStyle})
      : super(key: key);

  @override
  State<FrequencyWidget> createState() => _FrequencyWidgetState();
}

class _FrequencyWidgetState extends State<FrequencyWidget> {
  late final Stream<String> frequencyStream;

  @override
  void initState() {
    super.initState();
    frequencyStream = ReadUtil.readStream(widget.frequencyNode);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: frequencyStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.requireData, style: widget.textStyle);
          } else {
            return const Text(
              '...',
            );
          }
        });
  }
}
