import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Localization manager for handling supported locales and delegates.
/// This class is responsible for configuring the localization settings for the app.
/// It includes the list of delegates needed for localization and the supported locales.
/// Defines which languages and regions are supported by the app.
/// Currently, [English (US)] and [Turkish (TR)] are supported.
///
@immutable
final class LocalizationSettings {
  const LocalizationSettings._();
  static const List<LocalizationsDelegate> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('tr', 'TR'),
  ];
}
