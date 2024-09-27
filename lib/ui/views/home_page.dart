import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_questor/ui/views/portfolio_coin_history_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Components/item.dart';
import '../../models/gecko_models.dart';
import '../../services/coin_services.dart';
import '../../services/firebase_service.dart';
import '../../widgets/coin_card.dart';
import '../../widgets/credit_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//portfolio coins get from Firebase
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

  List allCoins = [];

  @override
  void initState() {
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

  bool? isLoadinng;
  bool? isLoading;
  final CoinService _service = CoinService();
  List<GeckoModel>? coinMarket = [];

  final PageController _pageController = PageController();

  void _changePage(int indeks) {
    _pageController.jumpToPage(indeks);
  }

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    //double widht = MediaQuery.of(context).size.width;

    List sortedGainersCoins = List.from(coinMarket!);
    sortedGainersCoins.sort((a, b) => b.marketCapChangePercentage24H
        .compareTo(a.marketCapChangePercentage24H));

    List sortedLosersCoins = List.from(coinMarket!);
    sortedLosersCoins.sort((a, b) => a.marketCapChangePercentage24H
        .compareTo(b.marketCapChangePercentage24H));

    List sortedHotCoins = List.from(coinMarket!);
    sortedHotCoins.sort((a, b) => b.totalVolume.compareTo(a.totalVolume));

    //converted the data from firebase
    List<Map<String, dynamic>> summarizeData(List data) {
      Map<String, Map<String, dynamic>> summary = {};
      for (var item in data) {
        String name = item['name'];
        String symbol = item['symbol'];
        String imageUrl = item['imageUrl'];
        double quantity =
        double.parse(item['quantity']);
        double totalSpent = double.parse(item['totalSpent']);

        if (summary.containsKey(name)) {
          summary[name]!['quantity'] =
              (summary[name]!['quantity'] ?? 0) + quantity;
          summary[name]!['totalSpent'] =
              (summary[name]!['totalSpent'] ?? 0) + totalSpent;
        } else {
          summary[name] = {
            'quantity': quantity,
            'totalSpent': totalSpent,
            'symbol': symbol,
            'imageUrl': imageUrl,
          };
        }
      }

      return summary.entries.map((entry) {
        return {
          'name': entry.key,
          'quantity': entry.value['quantity'],
          'totalSpent': entry.value['totalSpent'],
          'symbol': entry.value['symbol'],
          'imageUrl': entry.value['imageUrl']
        };
      }).toList();
    }

    List<Map<String, dynamic>> result = summarizeData(allCoins);
    double totalSpentSum = 0;
    for (var item in result) {
      totalSpentSum += item['totalSpent'] as double;
    }

    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff001E34),
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Text(
                        "My Portfolio",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
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
            }) : const Center(child: Text("You have not any coin in portfolio"),)
    );
  }

  SizedBox _categoriesCoinsPart(List<dynamic> sortedHotCoins,
      List<dynamic> sortedGainersCoins, List<dynamic> sortedLosersCoins) {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          TextButton(
              onPressed: () => _changePage(0),
              child: const Text(
                "Top 100",
                style: TextStyle(
                  color: Color(0xffD4BBFF),
                  fontSize: 13,
                ),
              )),
          TextButton(
              onPressed: () => _changePage(1),
              child: const Text(
                "Hot 🔥",
                style: TextStyle(fontSize: 13,color: Color(0xffFFD400)),
              )),
          TextButton(
              onPressed: () => _changePage(2),
              child: const Text(
                "Gainers",
                style: TextStyle(fontSize: 13,color: Colors.green),
              )),
          TextButton(
            onPressed: () => _changePage(3),
            child: Text(
              "Losers",
              style: TextStyle(fontSize: 13,color: Colors.red.shade300),
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
          : const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
              "Attention this APİ is free, so you cannot send multiple requests per second, please wait and try again later"),
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
          : const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
              "Attention this APİ is free, so you cannot send multiple requests per second, please wait and try again later"),
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
          : const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
              "Attention this APİ is free, so you cannot send multiple requests per second, please wait and try again later"),
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
          : const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
              "Attention this APİ is free, so you cannot send multiple requests per second, please wait and try again later"),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w200),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                firebaseService.currentUser?.displayName ??
                    firebaseService.currentUser?.email ??
                    'Crypto Lover',
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
