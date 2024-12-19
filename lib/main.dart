import 'package:crypto_questor/feature/screens/splash_page/splash_page.dart';
import 'package:crypto_questor/product/components/localization/localization_settings.dart';
import 'package:crypto_questor/product/components/styles/application_constants.dart';
import 'package:crypto_questor/product/components/theme/theme_provider.dart';
import 'package:crypto_questor/product/init/app_initialize.dart';
import 'package:crypto_questor/product/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await AppInitialize.makeIt();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
        ChangeNotifierProvider(create: (_) => ThemeProvider(),),
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
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const SplashPage(),
    );
  }
}
