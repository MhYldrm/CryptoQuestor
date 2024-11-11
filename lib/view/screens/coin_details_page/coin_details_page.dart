import 'package:crypto_questor/core/components/button/my_custom_button.dart';
import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/core/components/styles/application_constants.dart';
import 'package:crypto_questor/view/screens/coin_details_page/mixin/coin_details_page_mixin.dart';
import 'package:crypto_questor/view/screens/coin_details_page/widget/chart_widget.dart';
import 'package:crypto_questor/view/screens/coin_details_page/widget/coin_low_high_description_widget.dart';
import 'package:crypto_questor/view/screens/coin_details_page/widget/coin_title_price_part_widget.dart';
import 'package:crypto_questor/view/screens/coin_details_page/widget/converts_widget.dart';
import 'package:crypto_questor/view/screens/coin_details_page/widget/show_circular_indicator.dart';
import 'package:crypto_questor/view/screens/coin_details_page/widget/show_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import '../../../core/services/firebase_service.dart';
import '../../widgets/empty_widget.dart';

class CoinDetailPage extends StatefulWidget {
  final dynamic selectCoin;
  const CoinDetailPage({super.key, this.selectCoin});

  @override
  State<CoinDetailPage> createState() => _CoinDetailPageState();
}

class _CoinDetailPageState extends State<CoinDetailPage>
    with CoinDetailsPageMixin {
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
                      CoinTitlePricePartWidget(
                          imageUrl: widget.selectCoin.image,
                          symbol: widget.selectCoin.symbol,
                          name: widget.selectCoin.name,
                          currentPrice: widget.selectCoin.currentPrice,
                          marketCapChangePercentage24H: widget.selectCoin.marketCapChangePercentage24H,
                      ),
                      _buildConvertsWidgets(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CoinLowHighDescriptionWidget(
                        low24H: widget.selectCoin.low24H,
                        high24H: widget.selectCoin.high24H,
                        totalVolume: widget.selectCoin.totalVolume,
                      ),
                      _buildChart(),
                      _timesSectionWidget(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyCustomButton(
                        onPressed: () {
                          _showAlertDialogForAddPortfolio(context);
                        },
                        buttonText:
                            context.mLocalizations.addPortfolioButtonText,
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget _buildChart() {
    if (isLoading) {
      return const ShowCircularIndicator();
    }

    if (itemChart == null ||
        statusCodeError == ApplicationConstants.statusCode) {
      return const ShowErrorWidget();
    }

    return ChartWidget(
        itemChart: itemChart, trackballBehavior: trackballBehavior);
  }

  _showAlertDialogForAddPortfolio(BuildContext context) {
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
                  const EmptyWidget(height: 5),
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
                              cursorColor: CustomColors.mPurple,
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
                              color:
                                  CustomColors.mWhitePrimary.withOpacity(0.1),
                            ),
                          ),
                          const Text(
                            ApplicationConstants.usd,
                            style: TextStyle(fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const EmptyWidget(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.mLocalizations.quantityText,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const EmptyWidget(height: 5),
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
                              color:
                                  CustomColors.mWhitePrimary.withOpacity(0.1),
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
              const EmptyWidget(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.mLocalizations.totalSpent,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const EmptyWidget(height: 5),
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
                              color:
                                  CustomColors.mWhitePrimary.withOpacity(0.1),
                            ),
                          ),
                          const Text(
                            ApplicationConstants.usd,
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
              'uid': uid,
            };
            if (upToInfo['totalSpent'] != null &&
                upToInfo['totalSpent'].isNotEmpty) {
              await FirebaseService().upToPortfolioCoin(upToInfo, uid);
            }
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: CustomColors.mYellow,
                duration: const Duration(milliseconds: 800),
                content: Text(
                  "${widget.selectCoin.symbol.toString().toUpperCase()} ${context.mLocalizations.addedPortfolioCoin}",
                  style: const TextStyle(color: CustomColors.bgcolor),
                )));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.mPurple,
            elevation: 2.5,
            shadowColor: CustomColors.mPurple,
          ),
          child: Text(context.mLocalizations.submit),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  // Converts Widget's
  ConvertsWidget _buildConvertsWidgets() {
    return ConvertsWidget(
      imageUrl: widget.selectCoin.image,
      coinController: coinController,
      balanceController: balanceController,
      onChangedFirst: (value) {
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
      onChangedSec: (value) {
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
    );
  }

  // D,W,M,3M,6M,Y times section part
  Column _timesSectionWidget() {
    return Column(
      children: [
        SizedBox(
          height: 25,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: ApplicationConstants.times.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    timesBool = [false, false, false, false, false, false];
                    timesBool[index] = true;
                  });
                  setDays(ApplicationConstants.times[index]);
                  getChart();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: timesBool[index] == true
                          ? CustomColors.mPurple
                          : CustomColors.mLilacPrimary.withOpacity(0.25),
                    ),
                    child: Text(
                      ApplicationConstants.times[index],
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
}
