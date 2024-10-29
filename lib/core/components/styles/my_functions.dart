import '../../models/portfolio_coins_model.dart';

final class MyFunctions{

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
          totalSpent: (double.parse(existing.totalSpent) + totalSpent).toString(),
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