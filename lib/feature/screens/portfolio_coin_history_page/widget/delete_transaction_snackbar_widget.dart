import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../../product/services/firebase_service.dart';
import '../../intro_page/intro_page.dart';

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
          backgroundColor: CustomColors.mYellow,
          content: Row(
            children: [
              Text(
                context.mLocalizations.isDeletingTransaction,
                style: const TextStyle(color: CustomColors.bgcolor),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    FirebaseService().deleteCoinTransaction(coinUid);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IntroPage()));
                  },
                  child: Text(
                    context.mLocalizations.accept,
                    style: const TextStyle(color: CustomColors.mRedPrimary),
                  )),
            ],
          ),
        );
}
