import 'package:crypto_questor/product/models/portfolio_coins_model.dart';
import 'package:crypto_questor/product/repository/portfolio_coins_repository.dart';
import 'package:crypto_questor/product/services/firebase_service/firebase_service.dart';

class PortfolioCoinsRepositoryImpl implements PortfolioCoinsRepository{
  PortfolioCoinsRepositoryImpl(this._service);
  final FirebaseService _service;

  @override
  Future<List<PortfolioCoinsModel>> getPortfolioCoins() async{
    return await _service.getPortfolioCoins();
  }


}