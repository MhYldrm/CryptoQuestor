/// A widget that provides a link to the sign-up page.
///
/// The widget displays a message asking if the user doesn't have an account,
/// and provides a button that navigates to the sign-up page when pressed.
///
/// [widht] The left padding for the widget, defining its horizontal position.
///
part of '../sign_in_page.dart';

class SignUpLinkWidget extends StatelessWidget {
  final double widht;

  const SignUpLinkWidget({
    required this.widht,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widht),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.mLocalizations.isNotHaveAccount,
            style: context.textThemeTitleSmall
                ?.copyWith(color: CustomColors.mGreyPrimary),
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
              },
              child: Text(
                context.mLocalizations.signUp,
                style: context.textThemeTitleMedium?.copyWith(
                  color: context.isDarkMode
                      ? CustomColors.mYellow
                      : CustomColors.mPinkPrimary,
                ),
              ))
        ],
      ),
    );
  }
}
