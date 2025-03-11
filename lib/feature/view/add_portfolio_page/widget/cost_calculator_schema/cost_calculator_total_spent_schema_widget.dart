import 'package:crypto_questor/product/components/styles/project_exports.dart';
import '../../../../../product/components/styles/project_sizes.dart';

/// A schema widget used in the Cost Calculator widget.
///
/// This widget is responsible for displaying the total amount spent
/// along with the corresponding currency. It is used within the Cost Calculator
/// widget, which automatically converts the user's entered amount into USD
/// or a selected cryptocurrency equivalent.
///
/// ### Responsibilities:
/// - Displays the total amount spent in a structured container.
/// - Shows the selected currency next to the total spent value.
/// - Adapts styling based on the current theme (light/dark mode).
///
/// ### UI Details:
/// - Uses a [Container] with different styles for dark and light modes.
/// - The total spent amount is highlighted in green (for dark mode) or red (for light mode).
/// - A [VerticalDivider] visually separates the total spent and currency values.
/// - The currency text color adapts based on the current theme for better readability.
///
final class CostCalculatorTotalSpentSchemaWidget extends StatelessWidget {
  const CostCalculatorTotalSpentSchemaWidget({
    required this.title,
    required this.currency,
    required this.showTotalSpent,
    super.key,
  });

  /// The title  (e.g., "Total Spent").
  final String title;

  /// The currency in which the total amount is represented (e.g., USD, BTC).
  final String currency;

  /// The total amount spent, displayed as a formatted string.
  final String showTotalSpent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textThemeBodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        EmptyWidget(height: ProjectSizes.xSmall.value),
        Container(
          height: context.deviceHeight * 0.1,
          width: context.deviceWidht / 1.1,
          decoration: context.isDarkMode
              ? ProjectBoxDecorations.addPortfolioPagesBoxDarkThemeDecoration
              : ProjectBoxDecorations.addPortfolioPagesLightThemeBoxDecoration,
          child: Padding(
            padding: const ProjectPaddings.allSmall(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Displays the total spent amount
                Text(
                  showTotalSpent,
                  style: context.textThemeBodyLarge?.copyWith(
                    color: context.isDarkMode
                        ? ProjectCustomColors.mGreenPrimary
                        : ProjectCustomColors.mRedPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                VerticalDivider(
                  thickness: 1.5,
                  color: ProjectCustomColors.mWhitePrimary.withOpacity(0.1),
                ),
                Text(
                  currency,
                  style: context.textThemeBodyLarge?.copyWith(
                    color: context.isDarkMode
                        ? ProjectCustomColors.mWhitePrimary
                        : ProjectCustomColors.bgColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
