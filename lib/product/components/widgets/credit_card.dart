import 'package:crypto_questor/product/extension/project_extensions.dart';
import 'package:flutter/material.dart';
import '../../../feature/view/portfolio_page/portfolio_page.dart';
import '../styles/project_constants.dart';
import '../styles/project_sizes.dart';
import '../styles/project_custom_colors.dart';
import '../styles/project_functions.dart';

/// [CreditCard] is a widget representing a credit card-like UI element that shows the user's portfolio balance and allows navigation to the portfolio page.
///
/// ### Key Responsibilities:
/// - Displays the total current value and total spent balance of the user's portfolio.
/// - Shows the profit/loss percentage with a visual indicator.
/// - Provides a button that navigates to the [PortfolioPage] when pressed.
/// - The appearance of the widget adapts based on the current theme (light/dark).
///
/// ### Parameters:
/// - [totalSpent] The total amount spent by the user in their portfolio.
/// - [totalCurrentValue] The current value of the user's portfolio.
///
/// ### Widgets:
/// - [CreditCardBackgroundDarkMode] and [CreditCardBackgroundLightMode] display different backgrounds for dark and light themes.
/// - [balanceText] displays the user's balance with profit/loss information.
/// - [profitPercent] shows the profit/loss percentage and navigates to the portfolio page.
///

final class CreditCard extends StatelessWidget {
  const CreditCard({
    required this.totalSpent,
    required this.totalCurrentValue,
    super.key,
  });
  final double totalSpent;
  final double totalCurrentValue;

  @override
  Widget build(BuildContext context) {
    // Calculates the percentage of profit or loss based on the total spent and current value.
    final double percentage = ProjectFunctions().calculatePercentage(totalCurrentValue, totalSpent);

    // Calculates the profit or loss in dollar terms.
    final double pnl = totalCurrentValue - totalSpent;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: ProjectSizes.size200.value,
        child: Stack(
          children: [
          context.isDarkMode
              ?  const CreditCardBackgroundDarkMode()
              : const CreditCardBackgroundLightMode(),

            // Displays the balance text.
            balanceText(totalCurrentValue.toStringAsFixed(2), context, percentage, pnl),

            // Displays the profit/loss percentage.
            profitPercent(context),
          ],
        ),
      ),
    );
  }

  /// Displays a button to navigate to the [PortfolioPage] and shows profit or loss percentage.
  Widget profitPercent(BuildContext context) {
    return Positioned(
      right: 24,
      bottom: 75,
      child: Container(
        padding: const EdgeInsets.fromLTRB(3, 2, 3, 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: context.isDarkMode
              ? const Color.fromARGB(255, 138, 124, 54)
              : Colors.white, // Light mode button color.
        ),
        child: IconButton(
          onPressed: () {
            context.push(const PortfolioPage()); // Navigates to the portfolio page.
          },
          icon: const Icon(
            Icons.chevron_right_rounded,
            size: 30,
          ),
        ),
      ),
    );
  }

  /// Displays the user's balance, profit/loss percentage, and profit or loss in dollars.
  Widget balanceText(String? balance, BuildContext context, double percentage, double pnl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Displays the label for account balance.
          Text(
            context.mLocalizations.accountBalance,
            style: context.textThemeHeadLineSmall?.copyWith(
              color: context.isDarkMode
                  ? ProjectCustomColors.mLilacPrimary
                  : ProjectCustomColors.mPurple,
              fontWeight:
                  context.isDarkMode ? FontWeight.w800 : FontWeight.w600,
            ),
          ),

          // Displays the balance in dollars.
          Text(
            '$balance \$',
            style: context.textThemeTitleLarge?.copyWith(
              color: context.isDarkMode
                  ? ProjectCustomColors.mGreyPrimary
                  : ProjectCustomColors.bgColor,
              fontWeight:
                  context.isDarkMode ? FontWeight.w400 : FontWeight.w900,
            ),
          ),

          // Shows the profit/loss percentage and the dollar amount.
          Text(
            '% ${percentage.toStringAsFixed(2)}  (\$${pnl.toStringAsFixed(2)})',
            overflow: TextOverflow.ellipsis,
            style: context.textThemeBodyMedium?.copyWith(
              color: percentage >= 0
                  ? Colors.green.shade800 // Positive percentage (green color).
                  : ProjectCustomColors
                      .mRedPrimary, // Negative percentage (red color).
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 80,
            width: 140,
            child: Image.asset(
              ProjectConstants.blockchainImagePath, // Displays a blockchain-related image.
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

/// [CreditCardBackgroundDarkMode] is a widget that provides a dark-themed background for the credit card widget.
class CreditCardBackgroundDarkMode extends StatelessWidget {
  const CreditCardBackgroundDarkMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.25, 0.75, 1],
            colors: ProjectCustomColors.earnCardGradientColors),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromARGB(255, 7, 6, 6),
                Color.fromARGB(255, 6, 51, 93),
              ],
            ),
          ),
          child: Stack(
            children: [
              circleTopRight(),
              circleBottomLeft(),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates a circular gradient at the top-right corner.
  Widget circleTopRight() {
    return Positioned(
      right: -120,
      top: -40,
      child: Container(
        width: 265,
        height: 265,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment(-1.8, -1.2),
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(35, 24, 6, 75),
              Color.fromARGB(153, 30, 71, 112),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates a circular gradient at the bottom-left corner.
  Widget circleBottomLeft() {
    return Positioned(
      left: -15,
      bottom: -150,
      child: Container(
        width: 280,
        height: 280,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(5.9, -0.2),
            colors: [
              Color.fromARGB(36, 169, 20, 20),
              Color.fromARGB(153, 48, 9, 166),
            ],
          ),
        ),
      ),
    );
  }
}

/// [CreditCardBackgroundLightMode] provides a light-themed background for the credit card widget.
class CreditCardBackgroundLightMode extends StatelessWidget {
  const CreditCardBackgroundLightMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.25, 0.75, 1],
            colors: ProjectCustomColors.earnCardGradientColors),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFFF5F5F5),
                Color(0xFFB3B6B5),
                Color(0xFFB3B6B5),
                Color(0xFFB3B6B5),
                Color(0xFFF5F5F5),
              ], // Light gradient colors.
            ),
          ),
          child: Stack(
            children: [
              circleTopRight(),
              circleBottomLeft(),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates a circular gradient at the top-right corner
  Widget circleTopRight() {
    return Positioned(
      right: -120,
      top: -40,
      child: Container(
        width: 265,
        height: 265,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment(-1.8, -1.2),
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB3B6B5),
              Color(0xFFB3B6B5),
              Color(0xFFF5F5F5),
              Color(0xFFB3B6B5),
              Color(0xFFF5F5F5),
              Color(0xFFF5F5F5),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates a circular gradient at the bottom-left corner
  Widget circleBottomLeft() {
    return Positioned(
      left: -15,
      bottom: -150,
      child: Container(
        width: 280,
        height: 280,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(5.9, -0.2),
            colors: [
              Color.fromARGB(36, 169, 20, 20),
              Color(0xFFB3B6B5),
              Color.fromARGB(153, 48, 9, 166),
              Color(0xFFB3B6B5),
            ],
          ),
        ),
      ),
    );
  }
}
