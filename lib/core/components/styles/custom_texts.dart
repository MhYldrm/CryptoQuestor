final class ApplicationCustomTexts{

// Coins Details Page Texts
  final String statusCode = "429";
  final String usd = "USD";
  final String vol = "Vol";
  String getApiUrl (String name,int days)=> "https://api.coingecko.com/api/v3/coins/$name/ohlc?vs_currency=usd&days=$days";
  final String apiUrlFromGecko = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true";
  final String apiUrlFromFirebase = "https://gist.githubusercontent.com/MhYldrm/38e294ee3df7d18704419df96a8d08c8/raw/55a934103626c09055e57fa98e770ba126a919ba/Earn%2520Files";
  final List<String> times = ["D", "W", "M", "3M", "6M", "Y"];
  final List apiHeaders = ["Content-Type","application/json","Accept","application/json"];

// Earn Details Page Texts
  final List exchangeList = ["OKX", "BINANCE", "Mexc", "Kucoin", "Gate io", "Bitget", "Telegram", "Cro"];
  final String myPortfolioLink = "https://myildirrim.netlify.app";
  final String myEmail = "mmyildirrimm5@gmail.com";
  final String mailTo = "mailto";

// Home Page Text
  final String top100 = "Top 100";

// Image Path Texts
  final String walletImagePath = "assets/wallet.png";
  final String blockchainImagePath = "assets/blockchain.png";
  final String aboutUsImagePath = "assets/aboutus.png";
  final String manImagePath = "assets/man.png";
  final String womanImagePath = "assets/woman.png";
  final String contactUsImagePath = "assets/contactus.png";
  final String buyMeCoffeeImagePath = "assets/buymecoffee.png";

// Profile Page Support Us Wallet List Text
  final List bitcoinInfo = ["https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400","Bitcoin","bc1q8t2k7ucqw02g7hwjd209w68gg05kzfrfflznxc"];
  final List ethInfo = ["https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628", "Ethereum","0xAD9ef9a9b72491D5a4b24455d1b6A3c31674Ac8E"];
  final List arbInfo = ["https://coin-images.coingecko.com/coins/images/16547/large/arb.jpg?1721358242", "Arbitrum","0xAD9ef9a9b72491D5a4b24455d1b6A3c31674Ac8E"];
  final List tonInfo = ["https://coin-images.coingecko.com/coins/images/17980/large/photo_2024-09-10_17.09.00.jpeg?1725963446", "Ton Chain","UQAX_GNE2DMPYk3BYmEDDgWffjVfhnKzDsA0ChmpsltEO97c"];
  final List solInfo = ["https://coin-images.coingecko.com/coins/images/4128/large/solana.png?1718769756", "Solana","8ZahF7PUD7asproe4PtXSJ3DXN8AwSigmwWhrxoYhLUx"];
  final List tronInfo = ["https://coin-images.coingecko.com/coins/images/1094/large/tron-logo.png?1696502193", "Tron Chain","TMmJz4eDKmYHiAQB2APSoiGZuGFG72Ymz8"];
}