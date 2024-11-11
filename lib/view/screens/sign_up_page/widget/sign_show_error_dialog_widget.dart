import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/styles/custom_colors.dart';

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
