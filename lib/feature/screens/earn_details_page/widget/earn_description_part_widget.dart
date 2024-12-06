import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/custom_colors.dart';

/// [descriptionTexts] Earn Campaign Description Texts
/// [mPinkPrimary] Description Title Texts Pink Color
/// [mWhitePrimary] Description Texts White Color
///
class EarnDescriptionPartWidget extends StatelessWidget {
  const EarnDescriptionPartWidget({super.key, required this.descriptionTexts});

  final String descriptionTexts;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.mLocalizations.description,
              style: context.textThemeTitleLarge
                  ?.copyWith(color: CustomColors.mPinkPrimary),
            ),
            Text(
              descriptionTexts,
              style: context.textThemeBodyMedium?.copyWith(
                  color: CustomColors.mWhitePrimary,
                  fontWeight: FontWeight.w300),
              maxLines: 16,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}