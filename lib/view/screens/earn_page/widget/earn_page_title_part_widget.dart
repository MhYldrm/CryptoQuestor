import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/styles/custom_colors.dart';
import '../../../../core/services/firebase_service.dart';

class EarnPageTitlePartWidget extends StatelessWidget {
  const EarnPageTitlePartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var firebaseService = FirebaseService().firebaseAuth;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                firebaseService.currentUser?.displayName ??
                    firebaseService.currentUser?.email ??
                    context.mLocalizations.cryptoLover,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CustomColors.mGreyPrimary,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                context.mLocalizations.cryptoRewards,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: CustomColors.mWhitePrimary,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
