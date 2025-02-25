/// [descriptionTexts] Earn Campaign Description Texts
/// [mPinkPrimary] Description Title Texts Pink Color
/// [mWhitePrimary] Description Texts White Color
///
part of '../earn_details_page.dart';

class EarnDescriptionPartWidget extends StatelessWidget {
  const EarnDescriptionPartWidget({required this.descriptionTexts, super.key});

  final String descriptionTexts;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const ProjectPaddings.horizontalSmall(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.mLocalizations.description,
              style: context.textThemeTitleLarge
                  ?.copyWith(color: ProjectCustomColors.mPinkPrimary),
            ),
            Text(
              descriptionTexts,
              style: context.textThemeBodyMedium?.copyWith(
                color: context.isDarkMode
                    ? ProjectCustomColors.mWhitePrimary
                    : ProjectCustomColors.bgColor,
                fontWeight: FontWeight.w300,
              ),
              maxLines: 16,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
