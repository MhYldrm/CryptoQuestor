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

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              // Shows the password reset dialog when the "Forgot Password" text is tapped.
              _buildShowDialog(context);
            },
            child: Text(
              context.mLocalizations.forgotPassword,
              style: context.textThemeBodyMedium!.copyWith(
                color: CustomColors.mGreyPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Displays a dialog where the user can enter their email for password reset.
  Future<dynamic> _buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.projectTheme!.primaryColor,
        title: Text(
          context.mLocalizations.forgotPassword,
          style: context.textThemeTitleMedium!.copyWith(
            color: context.isDarkMode
                ? CustomColors.mWhitePrimary
                : CustomColors.bgcolor,
          ),
        ),
        content: Container(
          decoration: ProjectBoxDecorations.signPagesBoxDecoration,
          child: TextField(
            controller: _emailController,
            decoration:
                ProjectInputDecorations.signInPageEmailFieldInputDecoration(
                    context),
            keyboardType: TextInputType.emailAddress,
            style: ProjectInputDecorations.signPagesInputDecorationTextStyle(
                context),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(
                  context); // Dismiss the dialog when "Cancel" is pressed
            },
            child: Text(
              context.mLocalizations.cancel,
              style: context.textThemeTitleSmall!.copyWith(
                color: CustomColors.mRedPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Call the method to send password reset email when "Submit" is pressed
              _resetPassword();
            },
            child: Text(
              context.mLocalizations.submit,
              style: context.textThemeTitleSmall!.copyWith(
                color: CustomColors.mGreenPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Sends a password reset email using Firebase Authentication.
  void _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomColors.mYellow,
          content: Text(
            context.mLocalizations.sendResetPasswordEmail,
            style: context.textThemeBodyMedium
                ?.copyWith(color: CustomColors.bgcolor),
          ),
        ),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == ApplicationConstants.userNotFound) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.mLocalizations.noAccountFoundThisEmail),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: ${e.message}'),
          ),
        );
      }
    }
  }
}
