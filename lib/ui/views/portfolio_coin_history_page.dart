import 'package:crypto_questor/services/firebase_service.dart';
import 'package:crypto_questor/ui/views/intro_page.dart';
import 'package:flutter/material.dart';

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
    double widht = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return SafeArea(child: Scaffold(
      backgroundColor: const Color(0xff001E34),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: CustomAppBar(
              title: "Transactions",
              icon: Icons.pending_actions_rounded,
              iconSize: 30,
              iconColor: Colors.black)),
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
                                  backgroundColor: const Color(0xff001E34),
                                  content: Row(
                                children: [
                                  Text("Did you want DELETE this transaction ?",style: TextStyle(color: Colors.white),),
                                  const Spacer(),
                                  TextButton(onPressed: (){
                                    _firebaseService.deleteCoinTransaction(coin['uid']);
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> IntroPage()));
                                  }, child: Text("Accept",style: TextStyle(color: Colors.red),)),
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
                                color: const Color(0xffFFD400).withOpacity(0.8),
                              ),),
                              subtitle: Text(coin['dateTime'],style:
                              const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey
                              ),),
                              trailing: Padding(
                                padding: const EdgeInsets.only(top: 10.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Quantity: ${double.parse(coin['quantity']).toStringAsFixed(3)}",style:
                                    const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700
                                    ),),
                                    Text("Total Spent: ${double.parse(coin['totalSpent']).toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey
                                      ),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(thickness: 0.5,color: Colors.grey,),
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
