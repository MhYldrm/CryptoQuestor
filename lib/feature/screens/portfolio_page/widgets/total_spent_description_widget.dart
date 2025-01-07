import 'package:crypto_questor/product/components/styles/custom_colors.dart';
import 'package:crypto_questor/product/components/styles/my_functions.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/padding/project_paddings.dart';

/// A widget that displays the total value, total spent, and profit/loss (PnL) information.
///
/// This widget is used to show a summary of the user's portfolio performance, including the total current value,
/// the total amount spent on the portfolio, and the profit or loss percentage and value.
///
/// ### Parameters:
/// - [totalValue] The total value spent on the portfolio, represented in USD.
/// - [totalCurrentValue] The current value of the portfolio in USD.
///
/// ### Colors:
/// - [mWhitePrimary] White color used for displaying text when in dark mode.
/// - [mGreenPrimary] Green color used for displaying positive PnL (Profit).
/// - [mRedPrimary] Red color used for displaying negative PnL (Loss).
/// - [secondaryHeaderColor] The color used for the text in the widget based on the theme.
///
/// ### UI Details:
/// - Displays the total value, total spent, and PnL information.
/// - The PnL value is calculated as the difference between the total current value and total value.
/// - If the PnL is positive, it is displayed in green; if negative, it is displayed in red.
///

class TotalSpentDescriptionWidget extends StatelessWidget {
  const TotalSpentDescriptionWidget(
      {required this.totalValue, required this.totalCurrentValue, super.key});

  final double totalValue;
  final double totalCurrentValue;

  @override
  Widget build(BuildContext context) {
    // Calculate percentage change and profit or loss
    final double percentage = MyFunctions().calculatePercentage(totalCurrentValue, totalValue);
    final double pnl = totalCurrentValue - totalValue;

    return Padding(
      padding: const ProjectPaddings.horizontalMedium(),
      child: Column(
        children: [
          // Row for displaying the total current value
          Row(
            children: [
              Text(
                context.mLocalizations.totalValue,
                style: context.textThemeBodyLarge?.copyWith(
                  color: context.projectTheme!.secondaryHeaderColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Spacer(),
              Text(
                " \$ ${totalCurrentValue.toStringAsFixed(3)}",
                overflow: TextOverflow.ellipsis,
                style: context.textThemeBodyLarge?.copyWith(
                  color: context.projectTheme!.secondaryHeaderColor,
                ),
              ),
            ],
          ),

          // Row for displaying the total value spent
          Row(
            children: [
              Text(
                context.mLocalizations.totalSpent,
                style: context.textThemeBodyLarge?.copyWith(
                  color: context.projectTheme!.secondaryHeaderColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Spacer(),
              Text(
                " \$ ${totalValue.toStringAsFixed(3)}",
                overflow: TextOverflow.ellipsis,
                style: context.textThemeBodyLarge?.copyWith(
                  color: context.projectTheme!.secondaryHeaderColor,
                ),
              ),
            ],
          ),

          // Row for displaying the profit or loss percentage and value
          Row(
            children: [
              Text(
                context.mLocalizations.pnl,
                style: context.textThemeBodyMedium?.copyWith(
                  color: context.projectTheme!.secondaryHeaderColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Spacer(),
              Text(
                '% ${percentage.toStringAsFixed(2)}  (\$${pnl.toStringAsFixed(2)})',
                overflow: TextOverflow.ellipsis,
                style: context.textThemeBodyMedium?.copyWith(
                  color: percentage >= 0
                      ? CustomColors.mGreenPrimary
                      : CustomColors.mRedPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
