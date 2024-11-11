import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/view/widgets/padding/project_paddings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/components/button/my_custom_button.dart';

/// [missionsLink] URL to the Missions on Exchange web page
/// [_launchWebUrl] Launch Web Site Func.
///
class EarnButtonWidget extends StatelessWidget {
  const EarnButtonWidget({super.key, required this.missionsLink});
  final String missionsLink;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.bottomMedium(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyCustomButton(
              onPressed: () {
                _launchWebUrl(Uri.parse(missionsLink));
              },
              buttonText: context.mLocalizations.goToMissions),
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
