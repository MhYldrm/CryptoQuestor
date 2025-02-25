import 'package:crypto_questor/product/components/styles/project_exports.dart';

import '../../sign_in_page/sign_in_page.dart';

/// A widget that provides a link to the existing account sign-in page.
///
/// This widget is used to display a message indicating that the user already has an account
/// and provides a link to navigate to the sign-in page.
/// [widht] is used to set the padding from the left of the widget.
/// [ProjectCustomColors.mYellow] Yellow color for the login button text
///

class ExistingAccountLinkWidget extends StatelessWidget {
  const ExistingAccountLinkWidget({
    required this.widht,
    super.key,
  });
  final double widht;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widht),
      child: Row(
        children: [
          Text(
            context.mLocalizations.isHaveAccount,
            style: context.textThemeTitleSmall?.copyWith(
              color: ProjectCustomColors.mGreyPrimary,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
            },
            child: Text(
              context.mLocalizations.login,
              style: context.textThemeTitleMedium?.copyWith(
                color: context.isDarkMode
                    ? ProjectCustomColors.mYellow
                    : ProjectCustomColors.mPinkPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
