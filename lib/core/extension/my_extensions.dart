import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


// Localizations
extension LocalizedBuildContext on BuildContext {
   AppLocalizations get mLocalizations => AppLocalizations.of(this)!;
}


// Device Frame
extension DeviceFrame on BuildContext {
  double get deviceHeight => MediaQuery.sizeOf(this).height;
  double get deviceWidht => MediaQuery.sizeOf(this).width;
}

