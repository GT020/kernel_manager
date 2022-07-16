import 'dart:io';

class WriteUtil {
  /// Write the value to path provided as String using echo command
  /// It overwrites the content of the file
  /// [path] - Path of the file to write to
  /// [value] - Value to write to the file
  /// > is used
  /// and return exit code of the process

  static Future<int> echo(final String path, final String value) async {
    final ProcessResult processResult =
        await Process.run('echo', [value, '>', path]);

    return processResult.exitCode;
  }

  /// Write the value to path provided as String using echo command
  /// It appends the content of the file
  /// [path] - Path of the file to write to
  /// [value] - Value to write to the file
  /// >> is used
  /// and return exit code of the process

  static Future<int> echoNewLine(final String path, final String value) async {
    final ProcessResult processResult =
        await Process.run('echo', [value, '>>', path]);

    return processResult.exitCode;
  }

  /// Write the value to path provided as String using dart:io: File

  static void writeUsingFile(final String path, final String content) {
    File(path).writeAsStringSync(content);
  }
}
