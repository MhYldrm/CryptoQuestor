import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:flutter/material.dart';
import '../../core/services/firebase_service.dart';
import '../widgets/customappbar.dart';
import 'intro_page.dart';

class PortfolioCoinHistoryPage extends StatefulWidget {
  final List<dynamic> coinData;
  const PortfolioCoinHistoryPage({super.key, required this.coinData});

  @override
  State<PortfolioCoinHistoryPage> createState() =>
      _PortfolioCoinHistoryPageState();
}

class _PortfolioCoinHistoryPageState extends State<PortfolioCoinHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        backgroundColor: CustomColors.bgcolor,
        appBar: showCustomAppBar(),
        body: buildCoinsHistoryDetails(),
    ));
  }

  ListView buildCoinsHistoryDetails() {
    return ListView.builder(
        itemCount: widget.coinData.length,
        itemBuilder: (context, index) {
          final coin = widget.coinData[index];
          return SizedBox(
            height: 90,
            width: double.infinity,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    // for delete coin transaction snack bar details
                    var snackBar = SnackBar(
                        backgroundColor: CustomColors.mYellow,
                        content: Row(
                          children: [
                            Text(
                              context.mLocalizations.isDeletingTransaction,
                              style:
                                  const TextStyle(color: CustomColors.bgcolor),
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  FirebaseService()
                                      .deleteCoinTransaction(coin.uid);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const IntroPage()));
                                },
                                child: Text(
                                  context.mLocalizations.accept,
                                  style: const TextStyle(
                                      color: CustomColors.mRedPrimary),
                                )),
                          ],
                        ));

                    // for delete coin transaction
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: CustomColors.mYellow),
                    ),
                    subtitle: Text(
                      coin.dateTime,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: CustomColors.mGreyPrimary),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 10.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${context.mLocalizations.quantity} ${double.parse(coin.quantity).toStringAsFixed(3)}",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: CustomColors.mWhitePrimary),
                          ),
                          Text(
                            "${context.mLocalizations.totalSpentForHistory} ${double.parse(coin.totalSpent).toStringAsFixed(2)}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
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

  PreferredSize showCustomAppBar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: CustomAppBar(
            title: context.mLocalizations.transactions,
            icon: Icons.pending_actions_rounded,
            iconSize: 30,
            iconColor: CustomColors.mBlackPrimary));
  }
}
