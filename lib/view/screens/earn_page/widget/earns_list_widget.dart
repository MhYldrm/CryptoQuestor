import 'package:flutter/material.dart';
import '../../../../core/models/earn_model.dart';
import '../../../widgets/earn_card.dart';
import '../../earn_details_page/earn_details_page.dart';


class EarnsListWidget extends StatelessWidget {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EarnDetailsPage(earnModel: earns)));
                },
                child: EarnCard(
                    imageUrl: earns.imageUrl,
                    title: earns.title,
                    exchangeName: earns.exchangeName),
              ));
        });
  }
}
