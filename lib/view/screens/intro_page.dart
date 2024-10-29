import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/view/screens/portfolio_page.dart';
import 'package:crypto_questor/view/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'earn_page.dart';
import 'home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  // current page tab
  int currentTab = 0;

  // Page Tab Controller
  final PageStorageBucket bucket = PageStorageBucket();

  // Current Screen
  Widget currentScreen = const HomePage();

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
              showHomePage(context),
              showEarnPage(context),
              showPortfolioPage(context),
              showProfilePage(context),
            ],
          ),
        ),
      ),
    ));
  }

  MaterialButton showProfilePage(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          currentScreen = const ProfilePage();
          currentTab = 3;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.person_2_rounded,
            size: 20,
            color: currentTab == 3
                ? CustomColors.mYellow
                : CustomColors.mGreyPrimary,
          ),
          Text(
            context.mLocalizations.profile,
            style: TextStyle(
              fontSize: 11,
              color: currentTab == 3
                  ? CustomColors.mYellow
                  : CustomColors.mGreyPrimary,
            ),
          )
        ],
      ),
    );
  }

  MaterialButton showPortfolioPage(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          currentScreen = const PortfolioPage();
          currentTab = 2;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.pie_chart_outline_rounded,
            size: 20,
            color: currentTab == 2
                ? CustomColors.mYellow
                : CustomColors.mGreyPrimary,
          ),
          Text(
            context.mLocalizations.myPortfolio,
            style: TextStyle(
              fontSize: 11,
              color: currentTab == 2
                  ? CustomColors.mYellow
                  : CustomColors.mGreyPrimary,
            ),
          )
        ],
      ),
    );
  }

  MaterialButton showEarnPage(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          currentScreen = const EarnPage();
          currentTab = 1;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.currency_bitcoin_rounded,
            size: 20,
            color: currentTab == 1
                ? CustomColors.mYellow
                : CustomColors.mGreyPrimary,
          ),
          Text(
            context.mLocalizations.earn,
            style: TextStyle(
              fontSize: 11,
              color: currentTab == 1
                  ? CustomColors.mYellow
                  : CustomColors.mGreyPrimary,
            ),
          )
        ],
      ),
    );
  }

  MaterialButton showHomePage(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          currentScreen = const HomePage();
          currentTab = 0;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.home_filled,
            size: 20,
            color: currentTab == 0
                ? CustomColors.mYellow
                : CustomColors.mGreyPrimary,
          ),
          Text(
            context.mLocalizations.homePage,
            style: TextStyle(
              fontSize: 11,
              color: currentTab == 0
                  ? CustomColors.mYellow
                  : CustomColors.mGreyPrimary,
            ),
          )
        ],
      ),
    );
  }
}
