import 'package:crypto_questor/feature/screens/intro_page/widget/custom_material_button.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../product/components/styles/custom_colors.dart';
import '../earn_page/earn_page.dart';
import '../home_page/home_page.dart';
import '../portfolio_page/portfolio_page.dart';
import '../profile_page/profile_page.dart';
import 'mixin/intro_page_mixin.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with IntroPageMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        notchMargin: 17,
        color: CustomColors.bgcolor,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomMaterialButton(
                icon: Icons.home_filled,
                label: context.mLocalizations.homePage,
                isSelected: currentTab == 0,
                onTap: () {
                  setState(() {
                    currentScreen = const HomePage();
                    currentTab = 0;
                  });
                },
              ),
              CustomMaterialButton(
                icon: Icons.currency_bitcoin_rounded,
                label: context.mLocalizations.earn,
                isSelected: currentTab == 1,
                onTap: () {
                  setState(() {
                    currentScreen = const EarnPage();
                    currentTab = 1;
                  });
                },
              ),
              CustomMaterialButton(
                icon: Icons.pie_chart_outline_rounded,
                label: context.mLocalizations.myPortfolio,
                isSelected: currentTab == 2,
                onTap: () {
                  setState(() {
                    currentScreen = const PortfolioPage();
                    currentTab = 2;
                  });
                },
              ),
              CustomMaterialButton(
                icon: Icons.person_2_rounded,
                label: context.mLocalizations.profile,
                isSelected: currentTab == 3,
                onTap: () {
                  setState(() {
                    currentScreen = const ProfilePage();
                    currentTab = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
