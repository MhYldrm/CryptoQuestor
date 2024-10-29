import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/core/components/styles/my_functions.dart';
import 'package:crypto_questor/view/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import '../../core/models/portfolio_coins_model.dart';
import '../../core/services/coin_services.dart';
import '../widgets/customappbar.dart';
import '../widgets/port_coins_card.dart';


class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {

  List<PortfolioCoinsModel> _allCoinsInPortfolio = [];
  bool _isLoading = true;

 // Gets details of coins in the portfolio from Firebase
  Future<void> _fetchPortfolioCoinsFromFirebase () async{
    _allCoinsInPortfolio =  await CoinService().getPortfolioCoins();
    setState(() {
      _isLoading = false;
    });
  }


  @override
  void initState() {
    super.initState();
    _fetchPortfolioCoinsFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    // Shows the total value of coins in the portfolio
    double totalSpentSum = 0;
    final res = MyFunctions().summarizeCoin(_allCoinsInPortfolio);
    for (var item in res) {
      totalSpentSum += double.parse(item.totalSpent);
    }
    return SafeArea(
        child: Scaffold(
            backgroundColor: CustomColors.bgcolor,
            appBar: buildCustomAppBar(context),
            body: Column(
              children: [
                EmptyWidget(value: 30),
                Expanded(
                  flex: 2,
                  child: _isLoading ? const Center(child: CircularProgressIndicator())
                      :
                      showPortfolioCoinsPart(res)
                ),
                Expanded(
                  flex: 1,
                  child: buildBottomDescription(context, totalSpentSum),
                ),
              ],
            )));
  }


  // Show all coins in portfolio
  ListView showPortfolioCoinsPart(List<PortfolioCoinsModel> res) {
    return ListView.builder(
      itemCount: res.length,
      itemBuilder: (context,index){
        final portfolio = res[index];
        return Padding(
          padding:
          const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: PortCoinsCard(
            imageUrl: portfolio.imageUrl,
            symbol: portfolio.symbol,
            name: portfolio.name,
            quantity: double.parse(portfolio.quantity),
            totalSpent: double.parse(portfolio.totalSpent),
          ),
        );
        },
    );
  }

  // Show Total Spent Part
  Padding buildBottomDescription(BuildContext context, double totalSpentSum) {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                       Text(
                       context.mLocalizations.totalSpent,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mWhitePrimary,fontWeight: FontWeight.w300),
                      ),
                      const Spacer(),
                      Text(
                        " \$ ${totalSpentSum.toStringAsFixed(3)}",
                        overflow: TextOverflow.ellipsis,
                        style:
                        Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mWhitePrimary),
                      ),
                    ],
                  ),
                );
  }

  Center showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color:CustomColors.mYellow,
      ),
    );
  }

  PreferredSize buildCustomAppBar(BuildContext context) {
    return PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: CustomAppBar(
                  title: context.mLocalizations.myPortfolio,
                  icon: Icons.account_balance_wallet_outlined,
                  iconSize: 33,
                  iconColor: Colors.black));
  }
}
