import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_questor/ui/views/sign_in_page.dart';
import 'package:crypto_questor/utils/colors.dart';
import 'package:crypto_questor/utils/texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/customappbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    var mText = AppLocalizations.of(context)!;
    double widht = MediaQuery.sizeOf(context).width;
    //double height = MediaQuery.sizeOf(context).height;
    return SafeArea(
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: CustomColors.bgcolor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: CustomAppBar(
                  title: mText.myAccount,
                  icon: Icons.person,
                  iconSize: 33,
                  iconColor: CustomColors.mBlackPrimary,)),
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
    var mText = AppLocalizations.of(context)!;
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
                      Image.asset(CustomTexts().aboutUsImagePath,height: 35,width: 35,fit: BoxFit.fill,color: CustomColors.mYellow),
                      const SizedBox(width: 20,),
                       Text(mText.aboutUs,style: const TextStyle(fontSize: 20,color: CustomColors.mWhitePrimary),),
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
                          backgroundColor: CustomColors.mYellow,
                          child: Image.asset(CustomTexts().contactUsImagePath,height: 30,width: 30,fit: BoxFit.fill,color: CustomColors.mBlackPrimary)),
                      const SizedBox(width: 20,),
                       Text(mText.contactUs,style: const TextStyle(fontSize: 20,color: CustomColors.mWhitePrimary),),
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
                      const CircleAvatar(
                          backgroundColor: CustomColors.mYellow,
                          child:  Icon(Icons.logout_outlined,size: 23,color: CustomColors.mBlackPrimary,)),
                      const SizedBox(width: 20,),
                       Text(mText.logout,style: const TextStyle(fontSize: 20,color: CustomColors.mRedPrimary),),
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
    var mText = AppLocalizations.of(context)!;
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
                color: CustomColors.bgcolor,
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
                      _bottomSheetListWidget(80, 380, CustomTexts().bitcoinInfo[0], CustomTexts().bitcoinInfo[1], CustomTexts().bitcoinInfo[2],13),
                      _bottomSheetListWidget(80, 380, CustomTexts().ethInfo[0], CustomTexts().ethInfo[1], CustomTexts().ethInfo[2],12),
                      _bottomSheetListWidget(80, 380, CustomTexts().solInfo[0], CustomTexts().solInfo[1], CustomTexts().solInfo[2],11),
                      _bottomSheetListWidget(80, 380, CustomTexts().tonInfo[0], CustomTexts().tonInfo[1], CustomTexts().tonInfo[2],10),
                      _bottomSheetListWidget(80, 380, CustomTexts().arbInfo[0], CustomTexts().arbInfo[1], CustomTexts().arbInfo[2],12),
                      _bottomSheetListWidget(80, 380, CustomTexts().tronInfo[0], CustomTexts().tronInfo[1], CustomTexts().tronInfo[2],13),
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
               Text(mText.supportUs,style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: CustomColors.mGreyPrimary
              ),),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Image.asset(CustomTexts().buyMeCoffeeImagePath,fit: BoxFit.fill,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _bottomSheetListWidget(double height,double width,String url,String name,String wallet,double fontSize) {
    var mText = AppLocalizations.of(context)!;
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: (){
          Clipboard.setData( ClipboardData(text: wallet)).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                     backgroundColor: CustomColors.mYellow,
                     content: Text(mText.copiedBoard,
                       style: const TextStyle(
                         color: CustomColors.bgcolor,
                         fontWeight: FontWeight.bold
                       ),
                     )));
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
                child:  Icon(Icons.content_copy,size: 12,color: CustomColors.mGreyPrimary)
            ),
          ],
        ),
      ),
    );
  }

  Padding _dashboardString() {
    var mText = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        children: [
          Text(mText.dashboard,style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: CustomColors.mWhitePrimary.withOpacity(0.4),
          ),),
        ],
      ),
    );
  }

  Padding _topWidget() {
    var mText = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 220,
        width: double.infinity,
        child: isLoading == null
            ?  const SizedBox(height: 10,child:  CircularProgressIndicator(color: CustomColors.mYellow))
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
                        child: isMan == true ? Image.asset(CustomTexts().manImagePath,
                          fit: BoxFit.fill,
                        ) : Image.asset(CustomTexts().womanImagePath,
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
                    child: const Icon(Icons.manage_accounts_rounded,color: CustomColors.mYellow),
                    onSelected: (value){
                      if(value == mText.changeGenderImage){
                        chanceGender();
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: mText.changeGenderImage,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.change_circle_rounded,color: CustomColors.mYellow),
                            ),
                             Text(
                               mText.changeGenderImage,
                              style: const TextStyle(fontSize: 15),
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
