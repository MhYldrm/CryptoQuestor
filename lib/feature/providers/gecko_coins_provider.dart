import 'package:crypto_questor/product/repository/coin_gecko_repository.dart';
import 'package:crypto_questor/product/services/coin_services.dart';
import 'package:flutter/material.dart';
import '../../product/models/gecko_models.dart';

/// [GeckoCoinsProvider] is a state management class that extends [ChangeNotifier].
/// It manages and provides cryptocurrency data fetched from the CoinGecko API.
class GeckoCoinsProvider extends ChangeNotifier {
  final CoinGeckoRepository repository;
  GeckoCoinsProvider(this.repository);

  final CoinService _service = CoinService();

  // Stores the list of cryptocurrencies fetched from the API.
  List<GeckoModel>? _geckoCoinProviderList;
  bool _isLoading = false;

  /// Provides the list of cryptocurrencies to external consumers.
  List<GeckoModel>? get coins => _geckoCoinProviderList;

  /// Provides the loading state to external consumers.
  bool get isLoading => _isLoading;

  /// Fetches cryptocurrency data from the CoinGecko API and updates the state.
  Future<void> getGeckoApiCoins() async {
    _isLoading = true; // Mark as loading.
    notifyListeners();

    // Fetch data from the API and assign it to _geckoCoinProviderList
    _geckoCoinProviderList = await _service.getCoinsFromCoinGeckoApi();
    _isLoading = false; // Mark as not loading.
    notifyListeners();
  }
}
