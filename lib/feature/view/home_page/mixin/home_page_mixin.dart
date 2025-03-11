/// A mixin to manage coin sorting operations in the [HomePage] widget.
/// This mixin provides methods to sort the coins based on various criteria such as gainers, losers, and hot coins.
///
/// [sortGainersCoins] - Sorts the list of coins by market cap change percentage in the last 24 hours, in descending order.
/// This method is used to identify the coins that have gained the most in the past 24 hours.
///
/// [sortLosersCoins] - Sorts the list of coins by market cap change percentage in the last 24 hours, in ascending order.
/// This method is used to identify the coins that have lost the most in the past 24 hours.
///
/// [sortHotCoins] - Sorts the list of coins by total trading volume, in descending order.
/// This method is used to identify the coins that have the highest trading volume, usually indicating increased market interest.
/// [coins] - The list of coins to be sorted.
/// [_pageController] To manage page changes from the bottom nav bar on the homepage
///
part of '../home_page.dart';

mixin HomePageMixin on State<HomePage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Fetch initial data using Future.micro task for better performance.
    Future.microtask(() {
      context.read<PortfolioCoinsViewModel>().getPortfolioCoins();
      context.read<GeckoCoinsViewModel>().getGeckoApiCoins();
    });
  }

  List sortGainersCoins(List? coins) {
    if (coins == null) return [];
    List sortedCoins = List.from(coins);
    sortedCoins.sort((a, b) => b.marketCapChangePercentage24H.compareTo(a.marketCapChangePercentage24H));
    return sortedCoins;
  }

  List sortLosersCoins(List? coins) {
    if (coins == null) return [];
    List sortedCoins = List.from(coins);
    sortedCoins.sort((a, b) => a.marketCapChangePercentage24H.compareTo(b.marketCapChangePercentage24H));
    return sortedCoins;
  }

  List sortHotCoins(List? coins) {
    if (coins == null) return [];
    List sortedCoins = List.from(coins);
    sortedCoins.sort((a, b) => b.totalVolume.compareTo(a.totalVolume));
    return sortedCoins;
  }
}
