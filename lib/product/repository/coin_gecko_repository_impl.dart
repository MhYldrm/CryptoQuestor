import 'package:crypto_questor/product/models/gecko_model.dart';
import 'package:crypto_questor/product/repository/coin_gecko_repository.dart';
import 'package:crypto_questor/product/services/coin_services.dart';

class CoinGeckoRepositoryImpl implements CoinGeckoRepository{
  final CoinService _service ;
  CoinGeckoRepositoryImpl(this._service);

  @override
  Future<List<GeckoModel>?> getCoinsFromGeckoApi() async{
    return await _service.getCoinsFromCoinGeckoApi();
  }
}