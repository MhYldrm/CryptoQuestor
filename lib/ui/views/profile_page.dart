import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_questor/ui/views/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Components/wallet_list.dart';
import '../../widgets/customappbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isMan = true;
  var authService = FirebaseAuth.instance;
  final Uri _mailUrl = Uri(scheme: 'mailto',path: 'mmyildirrimm5@gmail.com');
  final Uri _webUrl = Uri.parse('https://myildirrim.netlify.app');




  List personInfo = [];
  bool? isLoading;
  getInfo(String uid) async {
    var data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get();
    isLoading = true;
    if(data.exists){
      setState(() {
        personInfo.add(data.data() as Map<String,dynamic>);
      });
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    getInfo(authService.currentUser!.uid);
  }


  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.sizeOf(context).width;
    //double height = MediaQuery.sizeOf(context).height;
    return SafeArea(
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: const Color(0xff001E34),
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: CustomAppBar(
                  title: "My Account",
                  icon: Icons.person,
                  iconSize: 33,
                  iconColor: Colors.black)),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _addSizedBox(20),
                _topWidget(),
                _addSizedBox(60),
                _dashboardString(),
                _addSizedBox(20),
                _dashboardListWidget(widht),
                _addSizedBox(40),
                _buyMeCoffeeWidget(),
              ],
            ),
          ),
        ));
  }

  Padding _dashboardListWidget(double widht) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        children: [
          SizedBox(
            height: 200,
            width: widht/1.2,
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    _launchWebUrl();
                  },
                  child: Row(
                    children: [
                      Image.asset("assets/aboutus.png",height: 35,width: 35,fit: BoxFit.fill,color: const Color(0xffFFD400).withOpacity(0.8),),
                      const SizedBox(width: 20,),
                      const Text("About Us",style: TextStyle(fontSize: 20,color: Colors.white),),
                    ],
                  ),
                ),
                _addSizedBox(25),
                InkWell(
                  onTap: (){
                    _launchMailUrl();
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: const Color(0xffFFD400).withOpacity(0.8),
                          child: Image.asset("assets/contactus.png",height: 30,width: 30,fit: BoxFit.fill,color: Colors.black)),
                      const SizedBox(width: 20,),
                      const Text("Contact Us",style: TextStyle(fontSize: 20,color: Colors.white),),
                    ],
                  ),
                ),
                _addSizedBox(25),
                InkWell(
                  onTap: (){
                    authService.signOut().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInPage()));
                    });
                  },
                  child:  Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: const Color(0xffFFD400).withOpacity(0.8),
                          child: const Icon(Icons.logout_outlined,size: 23,color: Colors.black,)),
                      const SizedBox(width: 20,),
                      const Text("Logout",style: TextStyle(fontSize: 20,color: Colors.red),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _buyMeCoffeeWidget() {
    double height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: (){
          showModalBottomSheet(context: context, builder: (BuildContext context){
            return Container(
              height: height/2,
              width: double.infinity,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color:  Color(0xff001E34),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _bottomSheetListWidget(80, 380, "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", "Bitcoin", WalletList().btcAdress,13),
                      _bottomSheetListWidget(80, 380, "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628", "Ethereum", WalletList().ethAdress,12),
                      _bottomSheetListWidget(80, 380, "https://coin-images.coingecko.com/coins/images/4128/large/solana.png?1718769756", "Solana", WalletList().solAdress,11),
                      _bottomSheetListWidget(80, 380, "https://coin-images.coingecko.com/coins/images/17980/large/photo_2024-09-10_17.09.00.jpeg?1725963446", "Ton Chain", WalletList().tonAdress,10),
                      _bottomSheetListWidget(80, 380, "https://coin-images.coingecko.com/coins/images/16547/large/arb.jpg?1721358242", "Arbitrum", WalletList().arbAdress,12),
                      _bottomSheetListWidget(80, 380, "https://coin-images.coingecko.com/coins/images/1094/large/tron-logo.png?1696502193", "Tron Chain", WalletList().trxAdress,13),
                    ],
                  ),
                ),
              ),
            );
          });
        },
        child: SizedBox(
          height: 90,
          width: double.infinity,
          child: Column(
            children: [
              const Text("Do you want support us ?",style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey
              ),),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Image.asset("assets/buymecoffee.png",fit: BoxFit.fill,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _bottomSheetListWidget(double height,double width,String url,String name,String wallet,double fontSize) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: (){
          Clipboard.setData( ClipboardData(text: wallet)).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to your clipboard !')));
          });
        },
        child: Row(
          children: [
            Image.network(url,
              height: 30,
              width: 30,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: 10,),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  Text(wallet,style:  TextStyle(fontSize: fontSize,fontWeight: FontWeight.w300),),
                ],
              ),
            ),
            const SizedBox(width: 10,),
            const Padding(
                padding:  EdgeInsets.only(top: 12),
                child:  Icon(Icons.content_copy,size: 12,color: Colors.grey,)
            ),
          ],
        ),
      ),
    );
  }

  Padding _dashboardString() {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        children: [
          Text("Dashboard",style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.5),
          ),),
        ],
      ),
    );
  }

  Padding _topWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 220,
        width: double.infinity,
        child: isLoading == null
            ?  SizedBox(height: 10,child:  CircularProgressIndicator(color: const Color(0xffFFD400).withOpacity(0.8),))
            : isLoading == false
            ? ListView.builder(
          itemCount: 1,
          itemBuilder: (context,indeks){
            return SizedBox(
              height: 100,
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: isMan == true ? Image.asset("assets/man.png",
                          fit: BoxFit.fill,
                        ) : Image.asset("assets/woman.png",
                          fit: BoxFit.fill,
                        )
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: SizedBox(
                      width: 220,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              personInfo[indeks]['name'],
                              style:
                              personInfo[indeks]['name'].length > 22 ? const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )
                                  : personInfo[indeks]['name'].length > 20 ? const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ) : personInfo[indeks]['name'].length > 17 ? const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ) : const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          Text(
                              personInfo[indeks]['email'],
                              style:
                              personInfo[indeks]['email'].length > 27 ? const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w200,
                              ): personInfo[indeks]['email'].length > 25 ? const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w200,
                              ) : personInfo[indeks]['email'].length > 20 ? const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                              ) : const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 18,),
                  PopupMenuButton(
                    child: Icon(Icons.manage_accounts_rounded,color: const Color(0xffFFD400).withOpacity(0.8),),
                    onSelected: (value){
                      if(value == "Change Gender Picture"){
                        chanceGender();
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: "Change Gender Picture",
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.change_circle_rounded,color: const Color(0xffFFD400).withOpacity(0.8),),
                            ),
                            const Text(
                              'Change Gender Picture',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ) :  const SizedBox(height: 50,child:  CircularProgressIndicator(),),
      ),
    );
  }

  SizedBox _addSizedBox(double height) =>  SizedBox(height: height,);

  void chanceGender (){
    setState(() {
      isMan = !isMan;
    });
  }

  Future<void> _launchMailUrl() async {
    if (!await launchUrl(_mailUrl)) {
      throw Exception('Could not launch $_mailUrl');
    }
  }

  Future<void> _launchWebUrl() async {
    if (!await launchUrl(_webUrl)) {
      throw Exception('Could not launch $_webUrl');}
  }

}
