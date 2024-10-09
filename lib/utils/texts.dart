class CustomTexts{

// Coins Details Page Texts
String statusCode = "429";
String usd = "USD";
String vol = "Vol";
String getApiUrl (String name,int days)=> "https://api.coingecko.com/api/v3/coins/$name/ohlc?vs_currency=usd&days=$days";
List<String> times = ["D", "W", "M", "3M", "6M", "Y"];
List apiHeaders = ["Content-Type","application/json","Accept","application/json"];

// Earn Details Page Texts
List exchangeList = ["OKX", "BINANCE", "Mexc", "Kucoin", "Gate io", "Bitget", "Telegram", "Cro"];

// Home Page Text
String top100 = "Top 100";

// Image Path Texts
  String walletImagePath = "assets/wallet.png";
  String blockchainImagePath = "assets/blockchain.png";
  String aboutUsImagePath = "assets/aboutus.png";
  String manImagePath = "assets/man.png";
  String womanImagePath = "assets/woman.png";
  String contactUsImagePath = "assets/contactus.png";
  String buyMeCoffeeImagePath = "assets/buymecoffee.png";

// Profile Page Support Us Wallet List Text
  List bitcoinInfo = ["https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400","Bitcoin","bc1q8t2k7ucqw02g7hwjd209w68gg05kzfrfflznxc"];
  List ethInfo = ["https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628", "Ethereum","0xAD9ef9a9b72491D5a4b24455d1b6A3c31674Ac8E"];
  List arbInfo = ["https://coin-images.coingecko.com/coins/images/16547/large/arb.jpg?1721358242", "Arbitrum","0xAD9ef9a9b72491D5a4b24455d1b6A3c31674Ac8E"];
  List tonInfo = ["https://coin-images.coingecko.com/coins/images/17980/large/photo_2024-09-10_17.09.00.jpeg?1725963446", "Ton Chain","UQAX_GNE2DMPYk3BYmEDDgWffjVfhnKzDsA0ChmpsltEO97c"];
  List solInfo = ["https://coin-images.coingecko.com/coins/images/4128/large/solana.png?1718769756", "Solana","8ZahF7PUD7asproe4PtXSJ3DXN8AwSigmwWhrxoYhLUx"];
  List tronInfo = ["https://coin-images.coingecko.com/coins/images/1094/large/tron-logo.png?1696502193", "Tron Chain","TMmJz4eDKmYHiAQB2APSoiGZuGFG72Ymz8"];
}