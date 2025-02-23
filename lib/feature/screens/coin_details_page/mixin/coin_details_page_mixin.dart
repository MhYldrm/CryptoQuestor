/// A mixin to manage the CoinDetailsPage Page State.
/// [coinController] Holds the USD value of the entered quantity of coins
/// [balanceController] Holds the coin amount of the entered USD value
/// [sheetQuantityController] Indicates the quantity of coins to be added to the portfolio.
/// [sheetTotalSpentController] Indicates the total spent of coins to be added to the portfolio.
/// [sheetPriceController] Indicates the current price of coins to be added to the portfolio.
/// [trackballBehavior] The trackball feature is a tool that displays a tooltip for data points closest to the point you touched in the chart area.
/// [itemChart] Indicates information of coin price chart
/// [statusCodeError] Indicates ErrorCode returned as a result of many requests in Free API
/// [timesBool] A boolean value is stored for each day of the week. The selected day will have a value of true, while all other days will have a value of false.
/// [isLoading] Indicates whether the coins are currently being loaded.
/// [formattedDate] It is used to make the entered date more readable.
/// [getChart] A function that fetches the historical value chart of the coin from the API.
/// [convertBalance]  A function that shows the equivalent number of coins for the USD amount entered by the user.
/// [convertCoin]  A function that displays the current USD value of the number of coins entered by the user.
/// [calculatePortfolioTotalSpent]  A function that calculates the total amount spent when the user wants to add the specified amount of coins to their portfolio.
///
part of '../coin_details_page.dart';

mixin CoinDetailsPageMixin on State<CoinDetailPage> {
  // for calculate coin-usd section textField
  TextEditingController coinController = TextEditingController();
  TextEditingController balanceController = TextEditingController();

  //sheet TextField controller
  TextEditingController sheetQuantityController = TextEditingController();
  TextEditingController sheetTotalSpentController = TextEditingController();
  TextEditingController sheetPriceController = TextEditingController();

  late TrackballBehavior trackballBehavior;
  List<ChartModel>? itemChart;
  String? statusCodeError;
  bool isLoading = true;
  int days = ApplicationConstants.oneNumInt;
  List<bool> timesBool = [true, false, false, false, false, false];
  String formattedDate = DateFormat(ApplicationConstants.dateFormatToConvert)
      .format(DateTime.now());

  @override
  void dispose() {
    super.dispose();
    sheetPriceController.dispose();
    sheetQuantityController.dispose();
    sheetTotalSpentController.dispose();
    coinController.dispose();
    balanceController.dispose();
  }

  @override
  void initState() {
    getChart();
    trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    sheetPriceController.text = widget.selectCoin.currentPrice.toString();
    sheetQuantityController.text = ApplicationConstants.oneNumString;
    super.initState();
  }

  setDays(String time) {
    if (time == ApplicationConstants.times[0]) {
      setState(() {
        days = ApplicationConstants.oneNumInt;
      });
    } else if (time == ApplicationConstants.times[1]) {
      setState(() {
        days = ApplicationConstants.sevenNumInt;
      });
    } else if (time == ApplicationConstants.times[2]) {
      setState(() {
        days = ApplicationConstants.thirtyNumInt;
      });
    } else if (time == ApplicationConstants.times[3]) {
      setState(() {
        days = ApplicationConstants.ninetyNumInt;
      });
    } else if (time == ApplicationConstants.times[4]) {
      setState(() {
        days = ApplicationConstants.oneHundredEightyNumInt;
      });
    } else if (time == ApplicationConstants.times[5]) {
      setState(() {
        days = ApplicationConstants.threeHundredSixtyFiveNumInt;
      });
    }
  }

  // get chart
  Future<void> getChart() async {
    String url = ApplicationConstants.getApiUrl(widget.selectCoin.id, days);
    setState(() {
      isLoading = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      ApplicationConstants.apiHeaders[0]: ApplicationConstants.apiHeaders[1],
      ApplicationConstants.apiHeaders[2]: ApplicationConstants.apiHeaders[3]
    });
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == HttpStatus.ok) {
      Iterable x = jsonDecode(response.body);
      List<ChartModel> chartList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = chartList;
      });
    } else {
      setState(() {
        statusCodeError = response.statusCode.toString();
      });
    }
  }

// To show the instant USD value of the entered amount of coins
  TextEditingController convertBalance(
      double x, TextEditingController controller, double price) {
    double result = x / price;
    controller.text = result.toString();
    return controller;
  }

  // To show the instant coin value of the entered amount of USD
  TextEditingController convertCoin(
      double x, TextEditingController controller, double price) {
    double result = x * price;
    controller.text = result.toString();
    return controller;
  }
}
