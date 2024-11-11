import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/services/firebase_service.dart';
import 'package:crypto_questor/view/widgets/padding/project_paddings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/components/styles/application_constants.dart';
import '../../../../core/components/styles/custom_colors.dart';
import '../../../widgets/empty_widget.dart';
import '../../sign_in_page/sign_in_page.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.leftMedium(), // Apply medium padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
        mainAxisAlignment: MainAxisAlignment.center, // Center the column vertically
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
