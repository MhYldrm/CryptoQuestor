import 'package:crypto_questor/ui/views/portfolio_page.dart';
import 'package:crypto_questor/ui/views/profile_page.dart';
import 'package:crypto_questor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'earn_page.dart';
import 'home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomePage(),
    const PortfolioPage(),
    const EarnPage(),
    const ProfilePage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();
  @override
  Widget build(BuildContext context) {
    var mText = AppLocalizations.of(context)!;
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
                  MaterialButton(
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
                          mText.homePage,
                          style: TextStyle(
                              fontSize: 11,
                              color: currentTab == 0
                                  ? CustomColors.mYellow
                                  : CustomColors.mGreyPrimary,),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
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
                          mText.earn,
                          style: TextStyle(
                              fontSize: 11,
                              color: currentTab == 1
                                  ? CustomColors.mYellow
                                  : CustomColors.mGreyPrimary,),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
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
                          mText.myPortfolio,
                          style: TextStyle(
                              fontSize: 11,
                              color: currentTab == 2
                                  ? CustomColors.mYellow
                                  : CustomColors.mGreyPrimary,),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
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
                          mText.profile,
                          style: TextStyle(
                              fontSize: 11,
                              color: currentTab == 3
                                  ? CustomColors.mYellow
                                  : CustomColors.mGreyPrimary,),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
