/// [missionsLink] URL to the Missions on Exchange web page
/// [_launchWebUrl] Launch Web Site Func.
///
part of '../earn_details_page.dart';

class EarnButtonWidget extends StatelessWidget {
  const EarnButtonWidget({required this.missionsLink, super.key});
  final String missionsLink;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.bottomMedium(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ProjectCustomButton(
            onPressed: () {
              _launchWebUrl(Uri.parse(missionsLink));
            },
            buttonText: context.mLocalizations.goToMissions,
          ),
        ],
      ),
    );
  }

  Future<void> _launchWebUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
