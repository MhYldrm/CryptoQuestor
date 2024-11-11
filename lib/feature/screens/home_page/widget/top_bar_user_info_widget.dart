import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../../product/services/firebase_service.dart';


/// A widget that displays user information in the top bar of the app.
///
/// This widget is responsible for showing a greeting message and the user's display name or email address
/// in the top bar. If the user is not signed in, a default message will be shown.
///
/// [firebaseService] - The Firebase service used to retrieve the current user's information.
///
final class TopBarUserInfo extends StatelessWidget {
  const TopBarUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseService().firebaseAuth;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.mLocalizations.welcome,
                style: const TextStyle(
                    fontSize: 17,
                    color: CustomColors.mGreyPrimary,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                firebaseService.currentUser?.displayName ??
                    firebaseService.currentUser?.email ??
                    context.mLocalizations.cryptoLover,
                style: const TextStyle(
                    fontSize: 15,
                    color: CustomColors.mWhitePrimary,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
