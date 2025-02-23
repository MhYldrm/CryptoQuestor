library portfolio_coin_history_page;

import 'package:crypto_questor/product/exports/exports.dart';
import '../../../product/components/widgets/custom_app_bar.dart';
import '../intro_page/intro_page.dart';

/// [PortfolioCoinHistoryPage] is a page that displays the transaction history of a portfolio coin.
///
/// This page is used to show the details of past transactions for a particular coin in the user's portfolio.
///
/// ### Parameters:
/// - [coinData] A list of transaction data that contains information about each coin transaction.
///
/// The page has an app bar with custom styling and displays a list of all the transactions using the `AllTransactionsWidget` widget.
part 'widget/all_transactions_widget.dart';
part 'widget/delete_transaction_snackbar_widget.dart';
part 'mixin/portfolio_coin_history_mixin.dart';

final class PortfolioCoinHistoryPage extends StatefulWidget {
  final List<dynamic> coinData; // A list of transactions for a coin

  const PortfolioCoinHistoryPage({super.key, required this.coinData});

  @override
  State<PortfolioCoinHistoryPage> createState() =>
      _PortfolioCoinHistoryPageState();
}

class _PortfolioCoinHistoryPageState extends State<PortfolioCoinHistoryPage>
    with PortfolioCoinHistoryMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.projectTheme!.primaryColor,
      appBar: showCustomAppBar(),
      body: AllTransactionsWidget(
          coinData:
              widget.coinData), // Display all transactions using the widget
    ));
  }
}
