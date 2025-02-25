library add_portfolio_page;

import 'package:crypto_questor/feature/view/add_portfolio_page/widget/cost_calculator_schema/cost_calculator_schema_widget.dart';
import 'package:crypto_questor/feature/view/add_portfolio_page/widget/cost_calculator_schema/cost_calculator_total_spent_schema_widget.dart';
import 'package:crypto_questor/product/components/styles/project_sizes.dart';
import 'package:crypto_questor/product/components/styles/project_exports.dart';
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
                totalSpent: _totalSpent,
                currentPriceTextField: CostCalculateTextFieldsWidget(
                  controller: _currentPriceController,
                  onChanged: handleCurrentPriceChange,
                ),
                quantityTextField: CostCalculateTextFieldsWidget(
                  controller: _quantityController,
                  onChanged: handleQuantityChange,
                ),
              ),
            ),
            // Bottom section: Includes a custom button to save the entered data.
            Expanded(
              child: Column(
                children: [
                  ProjectCustomButton(
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
