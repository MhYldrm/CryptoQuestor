import 'dart:convert';
import 'package:crypto_questor/ui/views/intro_page.dart';
import 'package:crypto_questor/utils/colors.dart';
import 'package:crypto_questor/utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../models/chart_model.dart';
import '../../services/firebase_service.dart';

class CoinDetailPage extends StatefulWidget {
  var selectCoin;
  CoinDetailPage({super.key, this.selectCoin});

  @override
  State<CoinDetailPage> createState() => _CoinDetailPageState();
}

class _CoinDetailPageState extends State<CoinDetailPage> {
  // for textField
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
  Future<void> getChart() async {
    String url = CustomTexts().getApiUrl(widget.selectCoin.id, days);
    setState(() {
      isLoading = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      CustomTexts().apiHeaders[0] : CustomTexts().apiHeaders[1],
      CustomTexts().apiHeaders[2]: CustomTexts().apiHeaders[3]
    });
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
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


  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: CustomColors.bgcolor,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _addSizedBox(5),
                  _topWidget(),
                  _getDivider(),
                  _topDescription(),
                  _addSizedBox(30),
                  isLoading == true
                      ? _circularIndicator()
                      : itemChart == null || statusCodeError == CustomTexts().statusCode
                      ? _showErrorWidget()
                      : _chartWidget(),
                  _addSizedBox(10),
                  _timesWidget(),
                  _addSizedBox(50),
                  _convertWidget(),
                  _addSizedBox(80),
                  _buttonWidget(),
                ],
              ),
            )));
  }

  _showAlertDialog(BuildContext context) {
    var mText = AppLocalizations.of(context)!;
    double deviceHight = MediaQuery.sizeOf(context).height;
    AlertDialog alert = AlertDialog(
      backgroundColor: CustomColors.bgcolor,
      title: Row(
        children: [
          Text(
          "${mText.addPortfolioCoin}${widget.selectCoin.symbol.toString().toUpperCase()}",
            style: const TextStyle(
              fontSize: 18,
            ),
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
                    mText.pricePerCoin,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  _addSizedBox(5),
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
                            CustomTexts().usd,
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _addSizedBox(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    mText.quantityText,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  _addSizedBox(5),
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
              _addSizedBox(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    mText.totalSpent,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  _addSizedBox(5),
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
                            CustomTexts().usd,
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
          child: Text(mText.cancel),
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
            await FirebaseService().upToPortfolioCoin(upToInfo,uid);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: CustomColors.mYellow,
                duration: const Duration(milliseconds: 800),
                content: Text(
                  "${widget.selectCoin.symbol.toString().toUpperCase()} ${mText.addedPortfolioCoin}",
                  style:  const TextStyle(color: CustomColors.bgcolor),)));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.mPurple,
              elevation: 2.5,
              shadowColor: CustomColors.mPurple,),
          child:  Text(mText.submit),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Padding _buttonWidget() {
    var mText = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _showAlertDialog(context);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.mLightPurple.withOpacity(0.6),
              elevation: 5,
              ),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 61),
            child: Row(
              children: [
                Text(
                  mText.addPortfolioButtonText,
                  style: const TextStyle(
                      fontSize: 15,
                      color: CustomColors.mWhitePrimary,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                 Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Icon(
                    FontAwesomeIcons.wallet,
                    size: 18,
                    color: CustomColors.mWhitePrimary.withOpacity(0.6),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _convertWidget() {
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
                    CustomTexts().usd,
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

  Container _circularIndicator() {
    return Container(
      height: 250,
      child: const Center(
        child: CircularProgressIndicator(
          color: CustomColors.mLilacPrimary,
        ),
      ),
    );
  }

  Container _showErrorWidget() {
    var mText = AppLocalizations.of(context)!;
    return Container(
      height: 250,
      child:  Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(mText.isApiRequestFailed),
        ),
      ),
    );
  }

  SizedBox _addSizedBox(double num) {
    return SizedBox(
      height: num,
    );
  }

  Padding _getDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        thickness: 0.5,
        color: CustomColors.mLilacPrimary.withOpacity(0.7),
      ),
    );
  }

  Container _timesWidget() {
    return Container(
      height: 25,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: CustomTexts().times.length,
        itemBuilder: (context, indeks) {
          return InkWell(
            onTap: () {
              setState(() {
                timesBool = [false, false, false, false, false, false];
                timesBool[indeks] = true;
              });
              setDays(CustomTexts().times[indeks]);
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
                  CustomTexts().times[indeks],
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container _chartWidget() {
    return Container(
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

  Padding _topDescription() {
    var mText = AppLocalizations.of(context)!;
    return Padding(
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
                          mText.twentyHoursText,
                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                        ),
                        Text(
                            mText.details,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                   Text(
                  mText.low,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: CustomColors.mGreyPrimary),
                  ),
                  Text(
                    "\$${widget.selectCoin.low24H.toString()}",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.red.shade300),
                  ),
                ],
              ),
              Column(
                children: [
                   Text(
                     mText.high,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: CustomColors.mGreyPrimary),
                  ),
                  Text(
                    "\$${widget.selectCoin.high24H.toString()}",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.green.shade300),
                  ),
                ],
              ),
              Column(
                children: [
                   Text(
                     CustomTexts().vol,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: CustomColors.mGreyPrimary),
                  ),
                  Text(
                    "\$${widget.selectCoin.totalVolume.toString()} M",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Padding _topWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 17),
      child: SizedBox(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.selectCoin.symbol.toString().toUpperCase(),
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(widget.selectCoin.name,
                          style: widget.selectCoin.name.length < 14
                              ? const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 13)
                              : widget.selectCoin.name.length < 21
                              ? const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 10)
                              : widget.selectCoin.name.length < 25
                              ? const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 9)
                              : const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 7)),
                    ],
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
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${double.parse(widget.selectCoin.marketCapChangePercentage24H.toString()).toStringAsFixed(2)}%",
                        style:
                        widget.selectCoin.marketCapChangePercentage24H >= 0
                            ? TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.green.shade300)
                            : TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.red.shade300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController convertBalance(double x, TextEditingController controller, double price) {
    double sonuc = x / price;
    controller.text = sonuc.toString();
    return controller;
  }

  TextEditingController con(double x, TextEditingController controller, double y) {
    double sonuc = x * y;
    controller.text = sonuc.toString();
    return controller;
  }

  TextEditingController convertCoin(double x, TextEditingController controller, double price) {
    double sonuc = x * price;
    controller.text = sonuc.toString();
    return controller;
  }

  TextEditingController calculatePortfolioTotalSpent(TextEditingController priceController, TextEditingController quantityController, TextEditingController totalSpentcontroller) {
    if (quantityController.text != null) {
      double sonuc = double.parse(priceController.text) *
          double.parse(quantityController.text);
      totalSpentcontroller.text = sonuc.toString();
    } else {}
    return totalSpentcontroller;
  }
}
