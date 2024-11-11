import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/components/styles/custom_colors.dart';

class ProjectInputDecorations{
  const ProjectInputDecorations._();

  static InputDecoration signUpPageNameFieldInputDecoration(BuildContext context){
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
  static InputDecoration signUpPasswordFieldInputDecoration(BuildContext context){
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      errorStyle: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: CustomColors.mPurple),
      prefixIcon: const Icon(
        Icons.key,
        size: 30,
        color: CustomColors.mPurple,
      ),
      hintText: context.mLocalizations.password,
      hintStyle: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: CustomColors.mBlackPrimary),
    );
  }
  static InputDecoration signUpPageEmailFieldInputDecoration(BuildContext context){
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      errorStyle: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: CustomColors.mPurple),
      prefixIcon: const Icon(
        Icons.mail_outline_rounded,
        size: 30,
        color: CustomColors.mPurple,
      ),
      hintText: context.mLocalizations.email,
      hintStyle: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: CustomColors.mBlackPrimary),
    );
  }
  static TextStyle? signPagesInputDecorationTextStyle(BuildContext context){
    return Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(color: CustomColors.mPurple);
  }
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
          passwordVisibility
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: CustomColors.mPurple,
        ),
      ),
      hintText: context.mLocalizations.password,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mBlackPrimary),
    );
  }
  static InputDecoration signInPageEmailFieldInputDecoration(BuildContext context){
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