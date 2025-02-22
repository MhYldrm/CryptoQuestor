import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/models/earn_model.dart';
import '../../../widgets/earn_card.dart';
import '../../earn_details_page/earn_details_page.dart';

/// A widget displaying a list of earn projects.
/// It renders each project in an `EarnCard` widget and navigates to the details page when tapped.
/// [earnList] A list of [EarnModel] objects that represent the available earn projects.
/// [EarnCard] Displays the project's image, title, and exchange name.
/// [EarnDetailsPage] Navigates to this page to show detailed information about the selected project.
///
final class EarnsListWidget extends StatelessWidget {
  const EarnsListWidget({super.key, required this.earnList});

  final List<EarnModel> earnList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: earnList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final earns = earnList[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: InkWell(
            onTap: () {
              context.push(
                EarnDetailsPage(earnModel: earns),
              );
            },
            child: EarnCard(
                imageUrl: earns.imageUrl,
                title: earns.title,
                exchangeName: earns.exchangeName),
          ),
        );
      },
    );
  }
}
