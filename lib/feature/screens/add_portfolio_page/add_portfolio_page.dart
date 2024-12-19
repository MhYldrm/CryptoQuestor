import 'package:crypto_questor/feature/screens/add_portfolio_page/mixin/add_portfolio_page_mixin.dart';
import 'package:crypto_questor/feature/screens/add_portfolio_page/widget/add_portfolio_page_header_widget.dart';
import 'package:crypto_questor/feature/screens/add_portfolio_page/widget/cost_calculate_text_fields_widget.dart';
import 'package:crypto_questor/feature/screens/add_portfolio_page/widget/cost_calculator_widget.dart';
import 'package:crypto_questor/product/components/button/my_custom_button.dart';
import 'package:crypto_questor/product/components/padding/project_paddings.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';

final class AddPortfolioPage extends StatefulWidget {
  final dynamic selectCoin;
  const AddPortfolioPage({super.key, this.selectCoin});

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
        backgroundColor: context.projectTheme!.primaryColor,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const ProjectPaddings.topMedium(),
                child: AddPortfolioPageHeaderWidget(
                  imageUrl: widget.selectCoin.image,
                  symbol: widget.selectCoin.symbol,
                  name: widget.selectCoin.name,
                  currentPrice: widget.selectCoin.currentPrice,
                  marketCapChangePercentage24H:
                      widget.selectCoin.marketCapChangePercentage24H,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: CostCalculatorWidget(
                coinSymbol: widget.selectCoin.symbol,
                totalSpent: totalSpent,
                currentPriceTextField: CostCalculateTextFieldsWidget(
                    controller: currentPriceController,
                    onChanged: handleCurrentPriceChange,
                ),
                quantityTextField:CostCalculateTextFieldsWidget(
                  controller: quantityController,
                  onChanged: handleQuantityChange,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyCustomButton(
                    onPressed: () async {
                      await saveCoinToPortfolio();
                    },
                    buttonText:
                    context.mLocalizations.addPortfolioButtonText,
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
