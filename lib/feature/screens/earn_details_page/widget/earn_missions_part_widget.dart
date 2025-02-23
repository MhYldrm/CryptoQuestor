/// [refLink] URL to the Missions on Exchange web page
/// [missionsText] Earn Campaign Missions Texts
/// [mPinkPrimary] Missions Title Texts Pink Color
/// [mWhitePrimary] Missions Texts White Color
/// [_launchWebUrl] Launch Web Site Func.
///
part of '../earn_details_page.dart';

class EarnMissionsPartWidget extends StatelessWidget {
  const EarnMissionsPartWidget(
      {super.key, required this.refLink, required this.missionsText});

  final String refLink;
  final String missionsText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const ProjectPaddings.horizontalSmall(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.mLocalizations.missions,
              style: context.textThemeTitleLarge?.copyWith(
                color: CustomColors.mPinkPrimary,
              ),
            ),
            Text(
              context.mLocalizations.missionsDescription,
              style: context.textThemeBodyMedium?.copyWith(
                color: context.isDarkMode
                    ? CustomColors.mWhitePrimary
                    : CustomColors.bgcolor,
              ),
            ),
            InkWell(
              onTap: () {
                _launchWebUrl(Uri.parse(refLink));
              },
              child: Text(
                context.mLocalizations.here,
                style: context.textThemeBodyMedium?.copyWith(
                  color: CustomColors.mYellow,
                ),
              ),
            ),
            Text(
              missionsText,
              style: context.textThemeBodyMedium?.copyWith(
                color: context.isDarkMode
                    ? CustomColors.mWhitePrimary
                    : CustomColors.bgcolor,
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

  Future<void> _launchWebUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
