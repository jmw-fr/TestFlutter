import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'features/home/home_page.dart';
import 'settings/settings_controller.dart';
import 'theme/theme_data.dart';

class CineApp extends StatelessWidget {
  const CineApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: settingsController,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.appTitle,
            theme: themeData,
            darkTheme: themeDataDark,
            themeMode: settingsController.themeMode,
            home: const HomePage(),
            restorationScopeId: 'cineApp',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        });
  }
}
