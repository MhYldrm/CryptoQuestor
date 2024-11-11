import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/view/screens/home_page/widget/sorted_gainers_coins_widget.dart';
import 'package:crypto_questor/view/screens/home_page/widget/sorted_hot_coins_widget.dart';
import 'package:crypto_questor/view/screens/home_page/widget/sorted_losers_coins_widget.dart';
import 'package:flutter/material.dart';
import '../../../../core/models/gecko_models.dart';
import 'all_coins_widget.dart';

/// A widget that displays different categories of coins as separate pages inside a PageView.
///
/// This widget allows users to view different categories of coins, such as all coins, hot coins, gainers, and losers.
/// Each category has its own list of coins displayed in a separate page.
///
/// [pageController] - The [PageController] used to control the PageView.
/// [isLoading] - A boolean flag to indicate whether the data is still loading.
/// [allCoinsList] - A list containing all the coins.
/// [sortedHotCoins] - A sorted list of "Hot Coins" based on volume.
/// [sortedGainersCoins] - A sorted list of "Gainers Coins" based on market cap change percentage.
/// [sortedLosersCoins] - A sorted list of "Losers Coins" based on market cap change percentage.
///
class CategoriesCoinsPartWidget extends StatelessWidget {
  const CategoriesCoinsPartWidget(
      {super.key,
      required this.pageController,
      required this.isLoading,
      required this.allCoinsList,
      required this.sortedHotCoins,
      required this.sortedGainersCoins,
      required this.sortedLosersCoins});

  final PageController pageController;
  final bool isLoading;
  final List<GeckoModel>? allCoinsList;
  final List<dynamic> sortedHotCoins;
  final List<dynamic> sortedGainersCoins;
  final List<dynamic> sortedLosersCoins;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.deviceHeight * 0.5,
      width: double.infinity,
      child: PageView(
        controller: pageController,
        children: [
          AllCoinsWidget(isLoading: isLoading, coinMarket: allCoinsList),
          SortedHotCoinsWidget(
              isLoading: isLoading, sortedHotCoins: sortedHotCoins),
          SortedGainersCoinsWidget(
              isLoading: isLoading, sortedGainersCoins: sortedGainersCoins),
          SortedLosersCoinsWidget(
              isLoading: isLoading, sortedLosersCoins: sortedLosersCoins),
        ],
      ),
    );
  }
}
