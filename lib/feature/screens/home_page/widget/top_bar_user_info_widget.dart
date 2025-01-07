import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../../product/services/firebase_service.dart';

/// [TopBarUserInfo] is a stateless widget that displays user information
/// such as a greeting message and the user's display name or email address in the app's top bar.
///
/// ### Key Responsibilities:
/// - Fetches user information from Firebase Authentication.
/// - Displays a personalized greeting message with the user's name or email.
/// - Provides a default message when no user information is available.
///
/// ### UI Details:
/// - Shows a "Welcome" message.
/// - Displays the user's name or email in bold text below the greeting message.
/// - If no user is signed in, it falls back to a generic message like "Crypto Lover."
///
/// ### Usage:
/// Include this widget in the app's top bar to provide a personalized user experience.
///
/// ### Firebase Integration:
/// - Uses [FirebaseAuth] from [FirebaseService] to retrieve the current user's information.
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
              // Greeting text
              Text(
                context.mLocalizations.welcome,
                style: TextStyle(
                  fontSize: 17,
                  color: context.isDarkMode
                      ? CustomColors.mGreyPrimary
                      : CustomColors.bgcolor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 5),

              // User display name or fallback text
              Text(
                firebaseService.currentUser?.displayName ??
                    firebaseService.currentUser?.email ??
                    context.mLocalizations.cryptoLover,
                style: TextStyle(
                  fontSize: 15,
                  color: context.isDarkMode
                      ? CustomColors.mGreyPrimary
                      : CustomColors.bgcolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
