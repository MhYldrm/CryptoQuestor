import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/custom_colors.dart';
import 'delete_transaction_snackbar_widget.dart';

/// [coinData] It stores the information of the list to be used in the ListView Builder.
/// [DeleteTransactionCustomSnackBar] Showing a Custom Snack Bar for Delete transaction operation
/// [mYellow] Coin name-symbol text Yellow color
/// [mGreyPrimary] Description text Grey color
/// [mWhitePrimary] Quantity text White Color
///
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
                    ScaffoldMessenger.of(context).showSnackBar(
                        DeleteTransactionCustomSnackBar(
                            coinUid: coin.uid, context: context));
                  },
                  child: ListTile(
                    leading: Image.network(
                      coin.imageUrl,
                      height: 40,
                      width: 40,
                      fit: BoxFit.fill,
                    ),
                    title: Text(
                      "${coin.symbol}".toUpperCase(),
                      style: context.textThemeLabelLarge?.copyWith(
                        color: context.isDarkMode
                            ? CustomColors.mWhitePrimary
                            : CustomColors.bgcolor,
                      ),
                    ),
                    subtitle: Text(
                      coin.dateTime,
                      style: context.textThemeLabelSmall
                          ?.copyWith(color: CustomColors.mGreyPrimary),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 10.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${context.mLocalizations.quantity} ${double.parse(coin.quantity).toStringAsFixed(3)}",
                            style: context.textThemeLabelLarge?.copyWith(
                              color: context.isDarkMode
                                  ? CustomColors.mWhitePrimary
                                  : CustomColors.bgcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
