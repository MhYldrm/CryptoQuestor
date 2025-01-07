import 'package:crypto_questor/feature/screens/profile_page/widgets/buy_me_coffee_widget.dart';
import 'package:crypto_questor/feature/screens/profile_page/widgets/dashboard_widget.dart';
import 'package:crypto_questor/feature/screens/profile_page/widgets/user_info_widget.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'mixin/profile_page_mixin.dart';

/// A page that displays the user's profile information and dashboard.
///
/// The profile page includes various sections such as:
/// - User information (e.g., gender, personal details)
/// - A dashboard with app-related data and features
/// - A "Buy Me Coffee" widget that lets users donate to support the app.
///
/// ### Widgets:
/// - [UserInfoWidget] Displays user-specific information such as name, gender, etc.
/// - [DashboardWidget] Displays relevant metrics or app-related data.
/// - [BuyMeCoffeeWidget] Provides a way for users to donate or support the app.
///
/// ### Initialization:
/// - On initialization, the `fetchInfo` method is called to load the user's information using their UID.
///

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ProfilePageMixin {
  @override
  void initState() {
    super.initState();
    // Fetch user info based on the user's UID when the page is loaded
    fetchInfo(authService.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: context.projectTheme!.primaryColor,
        appBar: showCustomAppBar(context),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: UserInfoWidget(
                // Displays user information
                isLoading: isLoading,
                isMan: isMan,
                personInfo: personInfo,
                chanceGender: chanceGender,
              ),
            ),
            const Expanded(
              flex: 4,
              child: DashboardWidget(),
            ),
            const Expanded(
              flex: 2,
              child: BuyMeCoffeeWidget(), // Shows the donation widget for the user to support the app
            ),
          ],
        ),
      ),
    );
  }
}
