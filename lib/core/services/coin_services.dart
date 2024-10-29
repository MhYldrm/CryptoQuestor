import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_questor/core/components/styles/custom_texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/earn_model.dart';
import '../models/gecko_models.dart';
import 'package:http/http.dart' as http;

import '../models/portfolio_coins_model.dart';

final class CoinService {

  Future<List<GeckoModel>?> getCoinsFromCoinGeckoApi() async {
    List<GeckoModel> geckoMarketList;

    var response = await http.get(Uri.parse(ApplicationCustomTexts().apiUrlFromGecko));
    if (response.statusCode == HttpStatus.ok) {
      geckoMarketList = coinModelFromJson(response.body);
      return geckoMarketList;
    }
    return null;
  }

  Future<List<EarnModel>?> getEarnProjectsFromGithub() async {
    List<EarnModel> earnProjects;
    var response = await http.get(Uri.parse(ApplicationCustomTexts().apiUrlFromFirebase));
    if (response.statusCode == HttpStatus.ok) {
      earnProjects = earnModelFromJson(response.body);
      return earnProjects;
    }
    return null;
  }


  Future<List<PortfolioCoinsModel>> getPortfolioCoins () async{
    final firebaseAuth = FirebaseAuth.instance;
    final snapshot = await FirebaseFirestore.instance
        .collection(firebaseAuth.currentUser!.uid)
        .orderBy("name")
        .get();
    return snapshot.docs.map((doc) => PortfolioCoinsModel.fromJson(doc.data())).toList();
  }


}
