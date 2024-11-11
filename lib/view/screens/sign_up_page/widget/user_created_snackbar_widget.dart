import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/styles/custom_colors.dart';

class UserCreatedSnackBarWidget extends SnackBar {
  final BuildContext context;

  UserCreatedSnackBarWidget(
      {super.key,required this.context})
      : super(
          backgroundColor: CustomColors.mYellow,
          duration: const Duration(seconds: 2),
          content: Text(
            context.mLocalizations.newUserCreated,
            style: const TextStyle(color: CustomColors.bgcolor),
          ),
        );
}
