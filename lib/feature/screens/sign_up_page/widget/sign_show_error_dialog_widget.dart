import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/custom_colors.dart';

/// A widget that shows an error dialog with a customizable error message.
///
/// This widget displays an [AlertDialog] with an error title and a description passed
/// through the [descriptionText] argument. It includes a "Try Again" button to close
/// the dialog and allow the user to attempt the action again.
/// [context] The context used for localization and navigation
/// [descriptionText] The error description message to display
///
class SignShowErrorDialogWidget extends StatelessWidget {
  final BuildContext context;
  final String? descriptionText;

  const SignShowErrorDialogWidget({super.key,
    required this.context,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CustomColors.bgcolor,
      title: Text(
        context.mLocalizations.error,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mYellow),
      ),
      content: Text(
        descriptionText!,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.mWhitePrimary),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            context.mLocalizations.tryAgain,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.mYellow),
          ),
        ),
      ],
    );
  }
}