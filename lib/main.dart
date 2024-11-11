import 'package:crypto_questor/core/components/localization/localization_settings.dart';
import 'package:crypto_questor/core/init/app_initialize.dart';
import 'package:crypto_questor/core/models/user_provider.dart';
import 'package:crypto_questor/view/screens/sign_in_page/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/components/styles/application_constants.dart';

void main() async {
  await AppInitialize.makeIt();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
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
      theme: ThemeData.dark(),
      home: const SignInPage(),
    );
  }
}
