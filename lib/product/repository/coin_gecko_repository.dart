import '../models/gecko_models.dart';

abstract class CoinGeckoRepository{
  Future<List<GeckoModel>?> getCoinsFromGeckoApi();
}