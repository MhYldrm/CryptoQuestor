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
              color: ProjectCustomColors.mGreyPrimary,
            ),
          ),
          // About Us link
          const DashboardAboutUsPartWidget(),
          const EmptyWidget(height: 25),
          // Contact Us link
          const DashboardContactUsPartWidget(),
          const EmptyWidget(height: 25),
          // Change theme option
          const DashboardChangeThemePartWidget(),
          const EmptyWidget(height: 25),
          // Logout option
          const DashboardSignOutPartWidget(),
        ],
      ),
    );
  }
}
