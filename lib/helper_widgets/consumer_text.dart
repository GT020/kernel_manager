import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConsumerStreamText extends ConsumerWidget {
  final StreamProvider provider;
  final TextStyle? style;
  const ConsumerStreamText(this.provider, {Key? key, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue value = ref.watch(provider);
    return value.when(
        data: ((data) => Text(
              data,
              style: style,
            )),
        error: (error, stacktrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator());
  }
}
