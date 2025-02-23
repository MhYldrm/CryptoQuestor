import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../feature/view_models/gecko_coins_view_model.dart';
import '../../feature/view_models/portfolio_coins_view_model.dart';
import '../../feature/view_models/project_theme_view_model.dart';
import '../init/theme/project_theme.dart';

/// Localizations
// This extension provides easy access to translations in any widget or context.
// [mLocalizations] Retrieves the current localization instance (translations) for the context.
extension LocalizedBuildContext on BuildContext {
  AppLocalizations get mLocalizations => AppLocalizations.of(this)!;
}

/// Device Frame
// This extension allows access to the device's height and width using [MediaQuery].
// [deviceHeight] Returns the height of the device's screen in logical pixels.
// [deviceWidht] Returns the width of the device's screen in logical pixels.
extension DeviceFrame on BuildContext {
  double get deviceHeight => MediaQuery.sizeOf(this).height;
  double get deviceWidht => MediaQuery.sizeOf(this).width;
}

/// Theme Data Extension
// This extension provides an easy way to access the current [ThemeData] of the app.
extension ThemeDataExtension on BuildContext {
  ThemeData? get projectTheme => Theme.of(this);
}

extension ThemeContextExtensions on BuildContext {
  /// Checks if the current theme is dark mode.
  bool get isDarkMode {
    final themeProvider =
        Provider.of<ProjectThemeViewModel>(this, listen: false);
    return themeProvider.themeData == darkTheme;
  }
}

extension NavigatorExtension on BuildContext {
  /// Pushes a new page onto the navigator stack and returns the result of the navigation.
  Future<T?> push<T>(Widget page) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// Replaces the current page with a new page and returns the result of the navigation.
  Future<T?> pushReplacement<T, TO>(Widget page) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// Pushes a new page and removes all previous pages from the stack until the predicate condition is met.
  Future<T?> pushAndRemoveUntil<T>(
      Widget page, bool Function(Route<dynamic>) predicate) {
    return Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => page),
      predicate,
    );
  }
}

/// Text Styles
// Extensions for easy access to the app's text styles (based on the theme).
// [TextThemeTitleSmall] font Size: 14
// [TextThemeTitleMedium] font Size: 16
// [TextThemeTitleLarge] font Size: 20
// [TextThemeBodySmall] font Size: 12
// [TextThemeBodyMedium] font Size: 14
// [TextThemeBodyLarge] font Size: 16
// [TextThemeLabelSmall] font Size: 10
// [TextThemeLabelMedium] font Size: 12
// [TextThemeLabelLarge] font Size: 14
// [textThemeHeadLineSmall] font Size: 24

extension TextThemeStyles on BuildContext {
  TextStyle? get textThemeTitleSmall => Theme.of(this).textTheme.titleSmall;
  TextStyle? get textThemeTitleMedium => Theme.of(this).textTheme.titleMedium;
  TextStyle? get textThemeTitleLarge => Theme.of(this).textTheme.titleLarge;
  TextStyle? get textThemeBodySmall => Theme.of(this).textTheme.bodySmall;
  TextStyle? get textThemeBodyMedium => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get textThemeBodyLarge => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get textThemeLabelSmall => Theme.of(this).textTheme.labelSmall;
  TextStyle? get textThemeLabelMedium => Theme.of(this).textTheme.labelMedium;
  TextStyle? get textThemeLabelLarge => Theme.of(this).textTheme.labelLarge;
  TextStyle? get textThemeHeadLineSmall =>
      Theme.of(this).textTheme.headlineSmall;
}

extension ProviderExtensions on BuildContext {
  /// Provides access to the [GeckoCoinsProvider] without listening to changes.
  GeckoCoinsViewModel get geckoProvider =>
      Provider.of<GeckoCoinsViewModel>(this, listen: false);

  /// Provides access to the [PortfolioCoinsProvider] without listening to changes.
  PortfolioCoinsViewModel get portfolioCoinsProvider =>
      Provider.of<PortfolioCoinsViewModel>(this, listen: false);
}
