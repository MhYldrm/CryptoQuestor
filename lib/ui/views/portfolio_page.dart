import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_questor/utils/colors.dart';
import 'package:crypto_questor/utils/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/customappbar.dart';
import '../../widgets/port_coins_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {

  bool isLoading = true;
  List allCoins = [];

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
    super.initState();
    getPortCoins();
  }

  @override
  Widget build(BuildContext context) {
    double totalSpentSum = 0;
    List<Map<String, dynamic>> result = MyFunctions().summarizeData(allCoins);
    for (var item in result) {
      totalSpentSum += item['totalSpent'] as double;
    }

    var mText = AppLocalizations.of(context)!;

    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xff001E34),
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: CustomAppBar(
                    title: mText.myPortfolio,
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
                      color: CustomColors.bgcolor,
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
                      color:CustomColors.mWhitePrimary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Row(
                      children: [
                         Text(
                         mText.totalSpent,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w200,color: CustomColors.mWhitePrimary,),
                        ),
                        const Spacer(),
                        Text(
                          " \$ ${totalSpentSum.toStringAsFixed(3)}",
                          style:
                          const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500,color: CustomColors.mWhitePrimary,),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
