/// A widget that provides a link to the sign-up page.
///
/// The widget displays a message asking if the user doesn't have an account,
/// and provides a button that navigates to the sign-up page when pressed.
///
/// [widht] The left padding for the widget, defining its horizontal position.
///
part of '../sign_in_page.dart';

class SignUpLinkWidget extends StatelessWidget {
  const SignUpLinkWidget({
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
            context.mLocalizations.isNotHaveAccount,
            style: context.textThemeTitleSmall
                ?.copyWith(color: ProjectCustomColors.mGreyPrimary),
          ),
          SizedBox(
            width: ProjectSizes.size10.value,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpPage(),
                ),
              );
            },
            child: Text(
              context.mLocalizations.signUp,
              style: context.textThemeTitleMedium?.copyWith(
                color: context.isDarkMode
                    ? ProjectCustomColors.mYellow
                    : ProjectCustomColors.mPinkPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
