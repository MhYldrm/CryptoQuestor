import 'package:crypto_questor/product/extension/project_extensions.dart';
import 'package:flutter/material.dart';
import '../styles/project_custom_colors.dart';

/// A utility class that provides predefined input decorations for various form fields.
/// This ensures consistent styling for text fields across different screens in the app.
final class ProjectInputDecorations {
  const ProjectInputDecorations._();

  /// Generates the input decoration for the name field on the sign-up page.
  ///
  /// - **context**: The build context to access theme and localization.
  /// - **Returns**: A styled [InputDecoration] for the name field.
  ///
  static InputDecoration signUpPageNameFieldInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ProjectCustomColors.mPurple),
      prefixIcon: const Icon(
        Icons.person_sharp,
        size: 30,
        color: ProjectCustomColors.mPurple,
      ),
      hintText: context.mLocalizations.name,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ProjectCustomColors.mBlackPrimary),
    );
  }

  /// Generates the input decoration for the password field on the sign-up page.
  ///
  /// - **context**: The build context to access theme and localization.
  /// - **Returns**: A styled [InputDecoration] for the password field.
  ///
  static InputDecoration signUpPasswordFieldInputDecoration(
      BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ProjectCustomColors.mPurple),
      prefixIcon: const Icon(
        Icons.key,
        size: 30,
        color: ProjectCustomColors.mPurple,
      ),
      hintText: context.mLocalizations.password,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ProjectCustomColors.mBlackPrimary),
    );
  }

  /// Generates the input decoration for the email field on the sign-up page.
  ///
  /// - **context**: The build context to access theme and localization.
  /// - **Returns**: A styled [InputDecoration] for the email field.
  ///
  static InputDecoration signUpPageEmailFieldInputDecoration(
      BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ProjectCustomColors.mPurple),
      prefixIcon: const Icon(
        Icons.mail_outline_rounded,
        size: 30,
        color: ProjectCustomColors.mPurple,
      ),
      hintText: context.mLocalizations.email,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ProjectCustomColors.mBlackPrimary),
    );
  }

  /// Returns the text style used in input fields for sign-up and sign-in pages.
  ///
  /// - **context**: The build context to access theme settings.
  /// - **Returns**: A [TextStyle] with customized color and size.
  ///
  static TextStyle? signPagesInputDecorationTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(color: ProjectCustomColors.mPurple);
  }

  /// Generates the input decoration for the password field on the sign-in page, including a visibility toggle button.
  ///
  /// - **context**: The build context to access theme and localization.
  /// - **passwordVisibility**: A boolean indicating whether the password is currently visible.
  /// - **togglePasswordVisibility**: A callback function to toggle password visibility.
  /// - **Returns**: A styled [InputDecoration] for the password field with a visibility toggle.
  ///
  static InputDecoration signInPagePasswordFieldWithVisibilityInputDecoration(
      BuildContext context,
      bool passwordVisibility,
      VoidCallback togglePasswordVisibility) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ProjectCustomColors.mPurple),
      prefixIcon: const Icon(
        Icons.key,
        size: 30,
        color: ProjectCustomColors.mPurple,
      ),
      suffixIcon: IconButton(
        onPressed: togglePasswordVisibility,
        icon: Icon(
          passwordVisibility ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: ProjectCustomColors.mPurple,
        ),
      ),
      hintText: context.mLocalizations.password,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ProjectCustomColors.mBlackPrimary),
    );
  }

  /// Generates the input decoration for the email field on the sign-in page.
  ///
  /// - **context**: The build context to access theme and localization.
  /// - **Returns**: A styled [InputDecoration] for the email field.
  ///
  static InputDecoration signInPageEmailFieldInputDecoration(
      BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ProjectCustomColors.mPurple),
      prefixIcon: const Icon(
        Icons.mail_outline_rounded,
        size: 30,
        color: ProjectCustomColors.mPurple,
      ),
      hintText: context.mLocalizations.email,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ProjectCustomColors.mBlackPrimary),
    );
  }
}
