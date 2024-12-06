import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/padding/project_paddings.dart';
import '../../../../product/components/styles/custom_colors.dart';


/// [totalValue] USD value of the total amount
/// [mWhitePrimary] Displaying the text total spent and total value on the widget in white
///
class TotalSpentDescriptionWidget extends StatelessWidget {
  const TotalSpentDescriptionWidget({required this.totalValue, super.key});

  final double totalValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.horizontalMedium(),
      child: Row(
        children: [
          Text(
            context.mLocalizations.totalSpent,
            style: context.textThemeBodyLarge?.copyWith(color: CustomColors.mWhitePrimary,fontWeight: FontWeight.w300),
          ),
          const Spacer(),
          Text(
            " \$ ${totalValue.toStringAsFixed(3)}",
            overflow: TextOverflow.ellipsis,
            style:
            context.textThemeBodyLarge?.copyWith(color: CustomColors.mWhitePrimary),
          ),
        ],
      ),
    );
  }
}
