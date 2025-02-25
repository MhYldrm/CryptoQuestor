import 'package:crypto_questor/product/components/styles/project_exports.dart';
import 'package:crypto_questor/product/components/styles/project_sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardContactUsPartWidget extends StatelessWidget {
  const DashboardContactUsPartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchMail(ProjectConstants.myEmail);
      }, // Trigger mail URL launch on tap
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: context.isDarkMode
                ? ProjectCustomColors.mYellow
                : ProjectCustomColors.mPinkPrimary,
            child: Image.asset(
              ProjectConstants.contactUsImagePath,
              height: ProjectSizes.size30.value,
              width: ProjectSizes.size30.value,
              fit: BoxFit.fill,
              color: context.isDarkMode
                  ? ProjectCustomColors.mBlackPrimary
                  : ProjectCustomColors.mWhitePrimary,
            ),
          ),
          SizedBox(
            width: ProjectSizes.size20.value,
          ), // Space between icon and text
          Text(
            context.mLocalizations.contactUs,
            style: context.textThemeTitleMedium?.copyWith(
              color: context.isDarkMode
                  ? ProjectCustomColors.mWhitePrimary
                  : ProjectCustomColors.bgColor,
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
}
