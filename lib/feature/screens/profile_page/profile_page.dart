import 'package:crypto_questor/feature/screens/profile_page/widgets/buy_me_coffee_widget.dart';
import 'package:crypto_questor/feature/screens/profile_page/widgets/dashboard_widget.dart';
import 'package:crypto_questor/feature/screens/profile_page/widgets/user_info_widget.dart';
import 'package:flutter/material.dart';
import '../../../product/components/styles/custom_colors.dart';
import 'mixin/profile_page_mixin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ProfilePageMixin {
  @override
  void initState() {
    super.initState();
    fetchInfo(authService.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: CustomColors.bgcolor,
        appBar: showCustomAppBar(context),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: UserInfoWidget(
                // Show Users Info Section
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
              child: BuyMeCoffeeWidget(), // Show Bottom Sheet when pressed -Buy Me Coffee- button
            ),
          ],
        ),
      ),
    );
  }
}
