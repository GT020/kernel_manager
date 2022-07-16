import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:penguin_kernel_manager/app/core/router/router.dart';
import 'package:penguin_kernel_manager/app/core/theme/app_theme.dart';
import 'package:penguin_kernel_manager/l10n/l10n.dart';

class KernelManager extends ConsumerWidget {
  /// [KernelManager] constructor.
  // ignore: prefer_final_parameters
  const KernelManager({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final appTheme = ref.read(appThemeProvider);
    final router = ref.read(routerProvider);

    return MaterialApp.router(
      title: 'Kernel Manager',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
