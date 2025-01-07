import 'package:crypto_questor/feature/screens/intro_page/intro_page.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../../product/services/firebase_service.dart';

/// Custom SnackBar for deleting a coin transaction.
///
/// This SnackBar is displayed when a user initiates a transaction deletion.
/// It provides a message about the ongoing deletion process, along with an action button to confirm the deletion.
///
/// ### Parameters:
/// - [coinUid] The unique identifier of the transaction to be deleted.
/// - [context] The BuildContext used to retrieve localization and apply styles.
///
/// ### Colors:
/// - [bgcolor] The background color of the SnackBar, set dynamically based on the dark/light theme.
/// - [mRedPrimary] The red color used for the "DELETE" button text when in dark mode.
/// - [mYellow] The yellow color for the background of the SnackBar when in dark mode, or for the text in light mode.
///
class DeleteTransactionCustomSnackBar extends SnackBar {
  final String coinUid; // The UID of the coin transaction to be deleted
  final BuildContext context;

  DeleteTransactionCustomSnackBar(
      {super.key, required this.coinUid, required this.context})
      : super(
          backgroundColor:
              context.isDarkMode ? CustomColors.mYellow : CustomColors.bgcolor,
          content: Row(
            children: [
              // Display message about the ongoing deletion
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
              // Button to confirm the deletion
              TextButton(
                onPressed: () {
                  FirebaseService().deleteCoinTransaction(coinUid);
                  // Navigate to the IntroPage after deletion
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
