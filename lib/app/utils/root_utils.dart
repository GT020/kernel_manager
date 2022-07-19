import 'dart:convert';
import 'dart:io';

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
