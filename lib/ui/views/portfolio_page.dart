import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/customappbar.dart';
import '../../widgets/port_coins_card.dart';
import 'intro_page.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFireStore = FirebaseFirestore.instance;
  bool isLoading = true;

  List allCoins = [];
  List allPCoins = [];
  double toplam = 0;

  getPortCoins() async {
    final firebaseAuth = FirebaseAuth.instance;
    isLoading = true;
    var data = await FirebaseFirestore.instance
        .collection(firebaseAuth.currentUser!.uid)
        .orderBy("name")
        .get();
    setState(() {
      allCoins = data.docs;
    });
    isLoading = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPortCoins();
  }

  @override
  Widget build(BuildContext context) {
    double totalSpentSum = 0;
    List<Map<String, dynamic>> summarizeData(List data) {
      Map<String, Map<String, dynamic>> summary = {};
      for (var item in data) {
        String name = item['name'];
        String symbol = item['symbol'];
        String imageUrl = item['imageUrl'];
        double quantity =
        double.parse(item['quantity']); // int -> double dönüşümü
        double totalSpent = double.parse(item['totalSpent']); // double dönüşümü

        // Eğer name Map'te varsa quantity ve totalSpent'i topluyoruz, yoksa yeni bir entry ekliyoruz
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

      // Summary Map'ini listeye dönüştürüyoruz
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
    for (var item in result) {
      totalSpentSum += item['totalSpent'] as double;
    }

    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xff001E34),
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: CustomAppBar(
                    title: "My Portfolio",
                    icon: Icons.account_balance_wallet_outlined,
                    iconSize: 33,
                    iconColor: Colors.black)),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  isLoading == false
                      ? Container(
                      height: 500,
                      color: const Color(0xff001E34),
                      child: ListView.builder(
                          itemCount: result.length,
                          shrinkWrap: true,
                          itemBuilder: (context, indeks) {
                            return Padding(
                              padding:
                              const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: PortCoinsCard(
                                  imageUrl: result[indeks]['imageUrl'],
                                  symbol: result[indeks]['symbol'],
                                  name: result[indeks]['name'],
                                  quantity: result[indeks]['quantity'],
                                  totalSpent: result[indeks]['totalSpent']),
                            );
                          }))
                      : const SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Row(
                      children: [
                        const Text(
                          "Total Spent :",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                        const Spacer(),
                        Text(
                          " \$ ${totalSpentSum.toStringAsFixed(3)}",
                          style:
                          const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Padding _topWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SizedBox(
        height: 65,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IntroPage()));
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            const SizedBox(
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      "assets/wallet.png",
                      height: 35,
                      width: 35,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    "My Portfolio",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
