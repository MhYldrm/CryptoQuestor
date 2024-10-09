import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_questor/ui/views/portfolio_coin_history_page.dart';
import 'package:crypto_questor/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Components/item.dart';
import '../../models/gecko_models.dart';
import '../../services/coin_services.dart';
import '../../services/firebase_service.dart';
import '../../utils/functions.dart';
import '../../utils/texts.dart';
import '../../widgets/coin_card.dart';
import '../../widgets/credit_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//portfolio coins get from Firebase
  List allCoins = [];
  bool? isLoadinng;
  getPortCoins() async {
    final firebaseAuth = FirebaseAuth.instance;
    isLoadinng = true;
    var data = await FirebaseFirestore.instance
        .collection(firebaseAuth.currentUser!.uid)
        .orderBy("name")
        .get();
    setState(() {
      allCoins = data.docs;
    });
    isLoadinng = false;
  }

  //coins info from api
  final CoinService _service = CoinService();
  List<GeckoModel>? coinMarket = [];
  bool? isLoading;

  @override
  void initState() {
    //coins info from api
    _service.getCoinsFromCoingeckoApi().then((value) {
      if (value != null) {
        setState(() {
          coinMarket = value;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
    getPortCoins();
  }

  // for categoriesCoins part page-view
  final PageController _pageController = PageController();
  void _changePage(int indeks) {
    _pageController.jumpToPage(indeks);
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

    List<Map<String, dynamic>> result = MyFunctions().summarizeData(allCoins);
    double totalSpentSum = 0;
    for (var item in result) {
      totalSpentSum += item['totalSpent'] as double;
    }

    var mText = AppLocalizations.of(context)!;
    return SafeArea(
        child: Scaffold(
          backgroundColor: CustomColors.bgcolor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const _welcomePart(),
                CreditCard(
                  balance: totalSpentSum.toStringAsFixed(2),
                ),
                _addSizedBox(30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Text(
                        mText.myPortfolio,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.mWhitePrimary.withOpacity(0.9)
                        ),
                      ),
                    ),
                    _addSizedBox(10),
                    _portfolioCoinsCardPart(result),
                    _addSizedBox(5),
                    _categoriesPart(),
                    _categoriesCoinsPart(
                        sortedHotCoins, sortedGainersCoins, sortedLosersCoins),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  SizedBox _addSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  SizedBox _portfolioCoinsCardPart(List<Map<String, dynamic>> result) {
    var mText = AppLocalizations.of(context)!;
    return SizedBox(
        height: 170,
        child: isLoadinng == true
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : result.isNotEmpty ?
        ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: result.length,
            itemBuilder: (context, indeks) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 12, 0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> PortfolioCoinHistoryPage(coinData: allCoins)
                    ));
                  },
                  child: CoinCard(
                    symbol: result[indeks]['symbol'],
                    price: result[indeks]['totalSpent'].toStringAsFixed(2),
                    name: result[indeks]['name'],
                    url: result[indeks]['imageUrl'],
                    balance: result[indeks]['quantity'].toString(),
                  ),
                ),
              );
            }) :  Center(child: Text(mText.isNotHaveAnyCoins),)
    );
  }

  SizedBox _categoriesCoinsPart(List<dynamic> sortedHotCoins, List<dynamic> sortedGainersCoins, List<dynamic> sortedLosersCoins) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: PageView(
        controller: _pageController,
        children: [
          _allCoins(isLoading: isLoading, coinMarket: coinMarket),
          _sortedHotCoinsWidget(
              isLoading: isLoading, sortedHotCoins: sortedHotCoins),
          _sortedGainersCoinsWidget(
              isLoading: isLoading, sortedGainersCoins: sortedGainersCoins),
          _sortedLosersCoinsWidget(
              isLoading: isLoading, sortedLosersCoins: sortedLosersCoins),
        ],
      ),
    );
  }

  Padding _categoriesPart() {
    var mText = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          TextButton(
              onPressed: () => _changePage(0),
              child:  Text(
                CustomTexts().top100,
                style: const TextStyle(
                  color: CustomColors.mLilacPrimary,
                  fontSize: 11.5,
                ),
              )),
          TextButton(
              onPressed: () => _changePage(1),
              child:  Text(
                "${mText.hotCoins} 🔥",
                style: const TextStyle(fontSize: 11.5,color: CustomColors.mYellow,),
              )),
          TextButton(
              onPressed: () => _changePage(2),
              child:  Text(
                mText.gainersCoin,
                style: const TextStyle(fontSize: 11.5,color: CustomColors.mGreenPrimary,),
              )),
          TextButton(
            onPressed: () => _changePage(3),
            child: Text(
              mText.losersCoin,
              style: TextStyle(fontSize: 11.5,color: CustomColors.mRedPrimary.withOpacity(0.9),),
            ),
          ),
        ],
      ),
    );
  }
}

class _sortedGainersCoinsWidget extends StatelessWidget {
  const _sortedGainersCoinsWidget({
    required this.isLoading,
    required this.sortedGainersCoins,
  });

  final bool? isLoading;
  final List sortedGainersCoins;

  @override
  Widget build(BuildContext context) {
    var mText = AppLocalizations.of(context)!;
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
                child: Item(
                  item: sortedGainersCoins[indeks],
                ));
          })
          :  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
              mText.isApiRequestFailed,
          style: const TextStyle(
            color: CustomColors.mWhitePrimary
          ),),
        ),
      ),
    );
  }
}

class _sortedHotCoinsWidget extends StatelessWidget {
  const _sortedHotCoinsWidget({
    required this.isLoading,
    required this.sortedHotCoins,
  });

  final bool? isLoading;
  final List sortedHotCoins;

  @override
  Widget build(BuildContext context) {
    var mText = AppLocalizations.of(context)!;
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
                child: Item(
                  item: sortedHotCoins[indeks],
                ));
          })
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
              mText.isApiRequestFailed,
            style: const TextStyle(
                color: CustomColors.mWhitePrimary
            ),),
        ),
      ),
    );
  }
}

class _sortedLosersCoinsWidget extends StatelessWidget {
  const _sortedLosersCoinsWidget({
    required this.isLoading,
    required this.sortedLosersCoins,
  });

  final bool? isLoading;
  final List sortedLosersCoins;

  @override
  Widget build(BuildContext context) {
    var mText = AppLocalizations.of(context)!;
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
                child: Item(
                  item: sortedLosersCoins[indeks],
                ));
          })
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            mText.isApiRequestFailed,
            style: const TextStyle(
                color: CustomColors.mWhitePrimary
            ),),
        ),
      ),
    );
  }
}

class _allCoins extends StatelessWidget {
  const _allCoins({
    required this.isLoading,
    required this.coinMarket,
  });

  final bool? isLoading;
  final List<GeckoModel>? coinMarket;

  @override
  Widget build(BuildContext context) {
    var mText = AppLocalizations.of(context)!;
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
                child: Item(
                  item: coinMarket![indeks],
                ));
          })
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            mText.isApiRequestFailed,
            style: const TextStyle(
                color: CustomColors.mWhitePrimary
            ),),
        ),
      ),
    );
  }
}

class _welcomePart extends StatelessWidget {
  const _welcomePart();

  @override
  Widget build(BuildContext context) {
    var firebaseService = FirebaseService().firebaseAuth;
    var mText = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                mText.welcome,
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
                    mText.cryptoLover,
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
