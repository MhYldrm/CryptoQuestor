import 'dart:io';
import '../../components/styles/project_constants.dart';
import '../../models/earn_model.dart';
import '../../models/gecko_model_helper.dart';
import '../../models/gecko_model.dart';
import 'package:http/http.dart' as http;

/// [CoinService] Handles API calls for fetching coin data and earning projects.
///
final class CoinService {
  /// Fetches the list of coins from the CoinGecko API.
  /// Returns a list of [GeckoModel] or null if the request fails.
  Future<List<GeckoModel>?> getCoinsFromCoinGeckoApi() async {
    List<GeckoModel> geckoMarketList;
    var response = await http.get(Uri.parse(ProjectConstants.apiUrlFromGecko));
    if (response.statusCode == HttpStatus.ok) {
      geckoMarketList = GeckoModelHelper.fromJsonList(response.body);
      return geckoMarketList;
    }
    return null;
  }

  /// Fetches earning project data from the Firebase API (hosted on GitHub).
  /// Returns a list of [EarnModel] or null if the request fails.
  Future<List<EarnModel>?> getEarnProjectsFromGithub() async {
    List<EarnModel> earnProjects;
    var response = await http.get(Uri.parse(ProjectConstants.apiUrlFromFirebase));
    if (response.statusCode == HttpStatus.ok) {
      earnProjects = earnModelFromJson(response.body);
      return earnProjects;
    }
    return null;
  }
}
