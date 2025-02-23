library portfolio_page;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:crypto_questor/product/exports/exports.dart';
import '../../../product/components/widgets/change_theme_switch_widget.dart';
import '../../../product/components/widgets/custom_app_bar.dart';
import '../splash_page/splash_page.dart';

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
part 'widgets/bottom_sheet_list_widget.dart';
part 'widgets/buy_me_coffee_widget.dart';
part 'widgets/dashboard_widget.dart';
part 'widgets/user_info_widget.dart';
part 'mixin/profile_page_mixin.dart';

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
              child:
                  BuyMeCoffeeWidget(), // Shows the donation widget for the user to support the app
            ),
          ],
        ),
      ),
    );
  }
}
