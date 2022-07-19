import 'dart:io';

import 'package:penguin_kernel_manager/app/utils/root_utils.dart';

class ReadUtil {
  /// Stream the value of path provided as String using cat command
  static Stream<String> catStream(
    final String path, {
    final int interval = 1000,
  }) async* {
    while (true) {
      await Future<dynamic>.delayed(Duration(milliseconds: interval));
      final ProcessResult processResult = await Process.run('cat', [path]);
      yield processResult.stdout.toString();
    }
  }

  /// Return the value of path provided as String using cat command
  static Future<String> cat(final String path) async {
    try {
      final ProcessResult processResult = await Process.run('cat', [path]);
      if (processResult.exitCode != 0) {
        throw Exception('cat $path failed');
      }

      return processResult.stdout.toString();
    }
    // ignore: avoid_catches_without_on_clauses
    catch (e) {
      //cat with root if exception occurs
      final String result = await RootUtils.cat(path);

      return result;
    }
  }

  /// Stream the value of path provided as String Using File
  static Stream<String> readStream(
    final String path, {
    final int interval = 1000,
  }) async* {
    while (true) {
      await Future<dynamic>.delayed(Duration(milliseconds: interval));
      yield await File(path).readAsString();
    }
  }

  /// Return the value of path provided as String using File
  static Future<String> ioRead(final String path) async {
    try {
      return await File(path).readAsString();
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return e.toString();
    }
  }
}
