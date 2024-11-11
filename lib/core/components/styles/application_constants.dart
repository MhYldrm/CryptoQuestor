final class ApplicationConstants {
 const ApplicationConstants._();

 // main.dart app title texts
 static const String appTitle = "Crypto Questor";

 // Coins Details Page Texts
 static const String statusCode = "429";
 static const String usd = "USD";
 static const String vol = "Vol";

 static String getApiUrl(String name, int days) =>
     "https://api.coingecko.com/api/v3/coins/$name/ohlc?vs_currency=usd&days=$days";

 static const String apiUrlFromGecko =
     "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true";

 static const String apiUrlFromFirebase =
     "https://gist.githubusercontent.com/MhYldrm/38e294ee3df7d18704419df96a8d08c8/raw/55a934103626c09055e57fa98e770ba126a919ba/Earn%2520Files";

 static const List<String> times = ["D", "W", "M", "3M", "6M", "Y"];

 static const List<String> apiHeaders = [
  "Content-Type",
  "application/json",
  "Accept",
  "application/json"
 ];

 // Earn Details Page Texts
 static const List<String> exchangeList = [
  "OKX",
  "BINANCE",
  "Mexc",
  "Kucoin",
  "Gate io",
  "Bitget",
  "Telegram",
  "Cro"
 ];

 static const String myPortfolioLink = "https://myildirrim.netlify.app";
 static const String myEmail = "mmyildirrimm5@gmail.com";
 static const String mailTo = "mailto";

 // Home Page Text
 static const String top100 = "Top 100";

 // Image Path Texts
 static const String walletImagePath = "assets/wallet.png";
 static const String blockchainImagePath = "assets/blockchain.png";
 static const String aboutUsImagePath = "assets/aboutus.png";
 static const String manImagePath = "assets/man.png";
 static const String womanImagePath = "assets/woman.png";
 static const String contactUsImagePath = "assets/contactus.png";
 static const String buyMeCoffeeImagePath = "assets/buymecoffee.png";

 // Profile Page Support Us Wallet List Text
 static const List<List<String>> buyMeCoffeeWalletAddress = [
  [
   "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
   "Bitcoin",
   "bc1q8t2k7ucqw02g7hwjd209w68gg05kzfrfflznxc"
  ],
  [
   "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628",
   "Ethereum",
   "0xAD9ef9a9b72491D5a4b24455d1b6A3c31674Ac8E"
  ],
  [
   "https://coin-images.coingecko.com/coins/images/16547/large/arb.jpg?1721358242",
   "Arbitrum",
   "0xAD9ef9a9b72491D5a4b24455d1b6A3c31674Ac8E"
  ],
  [
   "https://coin-images.coingecko.com/coins/images/17980/large/photo_2024-09-10_17.09.00.jpeg?1725963446",
   "Ton Chain",
   "UQAX_GNE2DMPYk3BYmEDDgWffjVfhnKzDsA0ChmpsltEO97c"
  ],
  [
   "https://coin-images.coingecko.com/coins/images/4128/large/solana.png?1718769756",
   "Solana",
   "8ZahF7PUD7asproe4PtXSJ3DXN8AwSigmwWhrxoYhLUx"
  ],
  [
   "https://coin-images.coingecko.com/coins/images/1094/large/tron-logo.png?1696502193",
   "Tron Chain",
   "TMmJz4eDKmYHiAQB2APSoiGZuGFG72Ymz8"
  ]
 ];
}
