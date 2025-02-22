import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../feature/view_models/gecko_coins_view_model.dart';
import '../../feature/view_models/portfolio_coins_view_model.dart';
import '../../feature/view_models/project_theme_view_model.dart';
import '../../feature/view_models/user_view_model.dart';
import '../../firebase_options.dart';
import '../locator/locator.dart';

@immutable
final class AppInitialize {
  const AppInitialize._();

  /// Initializes the app by setting Firebase and system preferences.
  /// This should be called at the start of the app.
  static Future<void> makeIt() async {
    // Ensure Flutter bindings are initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Set the preferred device orientation to portrait mode
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // Initialize Firebase with platform-specific options
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider(
        create: (_) => getIt<PortfolioCoinsViewModel>(),
      ),
      ChangeNotifierProvider(
        create: (_) => getIt<GeckoCoinsViewModel>(),
      ),
      ChangeNotifierProvider(
        create: (_) => getIt<UserViewModel>(),
      ),
      ChangeNotifierProvider(
        create: (_) => getIt<ProjectThemeViewModel>(),
      ),
    ];
  }
}