import '../../models/portfolio_coins_model.dart';

/// [MyFunctions] A utility class containing helper functions for processing portfolio-related data.
/// It includes methods for summarizing and aggregating coin quantities and spending in the portfolio.
/// [summarizeCoin] Summarizes the portfolio data by aggregating the total quantity of coins and the total amount spent for each unique coin.
///
final class MyFunctions {
  // Calculates the total quantity of coins in the portfolio and the total amount spent
  List<PortfolioCoinsModel> summarizeCoin(List<PortfolioCoinsModel> data) {
    Map<String, PortfolioCoinsModel> summary = {};

    for (var item in data) {
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
    return summary.values.toList();
  }
}
