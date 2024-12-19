import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../../product/services/firebase_service.dart';
import '../../../widgets/custom_app_bar.dart';
import '../profile_page.dart';

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