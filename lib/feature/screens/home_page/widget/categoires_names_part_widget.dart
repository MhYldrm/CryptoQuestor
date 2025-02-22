import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/application_constants.dart';
import '../../../../product/components/styles/custom_colors.dart';


/// A widget that displays the category names as buttons to switch between different categories of coins.
///
/// [pageController] - The [PageController] used to control the page view when a category is selected.
///
/// This widget allows users to switch between different categories like "Top 100", "Hot Coins", "Gainers", and "Losers".
/// [mLilacPrimary] "Top 100" text Lilac Color
/// [mYellow] "Hot" text Yellow Color
/// [mGreenPrimary] "Gainers" text Green Color
/// [mRedPrimary] "Losers" text Red Color
/// [changePage] A method to change the page in the [PageController]. [index] - The index of the page to navigate to. This method is called when any of the category buttons are pressed.
///
class CategoriesNamesPartWidget extends StatelessWidget {
  const CategoriesNamesPartWidget({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          TextButton(
              onPressed: () => changePage(0),
              child: Text(
                ApplicationConstants.top100,
                style: context.textThemeLabelSmall
                    ?.copyWith(
                    color: context.isDarkMode
                  ? CustomColors.mLilacPrimary
                  : CustomColors.bgcolor,
                ),
              )),
          TextButton(
              onPressed: () => changePage(1),
              child: Text(
                "${context.mLocalizations.hotCoins} 🔥",
                style: context.textThemeLabelSmall
                    ?.copyWith(
                  color: context.isDarkMode
                      ? CustomColors.mYellow
                      : CustomColors.bgcolor,
                ),
              )),
          TextButton(
              onPressed: () => changePage(2),
              child: Text(
                context.mLocalizations.gainersCoin,
                style: context.textThemeLabelSmall
                    ?.copyWith(color: CustomColors.mGreenPrimary),
              )),
          TextButton(
            onPressed: () => changePage(3),
            child: Text(
              context.mLocalizations.losersCoin,
              style: context.textThemeLabelSmall
                  ?.copyWith(color: CustomColors.mRedPrimary.withOpacity(0.9)),
            ),
          ),
        ],
      ),
    );
  }

  void changePage(int index) {
    pageController.jumpToPage(index);
  }
}
