import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Localizations
// This allows for simple access to translations in any widget or context.
extension LocalizedBuildContext on BuildContext {
  AppLocalizations get mLocalizations => AppLocalizations.of(this)!;
}

/// [DeviceFrame] for getting the device's height and width, using [MediaQuery].
// [deviceHeight] Returns the height of the device's screen in logical pixels.
// [deviceWidht] Returns the width of the device's screen in logical pixels.
extension DeviceFrame on BuildContext {
  double get deviceHeight => MediaQuery.sizeOf(this).height;
  double get deviceWidht => MediaQuery.sizeOf(this).width;
}

/// Text Styles
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
  TextStyle? get textThemeHeadLineSmall => Theme.of(this).textTheme.headlineSmall;
}