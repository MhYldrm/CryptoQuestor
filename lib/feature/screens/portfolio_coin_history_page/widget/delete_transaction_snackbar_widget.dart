import 'package:crypto_questor/feature/screens/intro_page/intro_page.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../../product/services/firebase_service.dart';

/// [coinUid] It stores the UID information of the transaction to be deleted.
/// [context] BuildContext
/// [bgcolor] The Navy Blue color of the delete operation description text.
/// [mRedPrimary] DELETE text Red Color
///
class DeleteTransactionCustomSnackBar extends SnackBar {
  final String coinUid;
  final BuildContext context;

  DeleteTransactionCustomSnackBar(
      {super.key, required this.coinUid, required this.context})
      : super(
          backgroundColor:
              context.isDarkMode ? CustomColors.mYellow : CustomColors.bgcolor,
          content: Row(
            children: [
              Text(
                context.mLocalizations.isDeletingTransaction,
                style: context.textThemeBodyMedium?.copyWith(
                  color: context.isDarkMode
                      ? CustomColors.bgcolor
                      : CustomColors.mGreyPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  FirebaseService().deleteCoinTransaction(coinUid);
                  context.pushReplacement(const IntroPage());
                },
                child: Text(
                  context.mLocalizations.accept,
                  style: context.textThemeBodyMedium?.copyWith(
                    color: context.isDarkMode
                        ? CustomColors.mRedPrimary
                        : CustomColors.mYellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
}
