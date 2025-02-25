import 'package:crypto_questor/feature/view_models/project_theme_view_model.dart';
import 'package:crypto_questor/product/components/localization/localization_settings.dart';
import 'package:crypto_questor/product/init/app_initialize.dart';
import 'package:crypto_questor/product/components/styles/project_exports.dart';
import 'package:crypto_questor/product/locator/locator.dart';
import 'package:provider/provider.dart';
import 'feature/view/splash_page/splash_page.dart';


void main() async {
  await AppInitialize.makeIt();
  setupLocator();
  runApp(
    MultiProvider(
      providers: AppInitialize.getProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ProjectConstants.appTitle,
      localizationsDelegates: LocalizationSettings.localizationsDelegates,
      supportedLocales: LocalizationSettings.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ProjectThemeViewModel>(context).themeData,
      home: const SplashPage(),
    );
  }
}
