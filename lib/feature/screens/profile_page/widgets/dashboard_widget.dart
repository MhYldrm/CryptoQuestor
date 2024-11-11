import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../product/components/padding/project_paddings.dart';
import '../../../../product/components/styles/application_constants.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../../product/services/firebase_service.dart';
import '../../../widgets/empty_widget.dart';
import '../../sign_in_page/sign_in_page.dart';

/// A widget representing the dashboard section of the application.
/// Displays key options like "About Us", "Contact Us", and a logout button.
/// [context] The BuildContext used to get the localizations for the text.
/// It also provides functionality for logging out, launching a web page, and sending emails.
///
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
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: CustomColors.mGreyPrimary),
          ),
          const EmptyWidget(height: 20), // Spacer widget
          // About Us link
          InkWell(
            onTap: (){
              _launchWeb(ApplicationConstants.myPortfolioLink);
            }, // Trigger web URL launch on tap
            child: Row(
              children: [
                Image.asset(
                    ApplicationConstants.aboutUsImagePath,
                    height: 35,
                    width: 35,
                    fit: BoxFit.fill,
                    color: CustomColors.mYellow
                ),
                const SizedBox(width: 20), // Space between icon and text
                Text(
                  context.mLocalizations.aboutUs,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mWhitePrimary),
                ),
              ],
            ),
          ),
          const EmptyWidget(height: 25), // Spacer widget
          InkWell(
            onTap: (){
              _launchMail(ApplicationConstants.myEmail);
            }, // Trigger mail URL launch on tap
            child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: CustomColors.mYellow,
                    child: Image.asset(
                        ApplicationConstants.contactUsImagePath,
                        height: 30,
                        width: 30,
                        fit: BoxFit.fill,
                        color: CustomColors.mBlackPrimary
                    )
                ),
                const SizedBox(width: 20), // Space between icon and text
                Text(
                  context.mLocalizations.contactUs,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mWhitePrimary),
                ),
              ],
            ),
          ),
          const EmptyWidget(height: 25), // Spacer widget

          // Logout option
          InkWell(
            onTap: (){
              FirebaseService().signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInPage()));
              });
            }, // Trigger logout on tap
            child: Row(
              children: [
                const CircleAvatar(
                    backgroundColor: CustomColors.mYellow,
                    child: Icon(
                      Icons.logout_outlined,
                      size: 23,
                      color: CustomColors.mBlackPrimary,
                    )
                ),
                const SizedBox(width: 20), // Space between icon and text
                Text(
                  context.mLocalizations.logout,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mRedPrimary),
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