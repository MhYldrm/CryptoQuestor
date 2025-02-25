import 'package:firebase_auth/firebase_auth.dart';

import '../../../../product/components/project_decoration/project_input_decorations.dart';
import '../../../../product/components/styles/project_exports.dart';

mixin ForgotPasswordWidgetMixin {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Displays a dialog where the user can enter their email for password reset.
  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.projectTheme!.primaryColor,
        title: Text(
          context.mLocalizations.forgotPassword,
          style: context.textThemeTitleMedium!.copyWith(
            color: context.isDarkMode
                ? ProjectCustomColors.mWhitePrimary
                : ProjectCustomColors.bgColor,
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
              context,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
              ); // Dismiss the dialog when "Cancel" is pressed
            },
            child: Text(
              context.mLocalizations.cancel,
              style: context.textThemeTitleSmall!.copyWith(
                color: ProjectCustomColors.mRedPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Call the method to send password reset email when "Submit" is pressed
              _resetPassword(context);
            },
            child: Text(
              context.mLocalizations.submit,
              style: context.textThemeTitleSmall!.copyWith(
                color: ProjectCustomColors.mGreenPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Sends a password reset email using Firebase Authentication.
  Future<void> _resetPassword(BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ProjectCustomColors.mYellow,
          content: Text(
            context.mLocalizations.sendResetPasswordEmail,
            style: context.textThemeBodyMedium
                ?.copyWith(color: ProjectCustomColors.bgColor),
          ),
        ),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == ProjectConstants.userNotFound) {
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
