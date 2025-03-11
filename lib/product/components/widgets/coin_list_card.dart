import 'package:crypto_questor/product/components/padding/project_paddings.dart';
import 'package:crypto_questor/product/components/styles/project_sizes.dart';
import 'package:crypto_questor/product/extension/project_extensions.dart';
import 'package:flutter/material.dart';
import '../../../feature/view/coin_details_page/coin_details_page.dart';
import '../styles/project_custom_colors.dart';

/// A card widget that represents a coin in the coin list
///
/// [item] The data object representing a cryptocurrency. It includes details such as the coin's symbol, name, price, and image.
///
final class CoinListCard extends StatelessWidget {
  const CoinListCard({super.key, this.item});
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(CoinDetailPage(selectCoin: item,),);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: ProjectSizes.size80.value,
          width: context.deviceWidht * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: context.isDarkMode
                ? ProjectCustomColors.coinsCardColor.withOpacity(0.5)
                : const Color(0xFFF5F5F5),
          ),
          child: Padding(
            padding: const ProjectPaddings.horizontalXMedium(),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      showCoinLogoPart(),
                      SizedBox(width: ProjectSizes.size10.value,),
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
  Image showCoinLogoPart() {
    return Image.network(
      item.image,
      fit: BoxFit.fill,
      height: ProjectSizes.size35.value,
      width: ProjectSizes.size35.value,
    );
  }

  // Coin Title and Symbol Part
  Column showTitlePart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${item.symbol}'.toUpperCase(),
          style: context.textThemeTitleMedium?.copyWith(
            color: context.isDarkMode
                ? ProjectCustomColors.mWhitePrimary
                : ProjectCustomColors.bgColor,
          ),
        ),
        SizedBox(
          width: ProjectSizes.size120.value,
          child: Text(
            item.name,
            overflow: TextOverflow.ellipsis,
            style: context.textThemeLabelSmall?.copyWith(
                color: ProjectCustomColors.mGreyPrimary,
                fontWeight: FontWeight.w500),
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
          '\$ ${item.currentPrice.toString()}',
          style: context.textThemeTitleMedium?.copyWith(
            color: context.isDarkMode
                ? ProjectCustomColors.mWhitePrimary
                : ProjectCustomColors.bgColor,
          ),
        ),
        Text(
          '${double.parse(item.marketCapChangePercentage24H.toString()).toStringAsFixed(2)}%',
          style: context.textThemeLabelMedium?.copyWith(
            color: item.marketCapChangePercentage24H > 0
                ? ProjectCustomColors.mGreenPrimary.withOpacity(0.9)
                : ProjectCustomColors.mRedPrimary.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
