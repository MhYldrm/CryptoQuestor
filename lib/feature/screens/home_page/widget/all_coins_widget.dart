import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../../product/models/gecko_models.dart';
import '../../../widgets/coin_list_card.dart';

/// A widget that displays a list of all coins fetched from the CoinGecko API.
///
/// [isLoading] - A flag indicating whether the data is still loading or not.
/// [coinMarket] - A list containing the details of the coins fetched from the CoinGecko API.
///
/// This widget shows either a loading indicator, a list of coins, or an error message
/// if the API request fails.
class AllCoinsWidget extends StatelessWidget {
  const AllCoinsWidget({super.key,
    required this.isLoading,
    required this.coinMarket,
  });

  final bool? isLoading;
  final List<GeckoModel>? coinMarket;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: isLoading == null
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : isLoading == true
          ? ListView.builder(
          itemCount: coinMarket!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: CoinListCard(
                  item: coinMarket![index],
                ));
          })
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            context.mLocalizations.isApiRequestFailed,
            style: const TextStyle(
                color: CustomColors.mWhitePrimary
            ),),
        ),
      ),
    );
  }
}