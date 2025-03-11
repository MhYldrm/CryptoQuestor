/// A mixin to manage the profile page state.
///  [authService] Firebase authentication service instance.
/// [isMan] Indicates whether the user is male.
/// [chanceGender] Toggles the gender state between male and female.
/// [showCustomAppBar] Displays a custom app bar with a title and an icon.
///
part of '../profile_page.dart';

mixin ProfilePageMixin on State<ProfilePage> {
  final authService = FirebaseAuth.instance;
  bool _isMan = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProfileInfoViewModel>().getUserInfo(authService.currentUser!.uid);
    });
  }

  void chanceGender() {
    setState(() {
      _isMan = !_isMan;
    });
  }

  PreferredSize showCustomAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: CustomAppBar(
        title: context.mLocalizations.myAccount,
        icon: Icons.person,
        iconSize: 33,
        iconColor: ProjectCustomColors.mBlackPrimary,
      ),
    );
  }
}
