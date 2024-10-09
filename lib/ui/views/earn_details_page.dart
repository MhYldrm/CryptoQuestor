import 'package:crypto_questor/utils/colors.dart';
import 'package:crypto_questor/utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/earn_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EarnDetailsPage extends StatefulWidget {
  final EarnModel earnModel;

  const EarnDetailsPage({Key? key, required this.earnModel}) : super(key: key);

  @override
  State<EarnDetailsPage> createState() => _EarnDetailsPageState();
}

class _EarnDetailsPageState extends State<EarnDetailsPage> {

  Future<void> _launchWebUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');}
  }


  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.sizeOf(context).height;
    double myWidth = MediaQuery.sizeOf(context).width;
    var mText = AppLocalizations.of(context)!;
    return SafeArea(
        child: Scaffold(
          backgroundColor: CustomColors.bgcolor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    height: myHeight / 3.5,
                    width: myWidth,
                    child: Stack(
                      children: [
                        Positioned(
                            child: Image.network(
                              widget.earnModel.imageUrl,
                              width: myWidth,
                              fit: BoxFit.fill,
                            )),
                        Positioned(
                          bottom: 0.1,
                          child: Container(
                            height: 40,
                            width: myWidth,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              color: Colors.transparent.withOpacity(0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                widget.earnModel.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 22,
                                    color: CustomColors.mWhitePrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0.1,
                          left: 1,
                          child: IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: const Icon(Icons.arrow_back_rounded)),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: Container(
                    height: 40,
                    width: myWidth,
                    child: Row(
                      children: [
                        Row(
                          children: [
                             const Icon(
                              Icons.location_pin,
                              size: 17,
                              color: CustomColors.mYellow,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 40,
                              width: 140,
                              decoration:  BoxDecoration(
                                  color: CustomColors.mWhitePrimary.withOpacity(0.2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Image.network(
                                  widget.earnModel.exchangeIconUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            if(
                            CustomTexts().exchangeList.contains(widget.earnModel.exchangeName))
                              const Text("")else Text(
                              widget.earnModel.exchangeName,
                              style: const TextStyle(
                                  color: CustomColors.mWhitePrimary,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range_rounded,
                              size: 15,
                              color: CustomColors.mYellow,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.earnModel.dateTime,
                              style: const TextStyle(
                                  color: CustomColors.mWhitePrimary,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: myHeight / 5.5,
                  width: myWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Row(
                            children: [
                              Text(
                                mText.description,
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.mPinkPrimary),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 1, right: 20, left: 20),
                          child: SizedBox(
                            height: 225,
                            width: myWidth,
                            child: Text(
                              widget.earnModel.description,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300,color: CustomColors.mWhitePrimary),
                              maxLines: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                    thickness: 1, color: CustomColors.mLightYellow),
                Container(
                  height: myHeight / 4,
                  width: myWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(top: 5, left: 15),
                          child: Row(
                            children: [
                              Text(
                                mText.missions,
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.mPinkPrimary),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 1, right: 20, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(
                                  mText.missionsDescription,
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w300,color: CustomColors.mWhitePrimary),
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchWebUrl(Uri.parse(widget.earnModel.refLink));
                                  },
                                  child:  Text(
                                    mText.here,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: CustomColors.mYellow,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 1, right: 20, left: 20),
                          child: SizedBox(
                            width: myWidth,
                            child: Text(
                              widget.earnModel.missions,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300,color: CustomColors.mWhitePrimary),
                              maxLines: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SizedBox(
                    height: 50,
                    width: myWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        _launchWebUrl(Uri.parse(widget.earnModel.missionsLink));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.mYellow,
                          elevation: 5,
                          shadowColor: Colors.red),
                      child:  Text(
                       mText.goToMissions,
                        style: TextStyle(color: CustomColors.mPinkPrimary.withOpacity(0.9), fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
