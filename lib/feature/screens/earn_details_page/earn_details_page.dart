import 'package:crypto_questor/feature/screens/earn_details_page/widget/earn_button_widget.dart';
import 'package:crypto_questor/feature/screens/earn_details_page/widget/earn_description_part_widget.dart';
import 'package:crypto_questor/feature/screens/earn_details_page/widget/earn_image_part_widget.dart';
import 'package:crypto_questor/feature/screens/earn_details_page/widget/earn_missions_part_widget.dart';
import 'package:crypto_questor/feature/screens/earn_details_page/widget/market_details_part_widget.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../product/components/styles/custom_colors.dart';
import '../../../product/models/earn_model.dart';

/// [EarnDetailsPage] is a stateful widget that displays the details of an earning opportunity.
///
/// Key Responsibilities:
/// - Displays an image and title of the earning opportunity.
/// - Shows exchange information and date details.
/// - Provides a detailed description of the opportunity.
/// - Lists missions and a referral link for the earning process.
/// - Includes a button to take action or access related missions.
final class EarnDetailsPage extends StatefulWidget {
  /// [earnModel] contains the details of the earning opportunity, such as the title,
  /// image URL, description, missions, and related links.
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
        backgroundColor: context.projectTheme!.primaryColor,
        body: Column(
          children: [
            // Image and Title Section
            Expanded(
              flex: 3,
              child: EarnImagePartWidget(
                title: widget.earnModel.title,
                imageUrl: widget.earnModel.imageUrl,
              ),
            ),
            // Exchange Details Section
            Expanded(
              flex: 1,
              child: MarketDetailsPartWidget(
                exchangeName: widget.earnModel.exchangeName,
                exchangeIconUrl: widget.earnModel.exchangeIconUrl,
                dateTime: widget.earnModel.dateTime,
              ),
            ),
            // Description Section
            Expanded(
              flex: 1,
              child: EarnDescriptionPartWidget(
                descriptionTexts: widget.earnModel.description,
              ),
            ),
            const Divider(thickness: 1, color: CustomColors.mLightYellow),
            // Missions Section
            Expanded(
              flex: 3,
              child: EarnMissionsPartWidget(
                refLink: widget.earnModel.refLink,
                missionsText: widget.earnModel.missions,
              ),
            ),
            // Action Button Section
            Expanded(
              flex: 1,
              child: EarnButtonWidget(
                missionsLink: widget.earnModel.missionsLink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
