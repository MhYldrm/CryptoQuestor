library intro_page;

import 'package:crypto_questor/product/components/styles/application_constants.dart';
import 'package:crypto_questor/product/components/styles/application_size.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../product/components/styles/custom_colors.dart';
import '../earn_page/earn_page.dart';
import '../home_page/home_page.dart';
import '../portfolio_page/portfolio_page.dart';
import '../profile_page/profile_page.dart';

/// [IntroPage] represents the main entry point of the app with a bottom navigation bar.
///
/// It serves as a container for the core screens of the app, such as Home, Earn, Portfolio, and Profile.
/// The navigation allows the user to switch between these different screens by updating the current screen and state.
///
/// ### Key Responsibilities:
/// - Displays a bottom navigation bar with icons and labels.
/// - Allows navigation between four main pages: Home, Earn, Portfolio, and Profile.
/// - Keeps track of the current screen and tab selection using [IntroPageMixin].
///
part 'widget/custom_material_button.dart';
part 'mixin/intro_page_mixin.dart';

final class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with IntroPageMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Body holds the page that changes based on the bottom navigation selection
        body: PageStorage(bucket: bucket, child: currentScreen),

        // Bottom navigation bar for navigating between different pages
        bottomNavigationBar: BottomAppBar(
          elevation: ApplicationSize.size11.value,
          notchMargin: ApplicationSize.xSmall.value,
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
            height: ApplicationSize.size60.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Home Page Button
                CustomMaterialButton(
                  icon: Icons.home_filled,
                  label: context.mLocalizations.homePage,
                  isSelected: currentTab == ApplicationConstants.zeroNumInt,
                  onTap: () {
                    setState(() {
                      currentScreen = const HomePage();
                      currentTab = ApplicationConstants
                          .zeroNumInt; // Set the current tab to Home
                    });
                  },
                ),

                // Earn Page Button
                CustomMaterialButton(
                  icon: Icons.currency_bitcoin_rounded,
                  label: context.mLocalizations.earn,
                  isSelected: currentTab == ApplicationConstants.oneNumInt,
                  onTap: () {
                    setState(() {
                      currentScreen = const EarnPage();
                      currentTab = ApplicationConstants
                          .oneNumInt; // Set the current tab to Earn
                    });
                  },
                ),

                // Portfolio Page Button
                CustomMaterialButton(
                  icon: Icons.pie_chart_outline_rounded,
                  label: context.mLocalizations.myPortfolio,
                  isSelected: currentTab == ApplicationConstants.twoNumInt,
                  onTap: () {
                    setState(() {
                      currentScreen = const PortfolioPage();
                      currentTab = ApplicationConstants
                          .twoNumInt; // Set the current tab to Portfolio
                    });
                  },
                ),

                // Profile Page Button
                CustomMaterialButton(
                  icon: Icons.person_2_rounded,
                  label: context.mLocalizations.profile,
                  isSelected: currentTab == ApplicationConstants.threeNumInt,
                  onTap: () {
                    setState(() {
                      currentScreen = const ProfilePage();
                      currentTab = ApplicationConstants
                          .threeNumInt; // Set the current tab to Profile
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
