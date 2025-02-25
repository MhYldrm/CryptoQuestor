/// A mixin to manage the PortfolioCoinHistoryPage Page State.
/// [showCustomAppBar] Showing Custom AppBar
/// [mBlackPrimary] App Bar Custom İcon Black Color
///
part of '../portfolio_coin_history_page.dart';

mixin PortfolioCoinHistoryMixin on State<PortfolioCoinHistoryPage> {
  PreferredSize showCustomAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: CustomAppBar(
        title: context.mLocalizations.transactions,
        icon: Icons.pending_actions_rounded,
        iconSize: 30,
        iconColor: ProjectCustomColors.mBlackPrimary,
      ),
    );
  }
}
