import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/services/firebase_service.dart';
import 'package:crypto_questor/view/screens/profile_page/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/styles/custom_colors.dart';
import '../../../widgets/custom_app_bar.dart';

/// A mixin to manage the profile page state.
///  [authService] Firebase authentication service instance.
/// [personInfo] List to hold user information.
/// [isLoading] Loading state for the profile information.
/// [isMan] Indicates whether the user is male.
/// [fetchInfo] Fetches user information from Firebase based on the provided user ID.
/// [chanceGender] Toggles the gender state between male and female.
/// [showCustomAppBar] Displays a custom app bar with a title and an icon.
///
mixin ProfilePageMixin on State<ProfilePage> {
  final authService = FirebaseAuth.instance;
  List personInfo = [];
  bool? isLoading;
  bool isMan = true;

  Future<void> fetchInfo(String uid) async {
    isLoading = true;
    var data = await FirebaseService().getInfo(uid);
    setState(() {
      personInfo = data;
    });
    isLoading = false;
  }

  void chanceGender() {
    setState(() {
      isMan = !isMan;
    });
  }

  PreferredSize showCustomAppBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: CustomAppBar(
          title: context.mLocalizations.myAccount,
          icon: Icons.person,
          iconSize: 33,
          iconColor: CustomColors.mBlackPrimary,
        ));
  }
}
