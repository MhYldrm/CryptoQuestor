import 'package:crypto_questor/view/screens/portfolio_coin_history_page.dart';
import 'package:crypto_questor/view/widgets/coin_list_card.dart';
import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/view/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import '../../core/models/gecko_models.dart';
import '../../core/models/portfolio_coins_model.dart';
import '../../core/services/coin_services.dart';
import '../../core/components/styles/my_functions.dart';
import '../../core/components/styles/custom_texts.dart';
import '../../core/services/firebase_service.dart';
import '../../view/widgets/coin_card.dart';
import '../../view/widgets/credit_card.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Gets details of coins in the portfolio from Firebase
  List<PortfolioCoinsModel> _allCoinsInPortfolio = [];
  bool _isLoading = true;
  Future<void> _fetchPortfolioCoins () async{
    _allCoinsInPortfolio =  await CoinService().getPortfolioCoins();
    setState(() {
      _isLoading = false;
    });
  }

  // Gets details of coins from Gecko Api
  List<GeckoModel>? coinMarket = [];
  bool? isLoading;
  Future<void> _fetchAllCoins () async {
    coinMarket = await CoinService().getCoinsFromCoinGeckoApi();
    if(coinMarket!.isNotEmpty){
      setState(() {
        isLoading = true;
      });
    }else{setState(() {isLoading = false;});}
  }



  @override
  void initState() {

    super.initState();
    //portfolio coins info from firebase
    _fetchPortfolioCoins();
    //coins info from api
    _fetchAllCoins();
  }

  // for categoriesCoins part page-view
  final PageController _pageController = PageController();
  void changePage(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {

    // sort coins from geckoApi
    List sortedGainersCoins = List.from(coinMarket!);
    sortedGainersCoins.sort((a, b) => b.marketCapChangePercentage24H
        .compareTo(a.marketCapChangePercentage24H));

    List sortedLosersCoins = List.from(coinMarket!);
    sortedLosersCoins.sort((a, b) => a.marketCapChangePercentage24H
        .compareTo(b.marketCapChangePercentage24H));

    List sortedHotCoins = List.from(coinMarket!);
    sortedHotCoins.sort((a, b) => b.totalVolume.compareTo(a.totalVolume));

    // To calculate total spent of coins in the portfolio
    double totalSpentSum = 0;
    final result = MyFunctions().summarizeCoin(_allCoinsInPortfolio);
    for (var item in result) {
      totalSpentSum += double.parse(item.totalSpent);
    }

    return SafeArea(
        child: Scaffold(
          backgroundColor: CustomColors.bgcolor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const WelcomePart(),
                CreditCard(
                  balance: totalSpentSum.toStringAsFixed(2),
                ),
                EmptyWidget(value: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    portfolioCoinsCardPart(result),
                    categoriesNamesPart(),
                    categoriesCoinsPart(
                        sortedHotCoins, sortedGainersCoins, sortedLosersCoins),
                  ],
                )
              ],
            ),
          ),
        ));
  }




  Column portfolioCoinsCardPart(List<PortfolioCoinsModel> result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          child: Text(
            context.mLocalizations.myPortfolio,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mWhitePrimary.withOpacity(0.9)),
          ),
        ),
        SizedBox(
            height: 170,
            child: _isLoading ? const Center(child: CircularProgressIndicator())
                : result.isNotEmpty ?
            // If there are coins in the portfolio
            ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: result.length,
                itemBuilder: (context, index) {
                  final portfolio = result[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 12, 0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=> PortfolioCoinHistoryPage(coinData: _allCoinsInPortfolio)
                        ));
                      },
                      child: CoinCard(
                        symbol: portfolio.symbol,
                        price: double.parse(portfolio.totalSpent).toStringAsFixed(2),
                        name: portfolio.name,
                        url: portfolio.imageUrl,
                        balance: portfolio.quantity,
                      ),
                    ),
                  );
                })
                :
            // If there are no coins in the portfolio show text : You have not any coin in portfolio
            Center(child: FittedBox(child: Text(context.mLocalizations.isNotHaveAnyCoins)),)
        ),
      ],
    );
  }

  // Shows coins in category
  SizedBox categoriesCoinsPart(List<dynamic> sortedHotCoins, List<dynamic> sortedGainersCoins, List<dynamic> sortedLosersCoins) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: PageView(
        controller: _pageController,
        children: [
          AllCoins(isLoading: isLoading, coinMarket: coinMarket),
          SortedHotCoinsWidget(
              isLoading: isLoading, sortedHotCoins: sortedHotCoins),
          SortedGainersCoinsWidget(
              isLoading: isLoading, sortedGainersCoins: sortedGainersCoins),
          SortedLosersCoinsWidget(
              isLoading: isLoading, sortedLosersCoins: sortedLosersCoins),
        ],
      ),
    );
  }

  // Top100-Hot-Gainers-Losers Categories Name Part
  Padding categoriesNamesPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          TextButton(
              onPressed: () => changePage(0),
              child:  Text(
                ApplicationCustomTexts().top100,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: CustomColors.mLilacPrimary),
              )),
          TextButton(
              onPressed: () => changePage(1),
              child:  Text(
                "${context.mLocalizations.hotCoins} 🔥",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: CustomColors.mYellow),
              )),
          TextButton(
              onPressed: () => changePage(2),
              child:  Text(
                context.mLocalizations.gainersCoin,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: CustomColors.mGreenPrimary),
              )),
          TextButton(
            onPressed: () => changePage(3),
            child: Text(
              context.mLocalizations.losersCoin,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: CustomColors.mRedPrimary.withOpacity(0.9)),
            ),
          ),
        ],
      ),
    );
  }
}

