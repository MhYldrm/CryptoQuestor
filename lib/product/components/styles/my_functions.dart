import '../../models/gecko_model.dart';
import '../../models/portfolio_coins_model.dart';

/// [MyFunctions] A utility class containing helper functions for processing portfolio-related data.
/// It includes methods for summarizing and aggregating coin quantities and spending in the portfolio.
/// [summarizeCoin] Summarizes the portfolio data by aggregating the total quantity of coins and the total amount spent for each unique coin.
///
final class MyFunctions {
  /// Summarizes the current value of each coin in the portfolio by matching with the GeckoModel data.
  /// This method multiplies the coin quantity with its current price to calculate the current value.
  ///
  /// [portfolioCoins] List of the user's portfolio coins.
  /// [geckoCoins] List of the coins data fetched from CoinGecko API.
  /// Returns a list of PortfolioCoinsModel with updated current values.
  List<PortfolioCoinsModel> summarizePortfolioCoinsCurrentValue(
    List<PortfolioCoinsModel> portfolioCoins,
    List<GeckoModel> geckoCoins,
  ) {
    return portfolioCoins.map((portfolioCoin) {
      // Find the matching coin from GeckoModel
      final matchingGeckoCoin = geckoCoins.firstWhere(
        (geckoCoin) => geckoCoin.symbol == portfolioCoin.symbol,
      );

      // If a matching GeckoModel exists, calculate the current value
      final currentValue = matchingGeckoCoin != null
          ? (double.tryParse(portfolioCoin.quantity) ?? 0) *
              matchingGeckoCoin.currentPrice
          : null;

      // Return a new PortfolioCoinsModel object
      return PortfolioCoinsModel(
        dateTime: portfolioCoin.dateTime,
        imageUrl: portfolioCoin.imageUrl,
        name: portfolioCoin.name,
        quantity: portfolioCoin.quantity,
        symbol: portfolioCoin.symbol,
        totalSpent: portfolioCoin.totalSpent,
        uid: portfolioCoin.uid,
        currentValue: currentValue?.toStringAsFixed(
            2), // Convert to string and round to 2 decimal places
      );
    }).toList();
  }

  /// Processes the portfolio coins by aggregating quantities and total spent for each unique coin.
  /// It combines coins with the same name and symbol, adding up their quantities and total spending.
  /// After processing, it calculates the current value for each unique coin.
  ///
  /// [portfolioCoins] List of the user's portfolio coins.
  /// [geckoCoins] List of the coins data fetched from CoinGecko API.
  /// Returns a list of aggregated and processed PortfolioCoinsModel.
  List<PortfolioCoinsModel> processPortfolioCoins(
    List<PortfolioCoinsModel> portfolioCoins,
    List<GeckoModel> geckoCoins,
  ) {
    Map<String, PortfolioCoinsModel> summary = {};

    for (var item in portfolioCoins) {
      String name = item.name;
      String symbol = item.symbol;
      String imageUrl = item.imageUrl;
      double quantity = double.parse(item.quantity);
      double totalSpent = double.parse(item.totalSpent);

      if (summary.containsKey(name)) {
        var existing = summary[name]!;
        summary[name] = existing.copyWith(
          quantity: (double.parse(existing.quantity) + quantity).toString(),
          totalSpent:
              (double.parse(existing.totalSpent) + totalSpent).toString(),
        );
      } else {
        summary[name] = PortfolioCoinsModel(
          dateTime: item.dateTime,
          imageUrl: imageUrl,
          name: name,
          quantity: quantity.toString(),
          symbol: symbol,
          totalSpent: totalSpent.toString(),
          uid: item.uid,
        );
      }
    }

    // Summarized list of coins
    List<PortfolioCoinsModel> summarizedCoins = summary.values.toList();

    // Calculate currentValue for each summarized coin
    return summarizedCoins.map((portfolioCoin) {
      // Find the matching coin from GeckoModel
      final matchingGeckoCoin = geckoCoins.firstWhere(
        (geckoCoin) => geckoCoin.symbol == portfolioCoin.symbol,
      );

      // If a matching GeckoModel exists, calculate the current value
      final currentValue = matchingGeckoCoin != null
          ? (double.tryParse(portfolioCoin.quantity) ?? 0) *
              matchingGeckoCoin.currentPrice
          : null;

      final priceChange24H = matchingGeckoCoin.priceChange24H;

      // Return a new PortfolioCoinsModel object
      return PortfolioCoinsModel(
        dateTime: portfolioCoin.dateTime,
        imageUrl: portfolioCoin.imageUrl,
        name: portfolioCoin.name,
        quantity: portfolioCoin.quantity,
        symbol: portfolioCoin.symbol,
        totalSpent: portfolioCoin.totalSpent,
        priceChange24H: priceChange24H,
        uid: portfolioCoin.uid,
        currentValue: currentValue?.toStringAsFixed(
            2), // Convert to string and round to 2 decimal places
      );
    }).toList();
  }

  /// Calculates the percentage change between the current value and total spent.
  /// It is useful for showing the profit or loss percentage of the portfolio.
  ///
  /// [currentValue] The current value of the coin in the portfolio.
  /// [totalSpent] The total amount spent on the coin.
  /// Returns the percentage change as a double.
  double calculatePercentage(double currentValue, double totalSpent) {
    double percentage = ((currentValue - totalSpent) * 100) / totalSpent;
    return percentage;
  }
}
