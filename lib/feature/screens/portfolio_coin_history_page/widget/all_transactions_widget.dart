/// [AllTransactionsWidget] displays a list of transactions, with the option to delete each transaction.
///
/// It shows each transaction's coin information, including the symbol, date, quantity, and total spent.
/// When a transaction is tapped, a custom SnackBar is displayed to confirm the deletion of that transaction.
///
/// ### Parameters:
/// - [coinData] A list containing the transaction data for each coin to be displayed.
///
/// ### Colors:
/// - [mYellow] Used for the coin name-symbol text color in yellow.
/// - [mGreyPrimary] Used for the description text in grey.
/// - [mWhitePrimary] Used for the quantity text in white.
///
part of '../portfolio_coin_history_page.dart';

class AllTransactionsWidget extends StatelessWidget {
  const AllTransactionsWidget({required this.coinData, super.key});

  final List<dynamic> coinData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: coinData.length,
        itemBuilder: (context, index) {
          final coin = coinData[index];
          return SizedBox(
            height: context.deviceHeight * 0.15,
            width: double.infinity,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    // Show custom SnackBar when a coin transaction is tapped
                    ScaffoldMessenger.of(context).showSnackBar(
                        DeleteTransactionCustomSnackBar(
                            coinUid: coin.uid, context: context));
                  },
                  child: ListTile(
                    leading: Image.network(
                      coin.imageUrl, // Display coin image
                      height: 40, // Fixed image size
                      width: 40,
                      fit: BoxFit.fill,
                    ),
                    title: Text(
                      "${coin.symbol}"
                          .toUpperCase(), // Coin symbol in uppercase
                      style: context.textThemeLabelLarge?.copyWith(
                        color: context.isDarkMode
                            ? CustomColors.mWhitePrimary
                            : CustomColors.bgcolor,
                      ),
                    ),
                    subtitle: Text(
                      coin.dateTime, // Show the date and time of the transaction
                      style: context.textThemeLabelSmall
                          ?.copyWith(color: CustomColors.mGreyPrimary),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 10.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display the transaction quantity
                          Text(
                            "${context.mLocalizations.quantity} ${double.parse(coin.quantity).toStringAsFixed(3)}",
                            style: context.textThemeLabelLarge?.copyWith(
                              color: context.isDarkMode
                                  ? CustomColors.mWhitePrimary
                                  : CustomColors.bgcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Display the total spent for the transaction
                          Text(
                            "${context.mLocalizations.totalSpentForHistory} ${double.parse(coin.totalSpent).toStringAsFixed(2)}",
                            style: context.textThemeBodyMedium
                                ?.copyWith(color: CustomColors.mGreyPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                  color: CustomColors.mGreyPrimary,
                ),
              ],
            ),
          );
        });
  }
}
