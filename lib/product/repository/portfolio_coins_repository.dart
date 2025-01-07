import '../models/portfolio_coins_model.dart';

abstract class PortfolioCoinsRepository{
  Future<List<PortfolioCoinsModel>> getPortfolioCoins();
}