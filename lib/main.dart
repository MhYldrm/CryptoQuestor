import 'package:crypto_questor/feature/providers/gecko_coins_provider.dart';
import 'package:crypto_questor/feature/screens/splash_page/splash_page.dart';
import 'package:crypto_questor/product/components/localization/localization_settings.dart';
import 'package:crypto_questor/product/components/styles/application_constants.dart';
import 'package:crypto_questor/feature/providers/project_theme_provider.dart';
import 'package:crypto_questor/product/init/app_initialize.dart';
import 'package:crypto_questor/feature/providers/user_provider.dart';
import 'package:crypto_questor/product/repository/coin_gecko_repository_impl.dart';
import 'package:crypto_questor/product/repository/portfolio_coins_repository_impl.dart';
import 'package:crypto_questor/product/services/coin_services.dart';
import 'package:crypto_questor/product/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feature/providers/portfolio_coins_provider.dart';

void main() async {
  await AppInitialize.makeIt();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final dataSource = FirebaseService();
            final repository = PortfolioCoinsRepositoryImpl(dataSource);
            return PortfolioCoinsProvider(repository);
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final dataSource = CoinService();
            final repository = CoinGeckoRepositoryImpl(dataSource);
            return GeckoCoinsProvider(repository);
          },
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProjectThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ApplicationConstants.appTitle,
      localizationsDelegates: LocalizationSettings.localizationsDelegates,
      supportedLocales: LocalizationSettings.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ProjectThemeProvider>(context).themeData,
      home: const SplashPage(),
    );
  }
}
