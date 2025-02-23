/// A widget representing the dashboard section of the application.
/// Displays key options like "About Us", "Contact Us", and a logout button.
/// [context] The BuildContext used to get the localizations for the text.
/// It also provides functionality for logging out, launching a web page, and sending emails.
///
part of '../profile_page.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.leftMedium(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Dashboard title
          Text(
            context.mLocalizations.dashboard,
            style: context.textThemeTitleLarge?.copyWith(
              color: CustomColors.mGreyPrimary,
            ),
          ),
          // About Us link
          InkWell(
            onTap: () {
              _launchWeb(ApplicationConstants.myPortfolioLink);
            }, // Trigger web URL launch on tap
            child: Row(
              children: [
                Image.asset(
                  ApplicationConstants.aboutUsImagePath,
                  height: 35,
                  width: 35,
                  fit: BoxFit.fill,
                  color: context.isDarkMode
                      ? CustomColors.mYellow
                      : CustomColors.mPinkPrimary,
                ),
                const SizedBox(width: 20), // Space between icon and text
                Text(
                  context.mLocalizations.aboutUs,
                  style: context.textThemeTitleMedium?.copyWith(
                    color: context.isDarkMode
                        ? CustomColors.mWhitePrimary
                        : CustomColors.bgcolor,
                  ),
                ),
              ],
            ),
          ),
          const EmptyWidget(height: 25), // Spacer widget
          InkWell(
            onTap: () {
              _launchMail(ApplicationConstants.myEmail);
            }, // Trigger mail URL launch on tap
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: context.isDarkMode
                      ? CustomColors.mYellow
                      : CustomColors.mPinkPrimary,
                  child: Image.asset(
                    ApplicationConstants.contactUsImagePath,
                    height: 30,
                    width: 30,
                    fit: BoxFit.fill,
                    color: context.isDarkMode
                        ? CustomColors.mBlackPrimary
                        : CustomColors.mWhitePrimary,
                  ),
                ),
                const SizedBox(width: 20), // Space between icon and text
                Text(
                  context.mLocalizations.contactUs,
                  style: context.textThemeTitleMedium?.copyWith(
                    color: context.isDarkMode
                        ? CustomColors.mWhitePrimary
                        : CustomColors.bgcolor,
                  ),
                ),
              ],
            ),
          ),
          const EmptyWidget(height: 25), // Spacer widget
          // Logout option
          Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: context.isDarkMode
                        ? CustomColors.mYellow
                        : CustomColors.mPinkPrimary,
                    child: Icon(
                      context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      size: 23,
                      color: context.isDarkMode
                          ? CustomColors.mBlackPrimary
                          : CustomColors.mWhitePrimary,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ), // Space between icon and text
                  Text(
                    context.isDarkMode
                        ? context.mLocalizations.changeThemeToLightMode
                        : context.mLocalizations.changeThemeToDarkMode,
                    style: context.textThemeTitleMedium?.copyWith(
                      color: context.isDarkMode
                          ? CustomColors.mWhitePrimary
                          : CustomColors.bgcolor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              ChangeThemeSwitchWidget(
                isDarkTheme: context.isDarkMode,
              ),
            ],
          ),
          const EmptyWidget(height: 25),
          InkWell(
            onTap: () async {
              await FirebaseService().signOut();
              if (context.mounted) {
                context.pushReplacement(const SplashPage());
              }
            }, // Trigger logout on tap
            child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: context.isDarkMode
                        ? CustomColors.mYellow
                        : CustomColors.mPinkPrimary,
                    child: Icon(
                      Icons.logout_outlined,
                      size: 23,
                      color: context.isDarkMode
                          ? CustomColors.mBlackPrimary
                          : CustomColors.mWhitePrimary,
                    )),
                const SizedBox(width: 20), // Space between icon and text
                Text(
                  context.mLocalizations.logout,
                  style: context.textThemeTitleMedium?.copyWith(
                    color: CustomColors.mPinkPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchMail(String email) async {
    final Uri mailUrl = Uri(scheme: 'mailto', path: email);
    if (!await launchUrl(mailUrl)) {
      throw Exception('Could not launch $mailUrl');
    }
  }

  Future<void> _launchWeb(String url) async {
    final Uri webUrl = Uri.parse(url);
    if (!await launchUrl(webUrl)) {
      throw Exception('Could not launch $webUrl');
    }
  }
}
