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
part of '../sign_up_page.dart';

mixin SignUpFormFieldsMixin {
  Future<void> signUp(
    BuildContext context,
    GlobalKey<FormState> formKey,
    UserViewModel userProvider,
  ) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var result = await FirebaseService().signUp(
        userProvider.user.name,
        userProvider.user.email,
        userProvider.user.password,
        context,
      );

      if (!context.mounted) return;

      if (result == ProjectConstants.success) {
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
