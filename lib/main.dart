import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:penguin_kernel_manager/app/app.dart';
import 'package:penguin_kernel_manager/app/core/local_storage/app_storage.dart';
import 'package:penguin_kernel_manager/app/utils/root_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize root shell
  await RootShell.initializeRootShell();

  // for initializing local storage
  final appStorage = AppStorage();
  await appStorage.initAppStorage();

  runApp(
    ProviderScope(
      overrides: [
        appStorageProvider.overrideWithValue(appStorage),
      ],
      child: const KernelManager(),
    ),
  );
}
