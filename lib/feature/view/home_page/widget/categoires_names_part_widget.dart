/// A widget that displays the category names as buttons to switch between different categories of coins.
///
/// [pageController] - The [PageController] used to control the page view when a category is selected.
///
/// This widget allows users to switch between different categories like "Top 100", "Hot Coins", "Gainers", and "Losers".
/// [mLilacPrimary] "Top 100" text Lilac Color
/// [mYellow] "Hot" text Yellow Color
/// [mGreenPrimary] "Gainers" text Green Color
/// [mRedPrimary] "Losers" text Red Color
/// [_changePage] A method to change the page in the [PageController]. [index] - The index of the page to navigate to. This method is called when any of the category buttons are pressed.
///
part of '../home_page.dart';

class CategoriesNamesPartWidget extends StatelessWidget {
  const CategoriesNamesPartWidget({
    required this.pageController,
    super.key,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.horizontalMedium(),
      child: Row(
        children: [
          TextButton(
              onPressed: () => _changePage(ProjectConstants.zeroNumInt),
              child: Text(
                ProjectConstants.top100,
                style: context.textThemeLabelSmall?.copyWith(
                  color: context.isDarkMode
                      ? ProjectCustomColors.mLilacPrimary
                      : ProjectCustomColors.bgColor,
                ),
              )),
          TextButton(
            onPressed: () => _changePage(ProjectConstants.oneNumInt),
            child: Text(
              '${context.mLocalizations.hotCoins} 🔥',
              style: context.textThemeLabelSmall?.copyWith(
                color: context.isDarkMode
                    ? ProjectCustomColors.mYellow
                    : ProjectCustomColors.bgColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () => _changePage(ProjectConstants.twoNumInt),
            child: Text(
              context.mLocalizations.gainersCoin,
              style: context.textThemeLabelSmall
                  ?.copyWith(color: ProjectCustomColors.mGreenPrimary),
            ),
          ),
          TextButton(
            onPressed: () => _changePage(ProjectConstants.threeNumInt),
            child: Text(
              context.mLocalizations.losersCoin,
              style: context.textThemeLabelSmall?.copyWith(
                color: ProjectCustomColors.mRedPrimary.withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changePage(int index) {
    pageController.jumpToPage(index);
  }
}
