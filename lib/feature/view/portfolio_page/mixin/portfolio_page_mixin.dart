/// A mixin to manage the Portfolio Page State.
///
/// [allCoinsInPortfolio] - A list to store the coins present in the user's portfolio.
/// [isLoading] - Indicates whether the portfolio coins are currently being loaded.
/// [fetchPortfolioCoinsFromFirebase] - Gets details of coins in the portfolio from Firebase.
/// [buildCustomAppBar] - Displays a custom app bar with a title and an icon.
///
part of '../portfolio_page.dart';

mixin PortfolioPageMixin on State<PortfolioPage> {
  late TooltipBehavior toolTipBehavior; // Tooltip behavior for chart data

  @override
  void initState() {
    super.initState();

    // Fetch portfolio coins and gecko API coins after the widget is initialized
    Future.microtask(() {
      context.read<PortfolioCoinsViewModel>().getPortfolioCoins();
      context.read<GeckoCoinsViewModel>().getGeckoApiCoins();
    });

    // Initialize the tooltip behavior for charts
    toolTipBehavior = TooltipBehavior(enable: true);
  }

  /// Builds a custom app bar with a title and an icon.
  PreferredSize buildCustomAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: CustomAppBar(
        title: context.mLocalizations.myPortfolio,
        icon: Icons.account_balance_wallet_outlined,
        iconSize: 33,
        iconColor: Colors.black,
      ),
    );
  }
}
