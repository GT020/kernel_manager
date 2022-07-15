import 'dart:io';

class WriteUtil {
  /// Write the value to path provided as String using echo command
  /// It overwrites the content of the file
  /// [path] - Path of the file to write to
  /// [value] - Value to write to the file
  /// > is used

  static Future<void> echo(String path, String value) async {
    await Process.run('echo', [value, '>', path]).then((value) => value.stdout);
  }

  /// Write the value to path provided as String using echo command
  /// It appends the content of the file
  /// [path] - Path of the file to write to
  /// [value] - Value to write to the file
  /// >> is used

  static Future<void> echoNewLine(String path, String value) async {
    await Process.run('echo', [value, '>>', path])
        .then((value) => value.stdout);
  }

  /// Write the value to path provided as String using dart:io: File

  static void writeUsingFile(String path, String content) {
    File file = File(path);
    file.writeAsStringSync(content);
  }
}
