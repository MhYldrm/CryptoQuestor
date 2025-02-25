/// A mixin that provides utility methods for validating form fields and signing in a user.
///
/// [validateEmail] Validates the email input field. It checks if the email is empty.
/// [validatePassword] Validates the password input field. It checks if the password is empty.
/// [signIn] Handles the sign-in process, including form validation and calling the Firebase sign-in method.
/// If successful, navigates to the intro page; otherwise, shows an error dialog.
///
part of '../sign_in_page.dart';

mixin SignInFormFieldsMixin {
  Future<void> signIn(
    BuildContext context,
    GlobalKey<FormState> formKey,
    UserViewModel userProvider,
  ) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final result = await FirebaseService()
          .signIn(userProvider.user.email, userProvider.user.password,context);

      if (!context.mounted) return;

      if (result == ProjectConstants.success) {
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
