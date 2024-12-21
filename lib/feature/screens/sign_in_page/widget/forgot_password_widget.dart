import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/project_decoration/project_box_decorations.dart';
import '../../../../product/components/project_decoration/project_input_decorations.dart';
import '../../../../product/components/styles/custom_colors.dart';

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
              Navigator.pop(context);
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
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No account found for this email address.'),
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
