import 'package:flutter/material.dart';
import '../../../../core/models/user_provider.dart';
import '../../../../core/services/firebase_service.dart';
import '../../sign_in_page/sign_in_page.dart';
import '../widget/sign_show_error_dialog_widget.dart';
import '../widget/user_created_snackbar_widget.dart';

mixin FormFieldsMixin {
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInPage()),
        );
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