// Shows coins in the gainers part
class SortedGainersCoinsWidget extends StatelessWidget {
  const SortedGainersCoinsWidget({super.key,
    required this.isLoading,
    required this.sortedGainersCoins,
  });

  final bool? isLoading;
  final List sortedGainersCoins;

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
          itemCount: sortedGainersCoins.length,
          shrinkWrap: true,
          itemBuilder: (context, indeks) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: CoinListCard(
                  item: sortedGainersCoins[indeks],
                ));
          })
          :  Padding(
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

// Shows coins in the hot part
class SortedHotCoinsWidget extends StatelessWidget {
  const SortedHotCoinsWidget({super.key,
    required this.isLoading,
    required this.sortedHotCoins,
  });

  final bool? isLoading;
  final List sortedHotCoins;

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
          itemCount: sortedHotCoins.length,
          shrinkWrap: true,
          itemBuilder: (context, indeks) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: CoinListCard(
                  item: sortedHotCoins[indeks],
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

// Shows coins in the losers part
class SortedLosersCoinsWidget extends StatelessWidget {
  const SortedLosersCoinsWidget({super.key,
    required this.isLoading,
    required this.sortedLosersCoins,
  });

  final bool? isLoading;
  final List sortedLosersCoins;

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
          itemCount: sortedLosersCoins.length,
          shrinkWrap: true,
          itemBuilder: (context, indeks) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: CoinListCard(
                  item: sortedLosersCoins[indeks],
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

// Shows coins in the top100 part
class AllCoins extends StatelessWidget {
  const AllCoins({super.key,
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
          itemBuilder: (context, indeks) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: CoinListCard(
                  item: coinMarket![indeks],
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

// Welcome part at the top of the page
class WelcomePart extends StatelessWidget {
  const WelcomePart({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseService().firebaseAuth;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                context.mLocalizations.welcome,
                style: const TextStyle(
                    fontSize: 17,
                    color: CustomColors.mGreyPrimary,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                firebaseService.currentUser?.displayName ??
                    firebaseService.currentUser?.email ??
                    context.mLocalizations.cryptoLover,
                style: const TextStyle(
                    fontSize: 15,
                    color: CustomColors.mWhitePrimary,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
