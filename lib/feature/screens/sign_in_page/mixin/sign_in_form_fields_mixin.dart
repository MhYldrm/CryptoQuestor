import 'package:crypto_questor/feature/screens/intro_page/intro_page.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/services/firebase_service.dart';
import '../../../view_models/user_view_model.dart';
import '../../sign_up_page/widget/sign_show_error_dialog_widget.dart';

/// A mixin that provides utility methods for validating form fields and signing in a user.
///
/// [validateEmail] Validates the email input field. It checks if the email is empty.
/// [validatePassword] Validates the password input field. It checks if the password is empty.
/// [signIn] Handles the sign-in process, including form validation and calling the Firebase sign-in method.
/// If successful, navigates to the intro page; otherwise, shows an error dialog.
///
mixin SignInFormFieldsMixin {
  String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    return null;
  }

  String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  Future<void> signIn(
    BuildContext context,
    GlobalKey<FormState> formKey,
    UserViewModel userProvider,
  ) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final result = await FirebaseService()
          .signIn(userProvider.user.email, userProvider.user.password);

      if (!context.mounted) return;

      if (result == "success") {
        formKey.currentState!.reset();
        context.push(const IntroPage());
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return SignShowErrorDialogWidget(
              context: context,
              descriptionText: result,
            );
          },
        );
      }
    }
  }
}
