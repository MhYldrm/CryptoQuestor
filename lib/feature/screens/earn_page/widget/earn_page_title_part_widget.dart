/// A widget displaying the title and user information on the Earn Page.
/// It shows the user's display name or email, and the title for the crypto rewards section.
/// [firebaseService] An object to access Firebase Authentication service to fetch the current user's info.
/// [context.mLocalizations] Provides the localized strings for displaying content in the user's preferred language.
/// [CustomColors] Used to style the text with specific colors defined in the custom color palette.
/// [mGreyPrimary] name or email text grey color
/// [mWhitePrimary] crypto reward text white color
///
part of '../earn_page.dart';

class EarnPageTitlePartWidget extends StatelessWidget {
  const EarnPageTitlePartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var firebaseService = FirebaseService().firebaseAuth;
    return Padding(
      padding: const ProjectPaddings.horizontalMedium(),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                firebaseService.currentUser?.displayName ??
                    firebaseService.currentUser?.email ??
                    context.mLocalizations.cryptoLover,
                style: context.textThemeBodyMedium?.copyWith(
                    color: CustomColors.mGreyPrimary,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                context.mLocalizations.cryptoRewards,
                style: context.textThemeTitleMedium?.copyWith(
                    color: context.isDarkMode
                        ? CustomColors.mWhitePrimary
                        : CustomColors.bgcolor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
