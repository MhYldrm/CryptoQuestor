import 'package:crypto_questor/product/repository/coin_gecko_repository.dart';
import 'package:crypto_questor/product/services/coin_service/coin_service.dart';
import 'package:flutter/material.dart';
import '../../product/models/gecko_model.dart';

/// [GeckoCoinsViewModel] is a state management class that extends [ChangeNotifier].
/// It manages and provides cryptocurrency data fetched from the CoinGecko API.
class GeckoCoinsViewModel extends ChangeNotifier {
  GeckoCoinsViewModel(this.repository);
  final CoinGeckoRepository repository;

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
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch data from the API and assign it to _geckoCoinProviderList
      final response = await _service.getCoinsFromCoinGeckoApi();
      if (response != null) {
        _geckoCoinProviderList = response;
      }
    } catch (e) {
      _geckoCoinProviderList = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
