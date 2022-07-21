import 'package:flutter/material.dart';

class GpuGovernorWidget extends StatelessWidget {
  final List<String> availableGovernors;
  const GpuGovernorWidget({final Key? key, required this.availableGovernors})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...availableGovernors
                .map(
                  (final governor) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(governor),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
