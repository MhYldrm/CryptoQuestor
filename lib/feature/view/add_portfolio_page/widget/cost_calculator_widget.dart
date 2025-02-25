/// [CostCalculatorWidget] is a stateful widget designed to allow users
/// to input the current price and quantity of a cryptocurrency, and display
/// the calculated total spent in a visually styled manner.
///
/// - [coinSymbol] The symbol of the cryptocurrency (e.g., BTC, ETH).
/// - [totalSpent] The total amount spent, formatted as a string.
/// - [currentPriceTextField] A widget for entering the current price per coin.
/// - [widgetOfTextField] A widget for entering the quantity of the cryptocurrency.
///
part of '../add_portfolio_page.dart';

class CostCalculatorWidget extends StatefulWidget {
  const CostCalculatorWidget({
    required this.coinSymbol,
    required this.totalSpent,
    required this.currentPriceTextField,
    required this.quantityTextField,
    super.key,
  });

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
          // Section: Input for current price per coin.
          CostCalculatorSchemaWidget(
            title: context.mLocalizations.pricePerCoin,
            currency: ProjectConstants.usd,
            widgetOfTextField: widget.currentPriceTextField,
          ),
          EmptyWidget(
            height: ProjectSizes.medium.value,
          ),

          // Section: Input for the quantity of coins.
          CostCalculatorSchemaWidget(
            title: context.mLocalizations.quantityText,
            currency: widget.coinSymbol.toUpperCase(),
            widgetOfTextField: widget.quantityTextField,
          ),
          EmptyWidget(
            height: ProjectSizes.medium.value,
          ),

          // Section: Display of the total amount spent.
          CostCalculatorTotalSpentSchemaWidget(
            title: context.mLocalizations.totalSpent,
            currency: ProjectConstants.usd,
            showTotalSpent: widget.totalSpent,
          ),
        ],
      ),
    );
  }
}
