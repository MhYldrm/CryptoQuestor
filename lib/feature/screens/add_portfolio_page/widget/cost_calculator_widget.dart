import 'package:crypto_questor/product/components/padding/project_paddings.dart';
import 'package:crypto_questor/product/components/project_decoration/project_box_decorations.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/application_constants.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../widgets/empty_widget.dart';

class CostCalculatorWidget extends StatefulWidget {
  const CostCalculatorWidget(
      {super.key,
      required this.coinSymbol,
      required this.totalSpent,
      required this.currentPriceTextField,
      required this.quantityTextField});

  final String coinSymbol;
  final String totalSpent;
  final Widget currentPriceTextField;
  final Widget quantityTextField;

  @override
  State<CostCalculatorWidget> createState() => _CostCalculatorWidgetState();
}

class _CostCalculatorWidgetState extends State<CostCalculatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.horizontalMedium(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.mLocalizations.pricePerCoin,
                style: context.textThemeBodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const EmptyWidget(height: 15),
              Container(
                height: context.deviceHeight * 0.1,
                width: context.deviceWidht / 1.5,
                decoration: context.isDarkMode
                    ? ProjectBoxDecorations
                        .addPortfolioPagesBoxDarkThemeDecoration
                    : ProjectBoxDecorations
                        .addPortfolioPagesLightThemeBoxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 50,
                        child: widget.currentPriceTextField,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: VerticalDivider(
                          thickness: 1.5,
                          color: CustomColors.mWhitePrimary.withOpacity(0.1),
                        ),
                      ),
                      Text(
                        ApplicationConstants.usd,
                        style: context.textThemeBodyLarge?.copyWith(
                          color: context.isDarkMode
                              ? CustomColors.mWhitePrimary
                              : CustomColors.bgcolor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const EmptyWidget(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.mLocalizations.quantityText,
                style: context.textThemeBodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const EmptyWidget(height: 15),
              Container(
                height: context.deviceHeight * 0.1,
                width: context.deviceWidht / 1.5,
                decoration: context.isDarkMode
                    ? ProjectBoxDecorations
                        .addPortfolioPagesBoxDarkThemeDecoration
                    : ProjectBoxDecorations
                        .addPortfolioPagesLightThemeBoxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 50,
                        child: widget.quantityTextField,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: VerticalDivider(
                          thickness: 1.5,
                          color: CustomColors.mWhitePrimary.withOpacity(0.1),
                        ),
                      ),
                      Text(
                        widget.coinSymbol.toString().toUpperCase(),
                        style: context.textThemeBodyLarge?.copyWith(
                          color: context.isDarkMode
                              ? CustomColors.mWhitePrimary
                              : CustomColors.bgcolor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const EmptyWidget(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.mLocalizations.totalSpent,
                style: context.textThemeBodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const EmptyWidget(height: 15),
              Container(
                height: context.deviceHeight * 0.1,
                width: context.deviceWidht / 1.1,
                decoration: context.isDarkMode
                    ? ProjectBoxDecorations
                        .addPortfolioPagesBoxDarkThemeDecoration
                    : ProjectBoxDecorations
                        .addPortfolioPagesLightThemeBoxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.totalSpent,
                        style: context.textThemeBodyLarge?.copyWith(
                          color: context.isDarkMode
                              ? CustomColors.mWhitePrimary
                              : CustomColors.bgcolor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      VerticalDivider(
                        thickness: 1.5,
                        color: CustomColors.mWhitePrimary.withOpacity(0.1),
                      ),
                      Text(
                        ApplicationConstants.usd,
                        style: context.textThemeBodyLarge?.copyWith(
                          color: context.isDarkMode
                              ? CustomColors.mWhitePrimary
                              : CustomColors.bgcolor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
