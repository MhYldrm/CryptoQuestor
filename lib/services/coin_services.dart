import 'dart:convert';
import '../models/coin_model.dart';
import '../models/earn_model.dart';
import '../models/gecko_models.dart';
import 'package:http/http.dart' as http;

class CoinService {
  final String url = 'https://api.coinlore.net/api/tickers';

  Future<CoinModel?> getCoinsFromCoinApi() async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var jsonBody = CoinModel.fromJson(jsonDecode(res.body));
      return jsonBody;
    }
    return null;
  }

  Future<List<GeckoModel>?> getCoinsFromCoingeckoApi() async {
    List<GeckoModel> geckoMarketList;
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var x = response.body;
      geckoMarketList = coinModelFromJson(x);
      return geckoMarketList;
    }
    return null;
  }

  Future<List<EarnModel>?> getEarnProjectsfromGithub() async {
    List<EarnModel> earnProjects;
    const url = "https://gist.githubusercontent.com/MhYldrm/38e294ee3df7d18704419df96a8d08c8/raw/55a934103626c09055e57fa98e770ba126a919ba/Earn%2520Files";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var x = response.body;
      earnProjects = earnModelFromJson(x);
      return earnProjects;
    }
    return null;
  }
}
