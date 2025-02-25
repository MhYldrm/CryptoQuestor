/// [TopBarUserInfo] is a stateless widget that displays user information
/// such as a greeting message and the user's display name or email address in the app's top bar.
///
/// ### Key Responsibilities:
/// - Fetches user information from Firebase Authentication.
/// - Displays a personalized greeting message with the user's name or email.
/// - Provides a default message when no user information is available.
///
/// ### UI Details:
/// - Shows a "Welcome" message.
/// - Displays the user's name or email in bold text below the greeting message.
/// - If no user is signed in, it falls back to a generic message like "Crypto Lover."
///
/// ### Usage:
/// Include this widget in the app's top bar to provide a personalized user experience.
///
/// ### Firebase Integration:
/// - Uses [FirebaseAuth] from [FirebaseService] to retrieve the current user's information.
///
part of '../home_page.dart';

final class TopBarUserInfo extends StatelessWidget {
  const TopBarUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseService().firebaseAuth;

    return Padding(
      padding: const ProjectPaddings.horizontalAndVerticalMedium(),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting text
              Text(
                context.mLocalizations.welcome,
                style: TextStyle(
                  fontSize: ProjectSizes.xSmall.value,
                  color: context.isDarkMode
                      ? ProjectCustomColors.mGreyPrimary
                      : ProjectCustomColors.bgColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: ProjectSizes.xxSmall.value),

              // User display name or fallback text
              Text(
                firebaseService.currentUser?.displayName ??
                    firebaseService.currentUser?.email ??
                    context.mLocalizations.cryptoLover,
                style: TextStyle(
                  fontSize: ProjectSizes.xSmall.value,
                  color: context.isDarkMode
                      ? ProjectCustomColors.mGreyPrimary
                      : ProjectCustomColors.bgColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
