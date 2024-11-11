import 'dart:io';
import '../components/styles/application_constants.dart';
import '../models/earn_model.dart';
import '../models/gecko_models.dart';
import 'package:http/http.dart' as http;

final class CoinService {

  Future<List<GeckoModel>?> getCoinsFromCoinGeckoApi() async {
    List<GeckoModel> geckoMarketList;

    var response = await http.get(Uri.parse(ApplicationConstants.apiUrlFromGecko));
    if (response.statusCode == HttpStatus.ok) {
      geckoMarketList = GeckoCoinModels.fromJsonList(response.body);
      return geckoMarketList;
    }
    return null;
  }

  Future<List<EarnModel>?> getEarnProjectsFromGithub() async {
    List<EarnModel> earnProjects;
    var response = await http.get(Uri.parse(ApplicationConstants.apiUrlFromFirebase));
    if (response.statusCode == HttpStatus.ok) {
      earnProjects = earnModelFromJson(response.body);
      return earnProjects;
    }
    return null;
  }

}
