import 'package:crypto_questor/feature/screens/intro_page/intro_page.dart';
import 'package:crypto_questor/feature/screens/sign_up_page/sign_up_page.dart';
import 'package:crypto_questor/feature/screens/splash_page/widgets/animated_indicator_widget.dart';
import 'package:crypto_questor/feature/screens/splash_page/widgets/carousel_slider_widget.dart';
import 'package:crypto_questor/feature/widgets/change_theme_switch_widget.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../product/components/button/my_custom_button.dart';
import '../../../product/components/padding/project_paddings.dart';
import '../../../product/services/firebase_service.dart';
import '../sign_up_page/widget/existing_account_link_widget.dart';
import 'mixin/splash_page_mixin.dart';

/// [SplashPage] is the introductory screen of the application, displayed when the app is launched.
/// It provides a visual overview and guides users to either sign up or sign in to their account.
///
/// ### Key Responsibilities:
/// - Displays a carousel with images and descriptions, showcasing key features of the app.
/// - Provides navigation options to either the sign-up or intro page.
/// - Handles theme switching between dark and light modes.
/// - Shows a "Get Started" button to guide users to sign up and links to existing accounts.
///
/// ### State Management:
/// - The page checks for user authentication status using [FirebaseService].
/// - If the user is authenticated, it automatically navigates to the [IntroPage].
/// - State changes for carousel index and theme preference are handled locally within the page.
///
/// ### Mixins:
/// - Includes [SplashPageMixin] for managing the carousel images and descriptions, as well as tracking the active index.
///
/// ### Widgets:
/// - [CarouselSliderWidget] displays a sliding set of images with descriptions.
/// - [AnimatedIndicatorWidget] shows a visual indicator for the current image in the carousel.
/// - [ChangeThemeSwitchWidget] allows users to toggle between light and dark themes.
/// - [MyCustomButton] is used for navigating to the sign-up page.
/// - [ExistingAccountLinkWidget] provides a link for users who already have an account.
///

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
              /// The carousel slider that displays images and descriptions of app features.
              Expanded(
                flex: 13,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CarouselSliderWidget(
                      items: getImagesList(
                          context), // Images and descriptions fetched from the mixin.
                      onIndexChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),

                    /// Animated indicator showing the current position in the carousel.
                    AnimatedIndicatorWidget(
                      activeIndex: currentIndex,
                      count: getImagesList(context).length,
                    ),

                    /// Allows the user to toggle between dark and light themes.
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
                      buttonText: context.mLocalizations.getStarted,
                    ),

                    /// Provides a link to the existing account login page.
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
