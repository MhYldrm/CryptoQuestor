library add_portfolio_page;

import 'package:crypto_questor/product/components/styles/application_size.dart';
import 'package:flutter/material.dart';
import 'package:crypto_questor/product/exports/exports.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

part 'widget/add_portfolio_page_header_widget.dart';
part 'widget/cost_calculate_text_fields_widget.dart';
part 'widget/cost_calculator_widget.dart';
part 'mixin/add_portfolio_page_mixin.dart';

/// [AddPortfolioPage] is a stateful widget that allows users to add a cryptocurrency
/// to their portfolio by entering relevant data such as price and quantity.
///
final class AddPortfolioPage extends StatefulWidget {
  const AddPortfolioPage({super.key, this.selectCoin});

  // The selected cryptocurrency object passed to this page.
  final dynamic selectCoin;

  @override
  State<AddPortfolioPage> createState() => _AddPortfolioPageState();
}

class _AddPortfolioPageState extends State<AddPortfolioPage>
    with AddPortfolioPageMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: context.projectTheme?.primaryColor,
        body: Column(
          children: [
            // Top section: Displays the header widget with selected coin information.
            Expanded(
              flex: 1,
              child: Padding(
                padding: const ProjectPaddings.topMedium(),
                child: AddPortfolioPageHeaderWidget(
                  // Passes the selected coin details to the header widget.
                  imageUrl: widget.selectCoin.image,
                  symbol: widget.selectCoin.symbol,
                  name: widget.selectCoin.name,
                  currentPrice: widget.selectCoin.currentPrice,
                  marketCapChangePercentage24H:
                      widget.selectCoin.marketCapChangePercentage24H,
                ),
              ),
            ),
            // Middle section: Contains the cost calculator widget.
            Expanded(
              flex: 5,
              child: CostCalculatorWidget(
                coinSymbol: widget.selectCoin.symbol,
                totalSpent: totalSpent,
                currentPriceTextField: CostCalculateTextFieldsWidget(
                  controller: currentPriceController,
                  onChanged: handleCurrentPriceChange,
                ),
                quantityTextField: CostCalculateTextFieldsWidget(
                  controller: quantityController,
                  onChanged: handleQuantityChange,
                ),
              ),
            ),
            // Bottom section: Includes a custom button to save the entered data.
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyCustomButton(
                    // Saves the coin data to the portfolio when pressed.
                    onPressed: () async {
                      await saveCoinToPortfolio();
                    },
                    buttonText: context.mLocalizations.addPortfolioButtonText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
