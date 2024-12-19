import 'package:crypto_questor/feature/screens/portfolio_page/portfolio_page.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../product/components/styles/application_constants.dart';
import '../../product/components/styles/custom_colors.dart';

/// A widget representing a credit card-like UI element
/// Shows the total spent balance, and includes a navigation button to the portfolio page.
/// [balance] Quantity of coins in the user's portfolio
///
class CreditCard extends StatelessWidget {
  const CreditCard({super.key, this.balance});
  final String? balance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            context.isDarkMode
                ? const CreditCardBackgroundDarkMode()
                : const CreditCardBackgroundLightMode(),
            balanceText(balance, context),
            profitPercent(context),
          ],
        ),
      ),
    );
  }

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
                : Colors.white,
          ),
          child: IconButton(
              onPressed: () {
                context.push(const PortfolioPage());
              },
              icon: const Icon(
                Icons.chevron_right_rounded,
                size: 30,
              ))),
    );
  }

  Widget balanceText(String? balance, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.mLocalizations.totalSpent,
            style: context.textThemeHeadLineSmall?.copyWith(
              color: context.isDarkMode
                  ? CustomColors.mLilacPrimary
                  : CustomColors.mPurple,
              fontWeight:
                  context.isDarkMode ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
          Text(
            "$balance \$",
            style: context.textThemeTitleLarge?.copyWith(
              color: context.isDarkMode
                  ? CustomColors.mGreyPrimary
                  : CustomColors.mWhitePrimary,
              fontWeight:
              context.isDarkMode ? FontWeight.w400 : FontWeight.w900,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 80,
            width: 140,
            child: Image.asset(
              ApplicationConstants.blockchainImagePath,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

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
            colors: CustomColors.earnCardGradientColors),
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
            colors: CustomColors.earnCardGradientColors),
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
