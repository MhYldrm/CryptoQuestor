import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/core/components/styles/custom_texts.dart';
import 'package:crypto_questor/view/screens/sign_in_page.dart';
import 'package:crypto_questor/view/widgets/empty_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../view/widgets/customappbar.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isMan = true;
  final authService = FirebaseAuth.instance;
  final Uri _mailUrl = Uri(scheme: ApplicationCustomTexts().mailTo,path: ApplicationCustomTexts().myEmail);
  final Uri _webUrl = Uri.parse(ApplicationCustomTexts().myPortfolioLink);

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
    return SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: CustomColors.bgcolor,
          appBar: showCustomAppBar(context),
          body: Column(
            children: [
              EmptyWidget(value: 20),
              Expanded(
                flex: 1,
                child: topInfoWidget(),
              ),
              Expanded(
                flex: 2,
                child: dashboardListWidget(),
              ),
              Expanded(
                flex: 1,
                child: buyMeCoffeeWidget(),
              ),
            ],
          ),
        ));
  }


  // Show custom appbar
  PreferredSize showCustomAppBar(BuildContext context) {
    return PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: CustomAppBar(
                title: context.mLocalizations.myAccount,
                icon: Icons.person,
                iconSize: 33,
                iconColor: CustomColors.mBlackPrimary,));
  }


  // Show dashboard section widget (AboutUs-ContactUs-Logout)
  Padding dashboardListWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.mLocalizations.dashboard,style: Theme.of(context).textTheme.titleLarge?.copyWith(color: CustomColors.mGreyPrimary),
          ),
          EmptyWidget(value: 20),
          InkWell(
            onTap: (){
              _launchWebUrl();
            },
            child: Row(
              children: [
                Image.asset(ApplicationCustomTexts().aboutUsImagePath,height: 35,width: 35,fit: BoxFit.fill,color: CustomColors.mYellow),
                const SizedBox(width: 20,),
                 Text(context.mLocalizations.aboutUs,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mWhitePrimary),),
              ],
            ),
          ),
          EmptyWidget(value: 25),
          InkWell(
            onTap: (){
              _launchMailUrl();
            },
            child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: CustomColors.mYellow,
                    child: Image.asset(ApplicationCustomTexts().contactUsImagePath,height: 30,width: 30,fit: BoxFit.fill,color: CustomColors.mBlackPrimary)),
                const SizedBox(width: 20,),
                 Text(context.mLocalizations.contactUs,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mWhitePrimary),),
              ],
            ),
          ),
          EmptyWidget(value: 25),
          InkWell(
            onTap: (){
              authService.signOut().then((value){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignInPage()));
              });
            },
            child:  Row(
              children: [
                const CircleAvatar(
                    backgroundColor: CustomColors.mYellow,
                    child:  Icon(Icons.logout_outlined,size: 23,color: CustomColors.mBlackPrimary,)),
                const SizedBox(width: 20,),
                 Text(context.mLocalizations.logout,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mRedPrimary),),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // Show Bottom Sheet when pressed -Buy Me Coffee- button
  Padding buyMeCoffeeWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: (){
          showModalBottomSheet(context: context, builder: (BuildContext context){
            return Container(
              height: context.deviceHeight/2,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: CustomColors.bgcolor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    bottomSheetListWidget(ApplicationCustomTexts().bitcoinInfo[0], ApplicationCustomTexts().bitcoinInfo[1], ApplicationCustomTexts().bitcoinInfo[2]),
                    bottomSheetListWidget(ApplicationCustomTexts().ethInfo[0], ApplicationCustomTexts().ethInfo[1], ApplicationCustomTexts().ethInfo[2],),
                    bottomSheetListWidget(ApplicationCustomTexts().solInfo[0], ApplicationCustomTexts().solInfo[1], ApplicationCustomTexts().solInfo[2],),
                    bottomSheetListWidget(ApplicationCustomTexts().tonInfo[0], ApplicationCustomTexts().tonInfo[1], ApplicationCustomTexts().tonInfo[2],),
                    bottomSheetListWidget(ApplicationCustomTexts().arbInfo[0], ApplicationCustomTexts().arbInfo[1], ApplicationCustomTexts().arbInfo[2],),
                    bottomSheetListWidget(ApplicationCustomTexts().tronInfo[0], ApplicationCustomTexts().tronInfo[1], ApplicationCustomTexts().tronInfo[2],),
                  ],
                ),
              ),
            );
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.mLocalizations.supportUs,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: CustomColors.mGreyPrimary)),
            EmptyWidget(value: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.deviceWidht*0.25),
              child: Image.asset(ApplicationCustomTexts().buyMeCoffeeImagePath,fit: BoxFit.fill,),
            ),
          ],
        ),
      ),
    );
  }

  // Shows wallet addresses on the bottom sheet
  Padding bottomSheetListWidget(String url,String name,String wallet) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 10),
      child: SizedBox(
        height: context.deviceHeight*0.07,
        child: InkWell(
          onTap: (){
            Clipboard.setData( ClipboardData(text: wallet)).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                       backgroundColor: CustomColors.mYellow,
                       content: Text(
                         context.mLocalizations.copiedBoard,
                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.bgcolor),
                       ),),);
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10,top: 5),
                  child: Image.network(
                    url,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,color: CustomColors.mWhitePrimary)),
                    Text(wallet,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400,color: CustomColors.mGreyPrimary)),
                  ],
                ),
              ),
              const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Icon(Icons.content_copy,size: 12,color: CustomColors.mGreyPrimary),
                  )),
            ],
          ),
        ),
      ),
    );
  }


  // Show Users Info Section
  Column topInfoWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 140,
          child: isLoading == null
              ?  const CircularProgressIndicator(color: CustomColors.mYellow)
              : isLoading == false
              ? ListView.builder(
            itemCount: 1,
            itemBuilder: (context,indeks){
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: isMan
                            ? Image.asset(ApplicationCustomTexts().manImagePath, fit: BoxFit.fill,)
                            : Image.asset(ApplicationCustomTexts().womanImagePath,fit: BoxFit.fill,),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                              personInfo[indeks]['name'],
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mWhitePrimary),
                          ),
                        ),
                        Text(
                            personInfo[indeks]['email'],
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: CustomColors.mGreyPrimary,fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: PopupMenuButton(
                      child: const Icon(Icons.manage_accounts_rounded,color: CustomColors.mYellow),
                      onSelected: (value){
                        if(value == context.mLocalizations.changeGenderImage){
                          chanceGender();
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: context.mLocalizations.changeGenderImage,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.change_circle_rounded,color: CustomColors.mYellow),
                               Text(
                                 context.mLocalizations.changeGenderImage,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ) :  const Center(child: CircularProgressIndicator(),),
        ),
      ],
    );
  }


  void chanceGender (){
    setState(() {
      isMan = !isMan;
    });
  }

  // Send Mail Func.
  Future<void> _launchMailUrl() async {
    if (!await launchUrl(_mailUrl)) {
      throw Exception('Could not launch $_mailUrl');
    }
  }

  // Launch Web Site Func.
  Future<void> _launchWebUrl() async {
    if (!await launchUrl(_webUrl)) {
      throw Exception('Could not launch $_webUrl');}
  }

}
