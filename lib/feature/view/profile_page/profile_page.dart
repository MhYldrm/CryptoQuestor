library portfolio_page;

import 'package:crypto_questor/feature/view/profile_page/widgets/dashboard_part_widgets/dashboard_about_us_part_widget.dart';
import 'package:crypto_questor/feature/view/profile_page/widgets/dashboard_part_widgets/dashboard_change_theme_part_widget.dart';
import 'package:crypto_questor/feature/view/profile_page/widgets/dashboard_part_widgets/dashboard_contact_us_part_widget.dart';
import 'package:crypto_questor/feature/view/profile_page/widgets/dashboard_part_widgets/dashboard_sign_out_part_widget.dart';
import 'package:crypto_questor/feature/view_models/profile_info_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:crypto_questor/product/components/styles/project_exports.dart';
import 'package:provider/provider.dart';
import '../../../product/components/widgets/custom_app_bar.dart';

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
part 'mixin/profile_page_mixin.dart';
part 'widgets/users_info_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ProfilePageMixin {
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
              child: UsersInfoWidget(isMan: _isMan, chanceGender: chanceGender),
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
