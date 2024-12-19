import 'package:crypto_questor/feature/screens/portfolio_coin_history_page/portfolio_coin_history_page.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/models/portfolio_coins_model.dart';
import '../../../widgets/coin_card.dart';

/// A widget that displays the user's portfolio of coins.
///
/// This widget shows a horizontal list of coins in the portfolio, including their details such as name,
/// symbol, price, and balance. If there are no coins in the portfolio, a message is displayed.
///
/// [portfolioCoins] - A list of the coins in the portfolio containing their data.
/// [resultList] - A list of processed portfolio coin models that include additional information like totalSpent, name, etc.
/// [isLoading] - A boolean flag that indicates whether the data is being loaded.
///
final class PortfolioCoinsPartWidget extends StatelessWidget {
  const PortfolioCoinsPartWidget(
      {super.key,
      required this.portfolioCoins,
      required this.resultList,
      required this.isLoading});

  final List<dynamic> portfolioCoins;
  final List<PortfolioCoinsModel> resultList;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            context.mLocalizations.myPortfolio,
            style: context.textThemeBodyLarge?.copyWith(
              color: context.projectTheme!.secondaryHeaderColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 170,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : resultList.isNotEmpty
                  ?
                  // If there are coins in the portfolio
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: resultList.length,
                      itemBuilder: (context, index) {
                        final portfolio = resultList[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 12, 0),
                          child: InkWell(
                            onTap: () {
                              context.push(PortfolioCoinHistoryPage(coinData: portfolioCoins),);
                            },
                            child: CoinCard(
                              symbol: portfolio.symbol,
                              price: double.parse(portfolio.totalSpent)
                                  .toStringAsFixed(2),
                              name: portfolio.name,
                              url: portfolio.imageUrl,
                              balance: portfolio.quantity,
                            ),
                          ),
                        );
                      })
                  :
                  // If there are no coins in the portfolio show text : You have not any coin in portfolio
                  Center(
                      child: FittedBox(
                        child: Text(
                          context.mLocalizations.isNotHaveAnyCoins,
                          style: context.textThemeTitleMedium!.copyWith(
                            color: context.projectTheme!.secondaryHeaderColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
        ),
      ],
    );
  }
}
