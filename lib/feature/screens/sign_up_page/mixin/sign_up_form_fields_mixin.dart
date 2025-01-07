import 'package:crypto_questor/feature/screens/sign_in_page/sign_in_page.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../providers/user_provider.dart';
import '../../../../product/services/firebase_service.dart';
import '../widget/sign_show_error_dialog_widget.dart';
import '../widget/user_created_snackbar_widget.dart';

/// A mixin for managing form validation and user sign-up process.
///
/// This mixin provides utility methods for validating form fields such as name,
/// email, and password, and also handles the sign-up process by interacting with
/// the Firebase authentication and Fire store service.
/// [validateEmail] Validates the email input field. It checks if the email is empty.
/// [validateName] Validates the name input field. It checks if the name is empty.
/// [validatePassword] Validates the password input field. It checks if the password is empty.
/// [signUp] Handles the sign-up process, including form validation and calling the Firebase sign-up method.
/// If successful, navigates to the sign in page; otherwise, shows an error dialog.
///
mixin SignUpFormFieldsMixin {
  String? validateName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

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

  Future<void> signUp(
    BuildContext context,
    GlobalKey<FormState> formKey,
    UserProvider userProvider,
  ) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var result = await FirebaseService().signUp(
        userProvider.user.name,
        userProvider.user.email,
        userProvider.user.password,
      );

      if (!context.mounted) return;

      if (result == "success") {
        formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          UserCreatedSnackBarWidget(context: context),
        );
        context.push(const SignInPage());
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
