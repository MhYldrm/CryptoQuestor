import 'package:crypto_questor/core/components/button/my_custom_button.dart';
import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/core/components/styles/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/models/earn_model.dart';


class EarnDetailsPage extends StatefulWidget {
  final EarnModel earnModel;
  const EarnDetailsPage({super.key, required this.earnModel});

  @override
  State<EarnDetailsPage> createState() => _EarnDetailsPageState();
}

class _EarnDetailsPageState extends State<EarnDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: CustomColors.bgcolor,
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: showTopImage(context),
              ),
              Expanded(
                flex: 1,
                child: showMarketDetails(),
              ),
              Expanded(
                flex: 1,
                child: showDescriptionPart(),
              ),
              const Divider(
                  thickness: 1, color: CustomColors.mLightYellow),
              Expanded(
                flex: 3,
                child: showMissionsPart(),
              ),
              Expanded(
                flex: 1,
                child: showGoToMissionsButton(context),
              ),
            ],
          ),
        ));
  }


  // Campaign Image
  Padding showTopImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Stack(
        children: [
          Positioned(
              child: Image.network(
                widget.earnModel.imageUrl,
                width: context.deviceWidht,
                fit: BoxFit.fill,
              )),
          Positioned(
            bottom: 0.1,
            child: Container(
              height: 40,
              width: context.deviceWidht,
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
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: CustomColors.mWhitePrimary,fontWeight: FontWeight.bold),
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
    );
  }

  // Validity date of the Campaign and exchange name part
  Padding showMarketDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.location_pin,
                  size: 17,
                  color: CustomColors.mYellow,
                ),
                Container(
                  decoration:  BoxDecoration(
                    color: CustomColors.mWhitePrimary.withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: SizedBox(
                      height: 50,
                      width: 130,
                      child: Image.network(
                        widget.earnModel.exchangeIconUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                ApplicationCustomTexts().exchangeList.contains(widget.earnModel.exchangeName)
                    ? const Text("")
                    : Text(
                  widget.earnModel.exchangeName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mWhitePrimary),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.date_range_rounded,
                  size: 15,
                  color: CustomColors.mYellow,
                ),
                Text(
                  widget.earnModel.dateTime,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mWhitePrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Campaign Missions Details Part
  SingleChildScrollView showMissionsPart() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.mLocalizations.missions,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: CustomColors.mPinkPrimary),
            ),
            Text(
              context.mLocalizations.missionsDescription,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.mWhitePrimary),
            ),
            InkWell(
              onTap: () {
                _launchWebUrl(Uri.parse(widget.earnModel.refLink));
              },
              child:  Text(
                context.mLocalizations.here,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.mYellow),
              ),
            ),
            Text(
              widget.earnModel.missions,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.mWhitePrimary,fontWeight: FontWeight.w300),
              maxLines: 16,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Earn Missions Description Part
  SingleChildScrollView showDescriptionPart() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.mLocalizations.description,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: CustomColors.mPinkPrimary),
            ),
            Text(
              widget.earnModel.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.mWhitePrimary,fontWeight: FontWeight.w300),
              maxLines: 16,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Launch Campaign Missions link button
  Padding showGoToMissionsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyCustomButton(
              onPressed: () {
                _launchWebUrl(Uri.parse(widget.earnModel.missionsLink));
                },
              textName: context.mLocalizations.goToMissions),
        ],
      ),
    );
  }

  // Launch Web Site Func.
  Future<void> _launchWebUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');}
  }
}
