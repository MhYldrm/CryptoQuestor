import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Localizations
// This allows for simple access to translations in any widget or context.
/// [DeviceFrame] for getting the device's height and width, using [MediaQuery].
// [deviceHeight] Returns the height of the device's screen in logical pixels.
// [deviceWidht] Returns the width of the device's screen in logical pixels.
///
extension LocalizedBuildContext on BuildContext {
   AppLocalizations get mLocalizations => AppLocalizations.of(this)!;
}
// Device Frame
extension DeviceFrame on BuildContext {
  double get deviceHeight => MediaQuery.sizeOf(this).height;
  double get deviceWidht => MediaQuery.sizeOf(this).width;
}