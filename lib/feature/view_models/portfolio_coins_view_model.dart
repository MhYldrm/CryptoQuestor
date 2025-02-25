import 'package:crypto_questor/product/models/portfolio_coins_model.dart';
import 'package:crypto_questor/product/repository/portfolio_coins_repository.dart';
import 'package:crypto_questor/product/services/firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';

/// [PortfolioCoinsViewModel] is a state management class that extends [ChangeNotifier].
/// It manages and provides portfolio coin data fetched from a Firebase service.
class PortfolioCoinsViewModel extends ChangeNotifier {
  PortfolioCoinsViewModel(this.repository);
  final PortfolioCoinsRepository repository;

  // FirebaseService handles the data fetching logic for portfolio coins.
  final FirebaseService _service = FirebaseService();

  // Stores the list of portfolio coins fetched from Firebase.
  List<PortfolioCoinsModel>? _portfolioCoins;

  // Tracks the loading state. [true] if data is being fetched.
  bool _isLoading = false;

  /// Provides the list of portfolio coins to external consumers.
  /// Returns an empty list if no data is available.
  List<PortfolioCoinsModel> get portfolioCoins => _portfolioCoins ?? <PortfolioCoinsModel>[];
  bool get isLoading => _isLoading;

  /// Fetches portfolio coin data from Firebase and updates the state.
  Future<void> getPortfolioCoins() async {
    _isLoading = true; // Mark as loading.
    notifyListeners();

    // Fetch data from Firebase and assign it to _portfolioCoins.
    _portfolioCoins = await _service.getPortfolioCoins();

    _isLoading = false; // Mark as not loading.
    notifyListeners();
  }
}