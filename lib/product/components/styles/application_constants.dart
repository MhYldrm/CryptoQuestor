/// [ApplicationConstants] contains static constants and URLs used throughout the app.
/// It centralizes application data like API URLs, image paths, and wallet addresses for easy access.
final class ApplicationConstants {
  const ApplicationConstants._();

  /// The main title of the application, typically displayed in the app bar.
  static const String appTitle = "Crypto Questor";

  /// Coins Details Page Texts
  ///
  /// - [usd]: The abbreviation for US Dollar, used in price data and currency conversions.
  /// - [vol]: Abbreviation for trading volume, representing the amount of trading activity for a given coin.
  /// - [statusCode]: Default status code indicating API rate-limiting (e.g., '429' represents too many requests).
  static const String statusCode = "429";
  static const String usd = "USD";
  static const String vol = "Vol";
  static const String success = "success";
  static const String userNotFound = "user-not-found";
  static const String obscuringCharacter = "*";

  /// Generates a URL for fetching OHLC (Open, High, Low, Close) data for a specific coin.
  ///
  /// - [name]: The cryptocurrency name (e.g., "bitcoin").
  /// - [days]: The number of days of historical data to retrieve (e.g., 1, 30, 365).
  static String getApiUrl(String name, int days) =>
      "https://api.coingecko.com/api/v3/coins/$name/ohlc?vs_currency=usd&days=$days";

  /// The base URL for fetching market data from the CoinGecko API.
  static const String apiUrlFromGecko =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true";

  /// A URL for fetching data from a custom Firebase-hosted file.
  static const String apiUrlFromFirebase =
      "https://gist.githubusercontent.com/MhYldrm/38e294ee3df7d18704419df96a8d08c8/raw/55a934103626c09055e57fa98e770ba126a919ba/Earn%2520Files";

  /// A list of common timeframes for displaying cryptocurrency price or market data.
  /// Available options range from daily ("D") to yearly ("Y").
  static const List<String> times = ["D", "W", "M", "3M", "6M", "Y"];

  /// HTTP headers used for making API requests, including content type and response format.
  static const List<String> apiHeaders = [
    "Content-Type",
    "application/json",
    "Accept",
    "application/json"
  ];

  /// Earn Details Page Texts
  ///
  /// A list of supported cryptocurrency exchanges where users can trade or earn rewards.
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

  /// Commonly used numeric and string constants.
  static const String zeroNumString = '0';
  static const String oneNumString = '1';
  static const String emptyString = '';
  static const String dateFormatToConvert = 'yyyy-MM-dd – kk:mm';
  static const double zeroNumDouble = 0;
  static const int zeroNumInt = 0;
  static const int oneNumInt = 1;
  static const int twoNumInt = 2;
  static const int threeNumInt = 3;
  static const int sevenNumInt = 7;
  static const int thirtyNumInt = 30;
  static const int ninetyNumInt = 90;
  static const int oneHundredEightyNumInt = 180;
  static const int threeHundredSixtyFiveNumInt = 365;

  /// URL linking to the user's personal portfolio.
  static const String myPortfolioLink = "https://myildirrim.netlify.app";

  /// Contact email address for support and feedback.
  static const String myEmail = "mmyildirrimm5@gmail.com";

  /// A mail link used for opening the default mail client with a pre-filled email address.
  static const String mailTo = "mailto";

  /// General UI Texts
  static const String getStarted = "GET STARTED";
  static const String darkMode = "Dark Mode";
  static const String lightMode = "Light Mode";

  /// Home Page Texts
  ///
  /// Label for the "Top 100" section, displaying the top 100 cryptocurrencies by market cap.
  static const String top100 = "Top 100";

  /// Image Paths
  static const String walletImagePath = "assets/wallet.png";
  static const String blockchainImagePath = "assets/blockchain.png";
  static const String aboutUsImagePath = "assets/aboutus.png";
  static const String manImagePath = "assets/man.png";
  static const String womanImagePath = "assets/woman.png";
  static const String contactUsImagePath = "assets/contactus.png";
  static const String buyMeCoffeeImagePath = "assets/buymecoffee.png";
  static const String splashImageOnePath = "assets/splash1.png";
  static const String splashImageTwoPath = "assets/splash2.png";
  static const String splashImageThreePath = "assets/splash3.png";

  /// Profile Page Support Us Wallet List
  ///
  /// A list of wallet addresses for different cryptocurrencies.
  /// Users can donate to the developer using any of the following supported coins.
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
