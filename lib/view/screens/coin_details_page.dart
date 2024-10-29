import 'dart:convert';
import 'dart:io';
import 'package:crypto_questor/core/components/button/my_custom_button.dart';
import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/core/components/styles/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../core/models/chart_model.dart';
import '../../core/services/firebase_service.dart';
import '../widgets/empty_widget.dart';
import 'intro_page.dart';

class CoinDetailPage extends StatefulWidget {
  final dynamic selectCoin;
  const CoinDetailPage({super.key, this.selectCoin});

  @override
  State<CoinDetailPage> createState() => _CoinDetailPageState();
}

class _CoinDetailPageState extends State<CoinDetailPage> {

  // for calculate coin-usd section textField
  TextEditingController coinController = TextEditingController();
  TextEditingController balanceController = TextEditingController();

  //sheet TextField controller
  TextEditingController sheetQuantityController = TextEditingController();
  TextEditingController sheetTotalSpentController = TextEditingController();
  TextEditingController sheetPriceController = TextEditingController();

  //chart widget controller
  late TrackballBehavior trackballBehavior;

  // chart details list
  List<ChartModel>? itemChart;

  //for too many request free api
  String? statusCodeError;

  // Required values for chart widget
  List<bool> timesBool = [true, false, false, false, false, false];
  int days = 1;

  setDays(String txt) {
    if (txt == 'D') {
      setState(() {
        days = 1;
      });
    } else if (txt == 'W') {
      setState(() {
        days = 7;
      });
    } else if (txt == 'M') {
      setState(() {
        days = 30;
      });
    } else if (txt == '3M') {
      setState(() {
        days = 90;
      });
    } else if (txt == '6M') {
      setState(() {
        days = 180;
      });
    } else if (txt == 'Y') {
      setState(() {
        days = 365;
      });
    }
  }

  bool isLoading = true;

