library coin_details_page;

import 'package:crypto_questor/feature/screens/add_portfolio_page/add_portfolio_page.dart';
import 'package:crypto_questor/feature/screens/coin_details_page/widget/show_error_widget.dart';
import 'package:crypto_questor/product/components/styles/application_constants.dart';
import 'package:crypto_questor/product/components/styles/application_size.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:crypto_questor/product/exports/exports.dart';
import '../../../product/models/chart_model.dart';
import '../intro_page/intro_page.dart';
import 'package:http/http.dart' as http;

part 'widget/chart_widget.dart';
part 'widget/coin_low_high_description_widget.dart';
part 'widget/coin_title_price_part_widget.dart';
part 'widget/converts_widget.dart';
part 'widget/show_circular_indicator.dart';
part 'mixin/coin_details_page_mixin.dart';

final class CoinDetailPage extends StatefulWidget {
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
            backgroundColor: context.projectTheme!.primaryColor,
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
                        marketCapChangePercentage24H:
                            widget.selectCoin.marketCapChangePercentage24H,
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
                          context.push(
                            AddPortfolioPage(
                              selectCoin: widget.selectCoin,
                            ),
                          );
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
                      color: context.isDarkMode
                          ? timesBool[index] == true
                              ? CustomColors.mPurple
                              : CustomColors.mLilacPrimary.withOpacity(0.25)
                          : timesBool[index] == true
                              ? CustomColors.mYellow
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
