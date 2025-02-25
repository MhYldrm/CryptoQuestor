import 'package:crypto_questor/product/components/styles/project_exports.dart';
import '../../../../../product/components/styles/project_sizes.dart';

/// A schema widget used in the Cost Calculator widget.
///
/// This widget provides a structured layout for displaying and inputting financial values.
/// It includes a title, a text field for user input, and a currency display.
/// Used within the Cost Calculator widget, which converts the user's entered amount into USD
/// or a selected cryptocurrency equivalent.
///
/// ### Responsibilities:
/// - Displays a title to indicate the purpose of the input.
/// - Provides an input field for the user to enter financial values.
/// - Shows the selected currency alongside the input field.
/// - Adapts styling based on the current theme (light/dark mode).
///
/// ### UI Details:
/// - Uses a [Container] styled differently for dark and light themes.
/// - The input field is placed inside a fixed-size [SizedBox].
/// - A [VerticalDivider] visually separates the input field and currency.
/// - The currency text adapts to the current theme for better visibility.
///
final class CostCalculatorSchemaWidget extends StatelessWidget {
  const CostCalculatorSchemaWidget({
    required this.title,
    required this.currency,
    required this.widgetOfTextField,
    super.key,
  });

  /// The title describing the purpose of the input (e.g., "Total Spent").
  final String title;

  /// The currency in which the value is represented (e.g., USD, BTC).
  final String currency;

  /// A widget representing the text field for user input.
  final Widget widgetOfTextField;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Displays the section title
        Text(
          title,
          style:
              context.textThemeBodyLarge?.copyWith(fontWeight: FontWeight.bold),
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
              children: [
                // Input field for user to enter a financial value
                SizedBox(
                  width: ProjectSizes.xxxLarge.value,
                  height: ProjectSizes.xxsLarge.value,
                  child: widgetOfTextField,
                ),
                SizedBox(width: ProjectSizes.small.value),
                Padding(
                  padding: const ProjectPaddings.verticalSmall(),
                  child: VerticalDivider(
                    thickness: 1.5,
                    color: ProjectCustomColors.mWhitePrimary.withOpacity(0.1),
                  ),
                ),

                // Displays the selected currency
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
