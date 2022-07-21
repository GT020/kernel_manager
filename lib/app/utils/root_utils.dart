import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:synchronized/synchronized.dart';

class RootProcess {
  late final IOSink stdin;
  late final Stream<List<int>> stdout;
  late final Stream<List<int>> stderr;
  late final int pid;
  RootProcess._();
  static Future<RootProcess> create() async {
    final data = RootProcess._();
    await data.startRootProcess();

    return data;
  }

  Future<void> startRootProcess() async {
    final rootShell = await Process.start('su', []);
    stdin = rootShell.stdin;
    stdout = rootShell.stdout.asBroadcastStream();
    stderr = rootShell.stderr.asBroadcastStream();
    pid = rootShell.pid;
  }

  Future<void> stopRootProcess() async {
    await stdin.close();
    Process.killPid(pid);
  }

  // ignore: avoid_void_async
  void continuouslyRunCommand(
    final String command,
    final int interval,
  ) async {
    while (true) {
      await Future<dynamic>.delayed(Duration(seconds: interval));
      stdin.writeln(command);
    }
  }

  // ignore: avoid_void_async
  void catStreamWithInterval(
    final String path,
    final int interval,
  ) async {
    while (true) {
      await Future<dynamic>.delayed(Duration(seconds: interval));
      stdin.writeln('cat $path');
    }
  }

  void cat(final String path) {
    stdin.writeln('cat $path');
  }
}

// root utils which use root process to run commands
class RootUtils {
  static Stream<String> catStream(
    final String path, {
    final int interval = 1,
  }) async* {
    final RootProcess rootProcess = await RootProcess.create()
      ..catStreamWithInterval(path, interval);

    yield* rootProcess.stdout.transform(utf8.decoder);
  }

  static Future<String> cat(final String path) async {
    final RootProcess rootProcess = await RootProcess.create();
    rootProcess.cat(path);

    return rootProcess.stdout.transform(utf8.decoder).first;
  }
}

class RootShell {
  // Shell can be used for basic root function but it is not recommended for Continuous cat
  // maybe latency can be improved by using isolated processes
  static late final IOSink stdin;
  static late final Stream<String> stdout;
  static late final Stream<List<int>> stderr;
  static late final int pid;
  static final lock = Lock();
  RootShell._();

  static Future<void> initializeRootShell() async {
    final rootProcess = await Process.start('su', []);
    stdin = rootProcess.stdin;
    stdout = rootProcess.stdout.transform(utf8.decoder).asBroadcastStream();
    stderr = rootProcess.stderr.asBroadcastStream();
    pid = rootProcess.pid;
    stdin.writeln('echo "Root Shell initialized"');
    debugPrint(await stdout.first);
  }

  static Future<String> run(
    final String executable,
    final List<String> arguments,
  ) async {
    // In Hope that the command is executed successfully, we will get the output and output is from the latest command.
    // always will be overwhelmed when two or more commands are executed at the same time.

    //lets try lock mechanism to solve this problem.
    //it solves the problem but cause another problem.
    // too much delay in the output.
    return lock.synchronized(
      () {
        stdin.writeln('$executable ${arguments.join(' ')}');

        return stdout.first;
      },
    );
  }

  //implementation of cat command
  static Future<String> cat(final String path) async {
    final result = await run('cat', [path]);
    debugPrint(result);

    return result;
  }

  //implementation of mv command
  static Future<String> mv(
    final String source,
    final String destination,
  ) async {
    final result = await run('mv', [source, destination]);
    debugPrint(result);

    return result;
  }

  //implementation of rm command
  static Future<String> rm(final String path) async {
    final result = await run('rm', [path]);
    debugPrint(result);

    return result;
  }

  //implementation of mkdir command
  static Future<String> mkdir(final String path) async {
    final result = await run('mkdir', [path]);
    debugPrint(result);

    return result;
  }

  //implementation of chmod command
  static Future<String> chmod(final String path, final String mode) async {
    final result = await run('chmod', [mode, path]);
    debugPrint(result);

    return result;
  }

  //implementation of chown command
  static Future<String> chown(final String path, final String owner) async {
    final result = await run('chown', [owner, path]);
    debugPrint(result);

    return result;
  }

  static Future<void> stopRootProcess() async {
    await stdin.close();
    Process.killPid(pid);
  }
}
