library home_page;

import 'package:crypto_questor/feature/view_models/gecko_coins_view_model.dart';
import 'package:crypto_questor/product/components/styles/project_sizes.dart';
import 'package:provider/provider.dart';
import 'package:crypto_questor/product/components/styles/project_exports.dart';
import '../../../product/components/styles/project_functions.dart';
import '../../../product/components/widgets/coin_card.dart';
import '../../../product/components/widgets/coin_list_card.dart';
import '../../../product/components/widgets/credit_card.dart';
import '../../../product/models/gecko_model.dart';
import '../../../product/models/portfolio_coins_model.dart';
import '../../view_models/portfolio_coins_view_model.dart';
import '../portfolio_coin_history_page/portfolio_coin_history_page.dart';

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
/// - [PortfolioCoinsCardWidget] lists the user's portfolio coins.
/// - [CategoriesCoinsPartWidget] displays categorized coin data (e.g., gainers, losers).
///
part 'widget/all_coins_widget.dart';
part 'widget/categories_coins_part_widget.dart';
part 'widget/categoires_names_part_widget.dart';
part 'widget/portfolio_coins_card_widget.dart';
part 'widget/portfolio_coins_section_widget.dart';
part 'widget/sorted_gainers_coins_widget.dart';
part 'widget/sorted_hot_coins_widget.dart';
part 'widget/sorted_losers_coins_widget.dart';
part 'widget/top_bar_user_info_widget.dart';
part 'mixin/home_page_mixin.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
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
              const PortfolioCoinsSectionWidget(),

              // Categories Section (Gainers, Losers, Hot Coins)
              Consumer<GeckoCoinsViewModel>(
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
                        pageController: _pageController,
                      ),

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
