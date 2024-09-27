class CoinModelInfo {
/*
{
  "coins_num": 12834,
  "time": 1722378842
}
*/

  int? coinsNum;
  int? time;

  CoinModelInfo({
    this.coinsNum,
    this.time,
  });
  CoinModelInfo.fromJson(Map<String, dynamic> json) {
    coinsNum = json['coins_num']?.toInt();
    time = json['time']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['coins_num'] = coinsNum;
    data['time'] = time;
    return data;
  }
}

class CoinModelData {
/*
{
  "id": "90",
  "symbol": "BTC",
  "name": "Bitcoin",
  "nameid": "bitcoin",
  "rank": 1,
  "price_usd": "66289.23",
  "percent_change_24h": "-1.60",
  "percent_change_1h": "0.21",
  "percent_change_7d": "-1.07",
  "price_btc": "1.00",
  "market_cap_usd": "1307312045446.80",
  "volume24": 28649536471.4734,
  "volume24a": 36464013618.8581,
  "csupply": "19721334.00",
  "tsupply": "19721334",
  "msupply": "21000000"
}
*/

  String? id;
  String? symbol;
  String? name;
  String? nameid;
  int? rank;
  String? priceUsd;
  String? percentChange_24h;
  String? percentChange_1h;
  String? percentChange_7d;
  String? priceBtc;
  String? marketCapUsd;
  double? volume24;
  double? volume24a;
  String? csupply;
  String? tsupply;
  String? msupply;

  CoinModelData({
    this.id,
    this.symbol,
    this.name,
    this.nameid,
    this.rank,
    this.priceUsd,
    this.percentChange_24h,
    this.percentChange_1h,
    this.percentChange_7d,
    this.priceBtc,
    this.marketCapUsd,
    this.volume24,
    this.volume24a,
    this.csupply,
    this.tsupply,
    this.msupply,
  });
  CoinModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    symbol = json['symbol']?.toString();
    name = json['name']?.toString();
    nameid = json['nameid']?.toString();
    rank = json['rank']?.toInt();
    priceUsd = json['price_usd']?.toString();
    percentChange_24h = json['percent_change_24h']?.toString();
    percentChange_1h = json['percent_change_1h']?.toString();
    percentChange_7d = json['percent_change_7d']?.toString();
    priceBtc = json['price_btc']?.toString();
    marketCapUsd = json['market_cap_usd']?.toString();
    volume24 = json['volume24']?.toDouble();
    volume24a = json['volume24a']?.toDouble();
    csupply = json['csupply']?.toString();
    tsupply = json['tsupply']?.toString();
    msupply = json['msupply']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['symbol'] = symbol;
    data['name'] = name;
    data['nameid'] = nameid;
    data['rank'] = rank;
    data['price_usd'] = priceUsd;
    data['percent_change_24h'] = percentChange_24h;
    data['percent_change_1h'] = percentChange_1h;
    data['percent_change_7d'] = percentChange_7d;
    data['price_btc'] = priceBtc;
    data['market_cap_usd'] = marketCapUsd;
    data['volume24'] = volume24;
    data['volume24a'] = volume24a;
    data['csupply'] = csupply;
    data['tsupply'] = tsupply;
    data['msupply'] = msupply;
    return data;
  }
}

class CoinModel {
/*
{
  "data": [
    {
      "id": "90",
      "symbol": "BTC",
      "name": "Bitcoin",
      "nameid": "bitcoin",
      "rank": 1,
      "price_usd": "66289.23",
      "percent_change_24h": "-1.60",
      "percent_change_1h": "0.21",
      "percent_change_7d": "-1.07",
      "price_btc": "1.00",
      "market_cap_usd": "1307312045446.80",
      "volume24": 28649536471.4734,
      "volume24a": 36464013618.8581,
      "csupply": "19721334.00",
      "tsupply": "19721334",
      "msupply": "21000000"
    }
  ],
  "info": {
    "coins_num": 12834,
    "time": 1722378842
  }
}
*/

  List<CoinModelData?>? data;
  CoinModelInfo? info;

  CoinModel({
    this.data,
    this.info,
  });
  CoinModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <CoinModelData>[];
      v.forEach((v) {
        arr0.add(CoinModelData.fromJson(v));
      });
      data = arr0;
    }
    info = (json['info'] != null) ? CoinModelInfo.fromJson(json['info']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['data'] = arr0;
    }
    if (info != null) {
      data['info'] = info!.toJson();
    }
    return data;
  }
}
