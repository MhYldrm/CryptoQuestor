library intro_page;

import 'package:crypto_questor/product/components/styles/project_constants.dart';
import 'package:crypto_questor/product/components/styles/project_sizes.dart';
import 'package:crypto_questor/product/extension/project_extensions.dart';
import 'package:flutter/material.dart';
import '../../../product/components/styles/project_custom_colors.dart';
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
        body: PageStorage(bucket: _bucket, child: _currentScreen),

        // Bottom navigation bar for navigating between different pages
        bottomNavigationBar: BottomAppBar(
          elevation: ProjectSizes.size11.value,
          notchMargin: ProjectSizes.xSmall.value,
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
            height: ProjectSizes.size60.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Home Page Button
                CustomMaterialButton(
                  icon: Icons.home_filled,
                  label: context.mLocalizations.homePage,
                  isSelected: _currentTab == ProjectConstants.zeroNumInt,
                  onTap: () {
                    setState(() {
                      _currentScreen = const HomePage();
                      _currentTab = ProjectConstants.zeroNumInt; // Set the current tab to Home
                    });
                  },
                ),

                // Earn Page Button
                CustomMaterialButton(
                  icon: Icons.currency_bitcoin_rounded,
                  label: context.mLocalizations.earn,
                  isSelected: _currentTab == ProjectConstants.oneNumInt,
                  onTap: () {
                    setState(() {
                      _currentScreen = const EarnPage();
                      _currentTab = ProjectConstants.oneNumInt; // Set the current tab to Earn
                    });
                  },
                ),

                // Portfolio Page Button
                CustomMaterialButton(
                  icon: Icons.pie_chart_outline_rounded,
                  label: context.mLocalizations.myPortfolio,
                  isSelected: _currentTab == ProjectConstants.twoNumInt,
                  onTap: () {
                    setState(() {
                      _currentScreen = const PortfolioPage();
                      _currentTab = ProjectConstants.twoNumInt; // Set the current tab to Portfolio
                    });
                  },
                ),

                // Profile Page Button
                CustomMaterialButton(
                  icon: Icons.person_2_rounded,
                  label: context.mLocalizations.profile,
                  isSelected: _currentTab == ProjectConstants.threeNumInt,
                  onTap: () {
                    setState(() {
                      _currentScreen = const ProfilePage();
                      _currentTab = ProjectConstants.threeNumInt; // Set the current tab to Profile
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
