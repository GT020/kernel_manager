import 'package:flutter/material.dart';

class GpuFrequencyWidget extends StatelessWidget {
  final List<double> availableFrequencies;

  const GpuFrequencyWidget({final Key? key, required this.availableFrequencies})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...availableFrequencies
                .map(
                  (final frequency) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(frequency.toString()),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
