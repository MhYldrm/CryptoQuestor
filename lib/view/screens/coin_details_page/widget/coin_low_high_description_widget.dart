import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/styles/application_constants.dart';
import '../../../../core/components/styles/custom_colors.dart';

/// [low24H] The lowest price in the last 24 hours.
/// [high24H] The highest price in the last 24 hours.
/// [totalVolume] The total market cap of the coin.
/// [mPurple] 24H Details text background color
/// [mWhitePrimary] Total volume text White Color
/// [mGreyPrimary] (Low-High-Vol) text Grey Color
/// [red.shade300] Low price text Red Color
/// [green.shade300] High Price Text Green Color
///
class CoinLowHighDescriptionWidget extends StatelessWidget {
  const CoinLowHighDescriptionWidget({super.key, required this.low24H, required this.high24H, required this.totalVolume});

  final double low24H;
  final double high24H;
  final double totalVolume;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 7, left: 7),
          child: SizedBox(
              height: 60,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 45,
                      width: 50,
                      decoration: BoxDecoration(
                        color: CustomColors.mPurple,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.5),
                        child: Column(
                          children: [
                            Text(
                              context.mLocalizations.twentyHoursText,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: CustomColors.mWhitePrimary),
                            ),
                            Text(
                              context.mLocalizations.details,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                  color: CustomColors.mWhitePrimary,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        context.mLocalizations.low,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: CustomColors.mGreyPrimary,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "\$${low24H.toString()}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.red.shade300,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        context.mLocalizations.high,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: CustomColors.mGreyPrimary,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "\$${high24H.toString()}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.green.shade300,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        ApplicationConstants.vol,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: CustomColors.mGreyPrimary,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "\$${totalVolume.toString()} M",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: CustomColors.mWhitePrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