  // get chart
  Future<void> getChart() async {
    String url = ApplicationCustomTexts().getApiUrl(widget.selectCoin.id, days);
    setState(() {
      isLoading = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      ApplicationCustomTexts().apiHeaders[0] : ApplicationCustomTexts().apiHeaders[1],
      ApplicationCustomTexts().apiHeaders[2]: ApplicationCustomTexts().apiHeaders[3]
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
    sheetQuantityController.text = "1";
    super.initState();
  }


  // To edit date data while adding a transaction to the portfolio
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: CustomColors.bgcolor,
            body: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      titleWidget(),
                      convertWidget(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      showCoinLowHighDescription(),
                      isLoading == true
                          ? showCircularIndicator()
                          : itemChart == null || statusCodeError == ApplicationCustomTexts().statusCode
                          ? showErrorWidget()
                          : chartWidget(),
                      timesSectionWidget(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyCustomButton(
                        onPressed: (){
                          showAlertDialogForAddPortfolio(context);
                        },
                        textName: context.mLocalizations.addPortfolioButtonText,
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  showAlertDialogForAddPortfolio(BuildContext context) {
    double deviceHight = MediaQuery.sizeOf(context).height;
    AlertDialog alert = AlertDialog(
      backgroundColor: CustomColors.bgcolor,
      title: Row(
        children: [
          Text(
          "${context.mLocalizations.addPortfolioCoin}${widget.selectCoin.symbol.toString().toUpperCase()}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1.3),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close_outlined,
                  size: 20,
                  color: CustomColors.mPinkPrimary,
                )),
          )
        ],
      ),
      content: SizedBox(
        height: deviceHight / 2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    context.mLocalizations.pricePerCoin,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  EmptyWidget(value: 5),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.mLightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: TextField(
                              controller: sheetPriceController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    sheetPriceController.text = value;
                                    calculatePortfolioTotalSpent(
                                        sheetPriceController,
                                        sheetQuantityController,
                                        sheetTotalSpentController);
                                  });
                                } else {
                                  setState(() {
                                    sheetPriceController.text = "0";
                                  });
                                }
                              },
                              cursorColor:  CustomColors.mPurple,
                              decoration: InputDecoration(
                                hintMaxLines: 1,
                                border: InputBorder.none,
                                hintText: "${widget.selectCoin.currentPrice}",
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 55,
                          ),
                           Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: VerticalDivider(
                              thickness: 1.5,
                              color: CustomColors.mWhitePrimary.withOpacity(0.1),
                            ),
                          ),
                           Text(
                            ApplicationCustomTexts().usd,
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              EmptyWidget(value: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    context.mLocalizations.quantityText,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  EmptyWidget(value: 5),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.mLightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: TextField(
                              controller: sheetQuantityController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.deepPurpleAccent,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    sheetQuantityController.text = value;
                                    calculatePortfolioTotalSpent(
                                        sheetPriceController,
                                        sheetQuantityController,
                                        sheetTotalSpentController);
                                  });
                                } else {
                                  setState(() {
                                    sheetQuantityController.text = "0";
                                  });
                                }
                              },
                              decoration: const InputDecoration(
                                hintMaxLines: 1,
                                border: InputBorder.none,
                                hintText: "0",
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 55,
                          ),
                           Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: VerticalDivider(
                              thickness: 1.5,
                              color: CustomColors.mWhitePrimary.withOpacity(0.1),
                            ),
                          ),
                          Text(
                            widget.selectCoin.symbol.toString().toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              EmptyWidget(value: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    context.mLocalizations.totalSpent,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  EmptyWidget(value: 5),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.mLightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: TextField(
                              controller: sheetTotalSpentController,
                              cursorColor: CustomColors.mPurple,
                              decoration: const InputDecoration(
                                hintMaxLines: 1,
                                border: InputBorder.none,
                                hintText: "0",
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 55,
                          ),
                           Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: VerticalDivider(
                              thickness: 1.5,
                              color: CustomColors.mWhitePrimary.withOpacity(0.1),
                            ),
                          ),
                           Text(
                            ApplicationCustomTexts().usd,
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.mWhitePrimary.withOpacity(0.2),
            elevation: 1,
          ),
          child: Text(context.mLocalizations.cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            String uid = randomAlphaNumeric(10);
            Map<String, dynamic> upToInfo = {
              'dateTime': formattedDate,
              'imageUrl': widget.selectCoin.image,
              'name': widget.selectCoin.name,
              'symbol': widget.selectCoin.symbol,
              'quantity': sheetQuantityController.text,
              'totalSpent': sheetTotalSpentController.text,
              'uid' : uid,
            };
            if(upToInfo['totalSpent'] != null && upToInfo['totalSpent'].isNotEmpty) {
              await FirebaseService().upToPortfolioCoin(upToInfo,uid);
            }
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: CustomColors.mYellow,
                duration: const Duration(milliseconds: 800),
                content: Text(
                  "${widget.selectCoin.symbol.toString().toUpperCase()} ${context.mLocalizations.addedPortfolioCoin}",
                  style:  const TextStyle(color: CustomColors.bgcolor),)));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.mPurple,
              elevation: 2.5,
              shadowColor: CustomColors.mPurple,),
          child:  Text(context.mLocalizations.submit),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Padding convertWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 160,
            decoration: BoxDecoration(
              color: CustomColors.mLightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 50,
                    child: TextField(
                      controller: coinController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            convertCoin(double.parse(value), balanceController,
                                widget.selectCoin.currentPrice);
                          });
                        } else {
                          setState(() {
                            balanceController.text = "";
                          });
                        }
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: CustomColors.mPurple,
                      decoration: const InputDecoration(
                        hintMaxLines: 1,
                        border: InputBorder.none,
                        hintText: "0.00",
                      ),
                    ),
                  ),
                   VerticalDivider(
                    thickness: 1.5,
                    color: CustomColors.mGreyPrimary.withOpacity(0.5),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.network(
                    widget.selectCoin.image,
                    fit: BoxFit.fill,
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: 70,
            width: 160,
            decoration: BoxDecoration(
              color: CustomColors.mLightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 50,
                    child: TextField(
                      controller: balanceController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            convertBalance(double.parse(value), coinController,
                                widget.selectCoin.currentPrice);
                          });
                        } else {
                          setState(() {
                            coinController.text = "";
                          });
                        }
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: CustomColors.mPurple,
                      decoration: const InputDecoration(
                        hintMaxLines: 1,
                        border: InputBorder.none,
                        hintText: "0.00",
                      ),
                    ),
                  ),
                   VerticalDivider(
                    thickness: 1.5,
                    color: CustomColors.mGreyPrimary.withOpacity(0.5),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                   Text(
                    ApplicationCustomTexts().usd,
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox showCircularIndicator() {
    return const SizedBox(
      height: 250,
      child: Center(
        child: CircularProgressIndicator(
          color: CustomColors.mLilacPrimary,
        ),
      ),
    );
  }

  // If Api Request Failed Widget
  SizedBox showErrorWidget() {
    return SizedBox(
      height: 250,
      child:  Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(context.mLocalizations.isApiRequestFailed),
        ),
      ),
    );
  }


  Padding getCustomDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        thickness: 0.5,
        color: CustomColors.mLilacPrimary.withOpacity(0.7),
      ),
    );
  }

  // D,W,M,3M,6M,Y times section part
  Column timesSectionWidget() {
    return Column(
      children: [
        SizedBox(
          height: 25,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: ApplicationCustomTexts().times.length,
            itemBuilder: (context, indeks) {
              return InkWell(
                onTap: () {
                  setState(() {
                    timesBool = [false, false, false, false, false, false];
                    timesBool[indeks] = true;
                  });
                  setDays(ApplicationCustomTexts().times[indeks]);
                  getChart();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: timesBool[indeks] == true
                          ? CustomColors.mPurple
                          : CustomColors.mLilacPrimary.withOpacity(0.25),
                    ),
                    child: Text(
                      ApplicationCustomTexts().times[indeks],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Coin history chart widget
  SizedBox chartWidget() {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: SfCartesianChart(
        trackballBehavior: trackballBehavior,
        zoomPanBehavior:
        ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x),
        series: <CandleSeries>[
          CandleSeries<ChartModel, int>(
            enableSolidCandles: true,
            enableTooltip: true,
            bullColor: Colors.green,
            bearColor: Colors.red,
            dataSource: itemChart,
            xValueMapper: (ChartModel sales, _) => sales.time,
            lowValueMapper: (ChartModel sales, _) => sales.low,
            highValueMapper: (ChartModel sales, _) => sales.high,
            openValueMapper: (ChartModel sales, _) => sales.open,
            closeValueMapper: (ChartModel sales, _) => sales.close,
            animationDuration: 55,
          )
        ],
      ),
    );
  }

  // 24H Details - Low - High - Vol Section Widget
  Column showCoinLowHighDescription() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 7, left: 7),
          child: SizedBox(
              height: 60,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 45,
                      width: 50,
                      decoration: BoxDecoration(
                        color: CustomColors.mPurple,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(5.5),
                        child: Column(
                          children: [
                            Text(
                              context.mLocalizations.twentyHoursText,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: CustomColors.mWhitePrimary),
                            ),
                            Text(
                                context.mLocalizations.details,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: CustomColors.mWhitePrimary,fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                       Text(
                         context.mLocalizations.low,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: CustomColors.mGreyPrimary,fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "\$${widget.selectCoin.low24H.toString()}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red.shade300,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                       Text(
                         context.mLocalizations.high,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: CustomColors.mGreyPrimary,fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "\$${widget.selectCoin.high24H.toString()}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green.shade300,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                       Text(
                         ApplicationCustomTexts().vol,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: CustomColors.mGreyPrimary,fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "\$${widget.selectCoin.totalVolume.toString()} M",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.mWhitePrimary,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }

  // Coin Name and current price widget
  Padding titleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 65,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const IntroPage()));
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.network(
                        widget.selectCoin.image,
                        height: 55,
                        width: 55,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 55,
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectCoin.symbol.toString().toUpperCase(),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mWhitePrimary,fontWeight: FontWeight.bold),
                            ),
                            FittedBox(
                              child: Text(widget.selectCoin.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: CustomColors.mGreyPrimary,fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.selectCoin.currentPrice.toString()} \$",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mWhitePrimary,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${double.parse(widget.selectCoin.marketCapChangePercentage24H.toString()).toStringAsFixed(2)}%",
                            style:
                            widget.selectCoin.marketCapChangePercentage24H >= 0
                                ? Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.green.shade300,fontWeight: FontWeight.w300)
                                : Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red.shade300,fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          getCustomDivider(),
        ],
      ),
    );
  }

  // To show the instant USD value of the entered amount of coins
  TextEditingController convertBalance(double x, TextEditingController controller, double price) {
    double sonuc = x / price;
    controller.text = sonuc.toString();
    return controller;
  }

  // To show the instant coin value of the entered amount of USD
  TextEditingController convertCoin(double x, TextEditingController controller, double price) {
    double sonuc = x * price;
    controller.text = sonuc.toString();
    return controller;
  }


  // Amount to be added to the portfolio
  TextEditingController calculatePortfolioTotalSpent(TextEditingController priceController, TextEditingController quantityController, TextEditingController totalSpentcontroller) {
    if (quantityController.text.isNotEmpty) {
      double sonuc = double.parse(priceController.text) *
          double.parse(quantityController.text);
      totalSpentcontroller.text = sonuc.toString();
    } else {}
    return totalSpentcontroller;
  }
}
