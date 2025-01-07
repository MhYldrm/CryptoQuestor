import 'package:crypto_questor/feature/providers/portfolio_coins_provider.dart';
import 'package:crypto_questor/feature/screens/home_page/widget/categoires_names_part_widget.dart';
import 'package:crypto_questor/feature/screens/home_page/widget/categories_coins_part_widget.dart';
import 'package:crypto_questor/feature/screens/home_page/widget/portfolio_coins_part_widget.dart';
import 'package:crypto_questor/feature/screens/home_page/widget/top_bar_user_info_widget.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../product/components/styles/my_functions.dart';
import '../../providers/gecko_coins_provider.dart';
import '../../widgets/credit_card.dart';
import '../../widgets/empty_widget.dart';
import 'mixin/home_page_mixin.dart';

/// [HomePage] is the main screen of the application, serving as the dashboard for users.
///
/// ### Key Responsibilities:
/// - Displays user portfolio information, including the total balance and spending.
/// - Shows categories of coins (e.g., gainers, losers, hot coins) with their data.
/// - Fetches and processes data using [PortfolioCoinsProvider] and [GeckoCoinsProvider].
/// - Provides a clean, scrollable interface with user-friendly components.
///
/// ### State Management:
/// - Uses [Provider] to manage state for portfolio and market data.
/// - [PortfolioCoinsProvider] handles user's portfolio data.
/// - [GeckoCoinsProvider] handles market data (e.g., gainers, losers, hot coins).
///
/// ### Mixins:
/// - Includes [HomePageMixin] for helper methods like sorting and processing coins.
///
/// ### Widgets:
/// - [TopBarUserInfo] displays a greeting and user information.
/// - [CreditCard] shows the user's total current value and total spent.
/// - [PortfolioCoinsPartWidget] lists the user's portfolio coins.
/// - [CategoriesCoinsPartWidget] displays categorized coin data (e.g., gainers, losers).
///
final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Fetch initial data using Future.micro task for better performance.
    Future.microtask(() {
      context.read<PortfolioCoinsProvider>().getPortfolioCoins();
      context.read<GeckoCoinsProvider>().getGeckoApiCoins();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.projectTheme!.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // User information at the top bar
              const TopBarUserInfo(),

              // Portfolio Coins Section
              Consumer<PortfolioCoinsProvider>(
                builder: (context, portfolioCoinsProvider, child) {
                  final geckoProvider = context.watch<GeckoCoinsProvider>();
                  double totalSpent = 0;
                  double accountBalance = 0;

                  /// [resultList] List that collects the purchase and sale transactions of coins from Firebase and returns a single data for each coin
                  final resultList = MyFunctions().processPortfolioCoins(
                      portfolioCoinsProvider.portfolioCoins,
                      geckoProvider.coins!);

                  for (var coin in resultList) {
                    totalSpent += double.parse(coin.totalSpent);
                    accountBalance += double.parse(coin.currentValue!);
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Credit card displaying portfolio summary
                      CreditCard(
                        totalCurrentValue: accountBalance,
                        totalSpent: totalSpent,
                      ),
                      const EmptyWidget(height: 30), // Spacing

                      // List of user's portfolio coins
                      PortfolioCoinsPartWidget(
                        portfolioCoins: portfolioCoinsProvider.portfolioCoins,
                        resultList: resultList,
                        isLoading: portfolioCoinsProvider.isLoading,
                      ),
                    ],
                  );
                },
              ),

              // Categories Section (Gainers, Losers, Hot Coins)
              Consumer<GeckoCoinsProvider>(
                builder: (context, geckoProvider, child) {
                  List sortedGainersCoins =
                      sortGainersCoins(geckoProvider.coins);
                  List sortedLosersCoins = sortLosersCoins(geckoProvider.coins);
                  List sortedHotCoins = sortHotCoins(geckoProvider.coins);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Widget to display category names (tabs)
                      CategoriesNamesPartWidget(
                          pageController: _pageController),

                      // Widget to display categorized coins
                      CategoriesCoinsPartWidget(
                        pageController: _pageController,
                        isLoading: geckoProvider.isLoading,
                        allCoinsList: geckoProvider.coins,
                        sortedHotCoins: sortedHotCoins,
                        sortedGainersCoins: sortedGainersCoins,
                        sortedLosersCoins: sortedLosersCoins,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
