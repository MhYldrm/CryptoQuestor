import 'package:crypto_questor/product/components/styles/project_custom_colors.dart';
import 'package:crypto_questor/product/extension/project_extensions.dart';
import 'package:flutter/material.dart';

/// A widget that shows an error dialog with a customizable error message.
///
/// This widget displays an [AlertDialog] with an error title and a description passed
/// through the [descriptionText] argument. It includes a "Try Again" button to close
/// the dialog and allow the user to attempt the action again.
/// [context] The context used for localization and navigation
/// [descriptionText] The error description message to display
///
class SignShowErrorDialogWidget extends StatelessWidget {
  const SignShowErrorDialogWidget({
    required this.context,
    required this.descriptionText,
    super.key,
  });
  final BuildContext context;
  final String? descriptionText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ProjectCustomColors.bgColor,
      title: Text(
        context.mLocalizations.error,
        style: context.textThemeTitleMedium?.copyWith(color: ProjectCustomColors.mYellow),),
      content: Text(
        descriptionText!,
        style: context.textThemeBodyMedium?.copyWith(color: ProjectCustomColors.mWhitePrimary),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            context.mLocalizations.tryAgain,
            style: context.textThemeBodyMedium?.copyWith(color: ProjectCustomColors.mYellow),
          ),
        ),
      ],
    );
  }
}
