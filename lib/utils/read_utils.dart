import 'dart:io';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadUtil {
  static Stream<String> catAsStream(String path, {int interval = 1000}) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: interval));
      yield await Process.run('cat', [path]).then((value) => value.stdout);
    }
  }

  static Future<String> cat(String path) async {
    return await Process.run('cat', [path]).then((value) => value.stdout);
  }

  static Stream<String> readIoAsStream(String path,
      {int interval = 1000}) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: interval));
      yield await File(path).readAsString();
    }
  }

  static Future<String> ioRead(String path) async {
    return await File(path).readAsString();
  }
}

class ProviderReadUtil {
  static StreamProvider<String> readIoAsStream(String path,
      {int interval = 1000}) {
    return StreamProvider((ref) async* {
      while (true) {
        await Future.delayed(Duration(milliseconds: interval));
        yield await File(path).readAsString();
      }
    });
  }
}
