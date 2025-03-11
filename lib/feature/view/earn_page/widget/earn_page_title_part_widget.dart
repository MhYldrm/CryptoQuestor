/// A widget displaying the title and user information on the Earn Page.
/// It shows the user's display name or email, and the title for the crypto rewards section.
/// [firebaseService] An object to access Firebase Authentication service to fetch the current user's info.
/// [context.mLocalizations] Provides the localized strings for displaying content in the user's preferred language.
/// [ProjectCustomColors] Used to style the text with specific colors defined in the custom color palette.
/// [mGreyPrimary] name or email text grey color
/// [mWhitePrimary] crypto reward text white color
/// [headerNamePart] Assigns a value to the widget that displays the username/email in the header on the Earn Page.
///
part of '../earn_page.dart';

class EarnPageTitlePartWidget extends StatelessWidget {
  const EarnPageTitlePartWidget({required this.headerNamePart, super.key});

  final String headerNamePart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.horizontalMedium(),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                headerNamePart,
                style: context.textThemeBodyMedium?.copyWith(
                  color: ProjectCustomColors.mGreyPrimary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                context.mLocalizations.cryptoRewards,
                style: context.textThemeTitleMedium?.copyWith(
                  color: context.isDarkMode
                      ? ProjectCustomColors.mWhitePrimary
                      : ProjectCustomColors.bgColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
