import '../models/gecko_model.dart';

abstract class CoinGeckoRepository{
  Future<List<GeckoModel>?> getCoinsFromGeckoApi();
}