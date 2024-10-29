import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:flutter/material.dart';
import '../screens/coin_details_page.dart';

final class CoinListCard extends StatelessWidget {
  final dynamic item;
  const CoinListCard({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CoinDetailPage(
                      selectCoin: item,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 80,
          width: context.deviceWidht * 0.9,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            color: CustomColors.coinsCardColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      showImagePart(),
                      const SizedBox(
                        width: 10,
                      ),
                      showTitlePart(context),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: showPricePart(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Coin Logo Part
  Image showImagePart() {
    return Image.network(
      item.image,
      fit: BoxFit.fill,
      height: 35,
      width: 35,
    );
  }

  // Coin Title and Symbol Part
  Column showTitlePart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${item.symbol}".toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: CustomColors.mWhitePrimary),
        ),
        SizedBox(
          width: 120,
          child: Text(
            item.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: CustomColors.mGreyPrimary, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  // Coin Current Price Part
  Column showPricePart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "\$ ${item.currentPrice.toString()}",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: CustomColors.mWhitePrimary),
        ),
        Text(
          "${double.parse(item.marketCapChangePercentage24H.toString()).toStringAsFixed(2)}%",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: item.marketCapChangePercentage24H > 0
                  ? CustomColors.mGreenPrimary
                  : CustomColors.mRedPrimary.withOpacity(0.8)),
        ),
      ],
    );
  }




}
