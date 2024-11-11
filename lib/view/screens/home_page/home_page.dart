import 'package:crypto_questor/view/screens/home_page/mixin/home_page_mixin.dart';
import 'package:crypto_questor/view/screens/home_page/widget/categoires_names_part_widget.dart';
import 'package:crypto_questor/view/screens/home_page/widget/categories_coins_part_widget.dart';
import 'package:crypto_questor/view/screens/home_page/widget/portfolio_coins_part_widget.dart';
import 'package:crypto_questor/view/screens/home_page/widget/top_bar_user_info_widget.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/view/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import '../../../core/models/gecko_models.dart';
import '../../../core/models/portfolio_coins_model.dart';
import '../../../core/services/coin_services.dart';
import '../../../core/components/styles/my_functions.dart';
import '../../../core/services/firebase_service.dart';
import '../../widgets/credit_card.dart';

/// The HomePage widget represents the main screen of the application.
/// It displays the user's portfolio coins, top gainers, losers, and hot coins.
///
/// [_fetchAllCoins] - Fetches all coin details from the CoinGecko API
/// [coinMarket] - A list containing all coins data fetched from the CoinGecko API.
/// [isLoading] - A flag indicating whether the coin data has been loaded or not. with [_fetchAllCoins]
/// [portfolioCoins] - The list of coins in the user's portfolio.
/// [_fetchPortfolioCoins] - Fetches the portfolio coins details from Firebase
/// [_allCoinsInPortfolio] - A list containing the portfolio coins' information.
/// [_isLoading] - A flag indicating whether the coin data has been loaded or not. with [_fetchPortfolioCoins]
/// [totalSpentSum] - The total amount spent on the coins in the portfolio.
/// [sortedGainersCoins], [sortedLosersCoins], [sortedHotCoins] - Lists of coins sorted by gainers, losers, and hot coins respectively.
/// [_pageController] // PageController for the CategoriesCoins section page-view
///
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  final PageController _pageController = PageController();

  /// Gets details of coins in the portfolio from Firebase
  ///
  List<PortfolioCoinsModel> _allCoinsInPortfolio = [];
  bool _isLoading = true;
  Future<void> _fetchPortfolioCoins() async {
    _allCoinsInPortfolio = await FirebaseService().getPortfolioCoins();
    setState(() {
      _isLoading = false;
    });
  }

  /// Gets all coins details from Gecko Api
  ///
  List<GeckoModel>? coinMarket = [];
  bool? isLoading;
  Future<void> _fetchAllCoins() async {
    coinMarket = await CoinService().getCoinsFromCoinGeckoApi();
    setState(() {
      isLoading = coinMarket!.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPortfolioCoins();
    _fetchAllCoins();
  }

  @override
  Widget build(BuildContext context) {
    /// sort coins from geckoApi
    ///
    List sortedGainersCoins = sortGainersCoins(coinMarket);
    List sortedLosersCoins = sortLosersCoins(coinMarket);
    List sortedHotCoins = sortHotCoins(coinMarket);

    /// To calculate total spent of coins in the portfolio
    double totalSpentSum = 0;
    final result = MyFunctions().summarizeCoin(_allCoinsInPortfolio);
    for (var item in result) {
      totalSpentSum += double.parse(item.totalSpent);
    }
    return SafeArea(
        child: Scaffold(
      backgroundColor: CustomColors.bgcolor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TopBarUserInfo(),
            CreditCard(
              balance: totalSpentSum.toStringAsFixed(2),
            ),
            const EmptyWidget(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PortfolioCoinsPartWidget(
                  portfolioCoins: _allCoinsInPortfolio,
                  resultList: result,
                  isLoading: _isLoading,
                ),
                CategoriesNamesPartWidget(pageController: _pageController),
                CategoriesCoinsPartWidget(
                  pageController: _pageController,
                  isLoading: isLoading ?? false,
                  allCoinsList: coinMarket,
                  sortedHotCoins: sortedHotCoins,
                  sortedGainersCoins: sortedGainersCoins,
                  sortedLosersCoins: sortedLosersCoins,
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
