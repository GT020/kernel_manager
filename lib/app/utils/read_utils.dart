import 'dart:io';

class ReadUtil {
  /// Stream the value of path provided as String using cat command
  static Stream<String> catStream(String path, {int interval = 1000}) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: interval));
      yield await Process.run('cat', [path]).then((value) => value.stdout);
    }
  }

  /// Return the value of path provided as String using cat command
  static Future<String> cat(String path) async {
    return await Process.run('cat', [path]).then((value) => value.stdout);
  }

  /// Stream the value of path provided as String Using File
  static Stream<String> readStream(String path, {int interval = 1000}) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: interval));
      yield await File(path).readAsString();
    }
  }

  /// Return the value of path provided as String using File
  static Future<String> ioRead(String path) async {
    return await File(path).readAsString();
  }
}
