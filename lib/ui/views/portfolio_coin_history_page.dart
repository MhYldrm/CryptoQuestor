import 'package:crypto_questor/services/firebase_service.dart';
import 'package:crypto_questor/ui/views/intro_page.dart';
import 'package:crypto_questor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/customappbar.dart';

class PortfolioCoinHistoryPage extends StatefulWidget {
  final List<dynamic> coinData;
  PortfolioCoinHistoryPage({required this.coinData});

  @override
  State<PortfolioCoinHistoryPage> createState() => _PortfolioCoinHistoryPageState();
}

class _PortfolioCoinHistoryPageState extends State<PortfolioCoinHistoryPage> {
  @override
  Widget build(BuildContext context) {
    var _firebaseService = FirebaseService();
    var mText = AppLocalizations.of(context)!;
    double widht = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return SafeArea(child: Scaffold(
      backgroundColor: CustomColors.bgcolor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: CustomAppBar(
              title: mText.transactions,
              icon: Icons.pending_actions_rounded,
              iconSize: 30,
              iconColor: CustomColors.mBlackPrimary)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            SizedBox(
              height: height/1.5,
              width: widht,
              child: ListView.builder(
                  itemCount: widget.coinData.length,
                  itemBuilder: (context,index){
                    final coin = widget.coinData[index];
                    return SizedBox(
                      height: 90,
                      width: widht/1.05,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              var snackBar = SnackBar(
                                  backgroundColor: CustomColors.mYellow,
                                  content: Row(
                                children: [
                                  Text(mText.isDeletingTransaction,style: const TextStyle(color: CustomColors.bgcolor),),
                                  const Spacer(),
                                  TextButton(onPressed: (){
                                    _firebaseService.deleteCoinTransaction(coin['uid']);
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const IntroPage()));
                                  }, child: Text(mText.accept,style: const TextStyle(color: CustomColors.mRedPrimary),)),
                                ],
                              ));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: ListTile(
                              leading: Image.network(coin['imageUrl'],height: 40,width: 40,fit: BoxFit.fill,),
                              title: Text("${coin['symbol']}".toUpperCase(),style:
                              TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.mYellow.withOpacity(0.8),
                              ),),
                              subtitle: Text(coin['dateTime'],style:
                              const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: CustomColors.mGreyPrimary
                              ),),
                              trailing: Padding(
                                padding: const EdgeInsets.only(top: 10.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${mText.quantity} ${double.parse(coin['quantity']).toStringAsFixed(3)}",style:
                                    const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700
                                    ),),
                                    Text("${mText.totalSpentForHistory}: ${double.parse(coin['totalSpent']).toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: CustomColors.mGreyPrimary
                                      ),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(thickness: 0.5,color: CustomColors.mGreyPrimary,),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
