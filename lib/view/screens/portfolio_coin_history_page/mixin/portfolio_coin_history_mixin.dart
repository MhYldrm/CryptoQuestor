import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/view/screens/portfolio_coin_history_page/portfolio_coin_history_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/styles/custom_colors.dart';
import '../../../widgets/custom_app_bar.dart';

/// A mixin to manage the PortfolioCoinHistoryPage Page State.
/// [showCustomAppBar] Showing Custom AppBar
/// [mBlackPrimary] App Bar Custom İcon Black Color
///
mixin PortfolioCoinHistoryMixin on State<PortfolioCoinHistoryPage>{
  PreferredSize showCustomAppBar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: CustomAppBar(
            title: context.mLocalizations.transactions,
            icon: Icons.pending_actions_rounded,
            iconSize: 30,
            iconColor: CustomColors.mBlackPrimary));
  }
}