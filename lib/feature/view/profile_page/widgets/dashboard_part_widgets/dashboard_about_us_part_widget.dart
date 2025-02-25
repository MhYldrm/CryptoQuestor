import 'package:crypto_questor/product/components/styles/project_exports.dart';
import 'package:crypto_questor/product/components/styles/project_sizes.dart';
import 'package:url_launcher/url_launcher.dart';


class DashboardAboutUsPartWidget extends StatelessWidget {
  const DashboardAboutUsPartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchWeb(ProjectConstants.myPortfolioLink);
      }, // Trigger web URL launch on tap
      child: Row(
        children: [
          Image.asset(
            ProjectConstants.aboutUsImagePath,
            height: ProjectSizes.size35.value,
            width: ProjectSizes.size35.value,
            fit: BoxFit.fill,
            color: context.isDarkMode
                ? ProjectCustomColors.mYellow
                : ProjectCustomColors.mPinkPrimary,
          ),
          SizedBox(width: ProjectSizes.size20.value), // Space between icon and text
          Text(
            context.mLocalizations.aboutUs,
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

  Future<void> _launchWeb(String url) async {
    final Uri webUrl = Uri.parse(url);
    if (!await launchUrl(webUrl)) {
      throw Exception('Could not launch $webUrl');
    }
  }
}
