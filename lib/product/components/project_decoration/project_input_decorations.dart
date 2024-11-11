import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../styles/custom_colors.dart';

/// A utility class that provides predefined input decorations for various form fields.
/// This ensures consistent styling for text fields across different screens in the app.

class ProjectInputDecorations {
  const ProjectInputDecorations._();

  /// Provides the input decoration for the name field on the sign-up page.
  static InputDecoration signUpPageNameFieldInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
      prefixIcon: const Icon(
        Icons.person_sharp,
        size: 30,
        color: CustomColors.mPurple,
      ),
      hintText: context.mLocalizations.name,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mBlackPrimary),
    );
  }

  /// Provides the input decoration for the password field on the sign-up page.
  static InputDecoration signUpPasswordFieldInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
      prefixIcon: const Icon(
        Icons.key,
        size: 30,
        color: CustomColors.mPurple,
      ),
      hintText: context.mLocalizations.password,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mBlackPrimary),
    );
  }

  /// Provides the input decoration for the email field on the sign-up page.
  static InputDecoration signUpPageEmailFieldInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
      prefixIcon: const Icon(
        Icons.mail_outline_rounded,
        size: 30,
        color: CustomColors.mPurple,
      ),
      hintText: context.mLocalizations.email,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mBlackPrimary),
    );
  }

  /// Provides the text style for input fields on sign-up/sign-in pages.
  static TextStyle? signPagesInputDecorationTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple);
  }

  /// Provides the input decoration for the password field on the sign-in page, with visibility toggle.
  static InputDecoration signInPagePasswordFieldWithVisibilityInputDecoration(
      BuildContext context, bool passwordVisibility, Function togglePasswordVisibility) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
      prefixIcon: const Icon(
        Icons.key,
        size: 30,
        color: CustomColors.mPurple,
      ),
      suffixIcon: IconButton(
        onPressed: () {
          togglePasswordVisibility();
        },
        icon: Icon(
          passwordVisibility ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: CustomColors.mPurple,
        ),
      ),
      hintText: context.mLocalizations.password,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mBlackPrimary),
    );
  }

  /// Provides the input decoration for the email field on the sign-in page.
  static InputDecoration signInPageEmailFieldInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
      prefixIcon: const Icon(
        Icons.mail_outline_rounded,
        size: 30,
        color: CustomColors.mPurple,
      ),
      hintText: context.mLocalizations.email,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mBlackPrimary),
    );
  }
}
