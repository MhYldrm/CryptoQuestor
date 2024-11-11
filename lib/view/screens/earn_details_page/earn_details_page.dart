import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/view/screens/earn_details_page/widget/earn_button_widget.dart';
import 'package:crypto_questor/view/screens/earn_details_page/widget/earn_description_part_widget.dart';
import 'package:crypto_questor/view/screens/earn_details_page/widget/earn_image_part_widget.dart';
import 'package:crypto_questor/view/screens/earn_details_page/widget/market_details_part_widget.dart';
import 'package:crypto_questor/view/screens/earn_details_page/widget/earn_missions_part_widget.dart';
import 'package:flutter/material.dart';
import '../../../core/models/earn_model.dart';

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
            child: EarnImagePartWidget(
              title: widget.earnModel.title,
              imageUrl: widget.earnModel.imageUrl,
            ),
          ),
          Expanded(
            flex: 1,
            child: MarketDetailsPartWidget(
              exchangeName: widget.earnModel.exchangeName,
              exchangeIconUrl: widget.earnModel.exchangeIconUrl,
              dateTime: widget.earnModel.dateTime,
            ),
          ),
          Expanded(
            flex: 1,
            child: EarnDescriptionPartWidget(
              descriptionTexts: widget.earnModel.description,
            ),
          ),
          const Divider(thickness: 1, color: CustomColors.mLightYellow),
          Expanded(
            flex: 3,
            child: EarnMissionsPartWidget(
              refLink: widget.earnModel.refLink,
              missionsText: widget.earnModel.missions,
            ),
          ),
          Expanded(
            flex: 1,
            child: EarnButtonWidget(
              missionsLink: widget.earnModel.missionsLink,
            ),
          ),
        ],
      ),
    ));
  }
}
