import 'package:crypto_questor/product/models/portfolio_coins_model.dart';
import 'package:crypto_questor/product/repository/portfolio_coins_repository.dart';
import 'package:crypto_questor/product/services/firebase_service.dart';

class PortfolioCoinsRepositoryImpl implements PortfolioCoinsRepository{
  final FirebaseService _service;
  PortfolioCoinsRepositoryImpl(this._service);

  @override
  Future<List<PortfolioCoinsModel>> getPortfolioCoins() async{
    return await _service.getPortfolioCoins();
  }


}