import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/view/screens/portfolio_page/portfolio_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/models/portfolio_coins_model.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../widgets/custom_app_bar.dart';

/// A mixin to manage the Portfolio Page State.
///  [allCoinsInPortfolio] List to store the coins present in the user's portfolio.
/// [isLoading] Indicates whether the portfolio coins are currently being loaded.
/// [fetchPortfolioCoinsFromFirebase]  Gets details of coins in the portfolio from Firebase
/// [buildCustomAppBar] Displays a custom app bar with a title and an icon.
///
mixin PortfolioPageMixin on State<PortfolioPage> {
  List<PortfolioCoinsModel> allCoinsInPortfolio = [];
  bool isLoading = true;

  Future<void> fetchPortfolioCoinsFromFirebase() async {
    allCoinsInPortfolio = await FirebaseService().getPortfolioCoins();
    setState(() {
      isLoading = false;
    });
  }

  PreferredSize buildCustomAppBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: CustomAppBar(
            title: context.mLocalizations.myPortfolio,
            icon: Icons.account_balance_wallet_outlined,
            iconSize: 33,
            iconColor: Colors.black));
  }
}
