import 'dart:convert';
import 'package:crypto_questor/ui/views/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

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
  List<String> times = [
    "D",
    "W",
    "M",
    "3M",
    "6M",
    "Y",
  ];
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
    String url =
        '${'https://api.coingecko.com/api/v3/coins/' + widget.selectCoin.id}/ohlc?vs_currency=usd&days=$days';

    setState(() {
      isLoading = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
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
        print(response.statusCode);
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
            backgroundColor: const Color(0xff001E34),
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
                      : itemChart == null || statusCodeError == "429"
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
    double deviceHight = MediaQuery.sizeOf(context).height;
    AlertDialog alert = AlertDialog(
      backgroundColor: const Color(0xff001E34),
      title: Row(
        children: [
          Text(
            "Add ${widget.selectCoin.symbol.toString().toUpperCase()} to Portfolio",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1.5),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close_outlined,
                  size: 20,
                  color: Colors.red.shade300,
                )),
          )
        ],
      ),
      content: SizedBox(
        height: deviceHight / 2,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Price Per Coin",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                _addSizedBox(5),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 6, 43, 69),
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
                            cursorColor: Colors.deepPurpleAccent,
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
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: VerticalDivider(
                            thickness: 1.5,
                            color: Colors.white12,
                          ),
                        ),
                        const Text(
                          "USD",
                          style: TextStyle(fontWeight: FontWeight.w300),
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
                const Text(
                  "Quantity",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                _addSizedBox(5),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 6, 43, 69),
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
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: VerticalDivider(
                            thickness: 1.5,
                            color: Colors.white12,
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
                const Text(
                  "Total Spent",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                _addSizedBox(5),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 6, 43, 69),
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
                            cursorColor: Colors.deepPurpleAccent,
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
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: VerticalDivider(
                            thickness: 1.5,
                            color: Colors.white12,
                          ),
                        ),
                        const Text(
                          "USD",
                          style: TextStyle(fontWeight: FontWeight.w300),
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
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white12,
            elevation: 1,
          ),
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
                backgroundColor: Colors.deepPurple.shade500,
                duration: const Duration(milliseconds: 800),
                content: Text(
                "${widget.selectCoin.symbol.toString().toUpperCase()} Added to Portfolio 👍",
                  style: const TextStyle(color: Colors.white),)));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple.shade500,
              elevation: 2.5,
              shadowColor: Colors.deepPurpleAccent),
          child: const Text("Submit"),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _showAlertDialog(context);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple.shade500,
              elevation: 2.5,
              shadowColor: Colors.deepPurpleAccent),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 51),
            child: Row(
              children: [
                Text(
                  "Add Portfolio",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(
                    FontAwesomeIcons.wallet,
                    size: 20,
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
              color: const Color.fromARGB(255, 6, 43, 69),
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
                      cursorColor: Colors.deepPurpleAccent,
                      decoration: const InputDecoration(
                        hintMaxLines: 1,
                        border: InputBorder.none,
                        hintText: "0.00",
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 1.5,
                    color: Colors.white12,
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
              color: const Color.fromARGB(255, 6, 43, 69),
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
                      cursorColor: Colors.deepPurpleAccent,
                      decoration: const InputDecoration(
                        hintMaxLines: 1,
                        border: InputBorder.none,
                        hintText: "0.00",
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 1.5,
                    color: Colors.white12,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "USD",
                    style: TextStyle(fontWeight: FontWeight.w300),
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
      child: Center(
        child: CircularProgressIndicator(
          color: const Color(0xffD4BBFF).withOpacity(0.35),
        ),
      ),
    );
  }

  Container _showErrorWidget() {
    return Container(
      height: 250,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Text(
              "Attention this APİ is free, so you cannot send multiple requests per second, please wait and try again later"),
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
        color: const Color(0xffD4BBFF).withOpacity(0.35),
      ),
    );
  }

  Container _timesWidget() {
    return Container(
      height: 25,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: times.length,
        itemBuilder: (context, indeks) {
          return InkWell(
            onTap: () {
              setState(() {
                timesBool = [false, false, false, false, false, false];
                timesBool[indeks] = true;
              });
              setDays(times[indeks]);
              getChart();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: timesBool[indeks] == true
                      ? Colors.deepPurpleAccent.shade700
                      : const Color(0xffD4BBFF).withOpacity(0.35),
                ),
                child: Text(
                  times[indeks],
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
                  height: 50,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.5),
                    child: Column(
                      children: [
                        Text(
                          "24H",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Details",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const Text(
                    "Low",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                  Text(
                    "\$${widget.selectCoin.low24H.toString()}",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.red.shade300),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "High",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                  Text(
                    "\$${widget.selectCoin.high24H.toString()}",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.green.shade300),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "Vol",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                  ),
                  Text(
                    "\$${widget.selectCoin.totalVolume.toString()} M",
                    style: const TextStyle(
                      fontSize: 17,
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
                    height: 65,
                    width: 65,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.selectCoin.symbol.toString().toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(widget.selectCoin.name,
                          style: widget.selectCoin.name.length < 14
                              ? const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 15)
                              : widget.selectCoin.name.length < 21
                              ? const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 12)
                              : widget.selectCoin.name.length < 25
                              ? const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 11)
                              : const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${widget.selectCoin.currentPrice.toString()} \$",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${double.parse(widget.selectCoin.marketCapChangePercentage24H.toString()).toStringAsFixed(2)}%",
                        style:
                        widget.selectCoin.marketCapChangePercentage24H >= 0
                            ? TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.green.shade300)
                            : TextStyle(
                            fontSize: 17,
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

  TextEditingController convertBalance(
      double x, TextEditingController controller, double price) {
    double sonuc = x / price;
    controller.text = sonuc.toString();
    return controller;
  }

  TextEditingController con(
      double x, TextEditingController controller, double y) {
    double sonuc = x * y;
    controller.text = sonuc.toString();
    return controller;
  }

  TextEditingController convertCoin(
      double x, TextEditingController controller, double price) {
    double sonuc = x * price;
    controller.text = sonuc.toString();
    return controller;
  }

  TextEditingController calculatePortfolioTotalSpent(
      TextEditingController priceController,
      TextEditingController quantityController,
      TextEditingController totalSpentcontroller) {
    if (quantityController.text != null) {
      double sonuc = double.parse(priceController.text) *
          double.parse(quantityController.text);
      totalSpentcontroller.text = sonuc.toString();
    } else {}
    return totalSpentcontroller;
  }
}
