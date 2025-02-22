import 'package:crypto_questor/feature/screens/home_page/widget/sorted_gainers_coins_widget.dart';
import 'package:crypto_questor/feature/screens/home_page/widget/sorted_hot_coins_widget.dart';
import 'package:crypto_questor/feature/screens/home_page/widget/sorted_losers_coins_widget.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/models/gecko_models.dart';
import 'all_coins_widget.dart';

/// [CategoriesCoinsPartWidget] is a stateless widget that displays different categories
/// of cryptocurrencies in separate pages within a [PageView].
///
/// ### Key Responsibilities:
/// - Provides a paginated view for different coin categories, including:
///   - All Coins
///   - Hot Coins (sorted by volume)
///   - Gainers (sorted by market cap change percentage)
///   - Losers (sorted by market cap change percentage)
///
/// ### Parameters:
/// - [pageController] A [PageController] instance to control page navigation.
/// - [isLoading] A boolean indicating if the data is still being fetched.
/// - [allCoinsList] A list of all available cryptocurrency data ([GeckoModel]).
/// - [sortedHotCoins] A list of the "Hot Coins," sorted based on their volume.
/// - [sortedGainersCoins] A list of the "Gainers," sorted by market cap change percentage.
/// - [sortedLosersCoins] A list of the "Losers," sorted by market cap change percentage.
///
/// ### UI Details:
/// - The widget uses a [PageView] to display the following children:
///   - [AllCoinsWidget] Displays all coins.
///   - [SortedHotCoinsWidget] Displays the sorted "Hot Coins."
///   - [SortedGainersCoinsWidget] Displays the sorted "Gainers."
///   - [SortedLosersCoinsWidget] Displays the sorted "Losers."
///

class CategoriesCoinsPartWidget extends StatelessWidget {
  const CategoriesCoinsPartWidget({
    super.key,
    required this.pageController,
    required this.isLoading,
    required this.allCoinsList,
    required this.sortedHotCoins,
    required this.sortedGainersCoins,
    required this.sortedLosersCoins,
  });

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
          // All Coins Page
          AllCoinsWidget(
            isLoading: isLoading,
            coinMarket: allCoinsList,
          ),
          // Hot Coins Page
          SortedHotCoinsWidget(
            isLoading: isLoading,
            sortedHotCoins: sortedHotCoins,
          ),
          // Gainers Coins Page
          SortedGainersCoinsWidget(
            isLoading: isLoading,
            sortedGainersCoins: sortedGainersCoins,
          ),
          // Losers Coins Page
          SortedLosersCoinsWidget(
            isLoading: isLoading,
            sortedLosersCoins: sortedLosersCoins,
          ),
        ],
      ),
    );
  }
}
