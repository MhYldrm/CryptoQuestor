/// A widget that handles the Forgot Password feature.
///
/// This widget allows users to reset their password by entering their email address.
/// It displays a dialog where the user can input their email, and a password reset link will be sent if the email is valid.
///
/// ### Components:
/// - **TextField**: A field for the user to input their email address.
/// - **TextButton**: A button to submit the email for password reset. If successful, a confirmation message is displayed.
/// - **AlertDialog**: A dialog box to prompt the user to enter their email address and submit the password reset request.
///
/// ### Firebase Authentication:
/// - The widget utilizes Firebase Authentication to send the password reset email.
///
part of '../sign_in_page.dart';

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({super.key});

  @override
  State<ForgotPasswordWidget> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> with ForgotPasswordWidgetMixin{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.topAndRightMedium(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              // Shows the password reset dialog when the "Forgot Password" text is tapped.
              buildShowDialog(context);
            },
            child: Text(
              context.mLocalizations.forgotPassword,
              style: context.textThemeBodyMedium!.copyWith(
                color: ProjectCustomColors.mGreyPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
