import 'package:crypto_questor/feature/screens/intro_page/intro_page.dart';
import 'package:crypto_questor/feature/screens/sign_up_page/sign_up_page.dart';
import 'package:crypto_questor/feature/screens/splash_page/widgets/animated_indicator_widget.dart';
import 'package:crypto_questor/feature/screens/splash_page/widgets/carousel_slider_widget.dart';
import 'package:crypto_questor/feature/widgets/change_theme_switch_widget.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../product/components/button/my_custom_button.dart';
import '../../../product/components/padding/project_paddings.dart';
import '../../../product/components/styles/application_constants.dart';
import '../../../product/services/firebase_service.dart';
import '../sign_up_page/widget/existing_account_link_widget.dart';
import 'mixin/splash_page_mixin.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SplashPageMixin {
  final FirebaseService _authService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = context.isDarkMode;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool isAuthenticated = _authService.isAuthenticated();
      if (isAuthenticated) {
        context.pushReplacement(const IntroPage());
      }
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.projectTheme!.primaryColor,
        body: Padding(
          padding: const ProjectPaddings.allMedium(),
          child: Column(
            children: [
              Expanded(
                flex: 12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CarouselSliderWidget(
                      items: imagesList,
                      onIndexChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    AnimatedIndicatorWidget(
                      activeIndex: currentIndex,
                      count: imagesList.length,
                    ),
                    ChangeThemeSwitchWidget(isDarkTheme: isDarkTheme),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    MyCustomButton(
                      onPressed: () {
                        context.pushReplacement(const SignUpPage());
                      },
                      buttonText: ApplicationConstants.getStarted,
                    ),
                    ExistingAccountLinkWidget(widht: context.deviceWidht / 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
