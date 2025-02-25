/// A mixin to manage the profile page state.
///  [authService] Firebase authentication service instance.
/// [personInfo] List to hold user information.
/// [isLoading] Loading state for the profile information.
/// [isMan] Indicates whether the user is male.
/// [fetchInfo] Fetches user information from Firebase based on the provided user ID.
/// [chanceGender] Toggles the gender state between male and female.
/// [showCustomAppBar] Displays a custom app bar with a title and an icon.
///
part of '../profile_page.dart';

mixin ProfilePageMixin on State<ProfilePage> {
  final authService = FirebaseAuth.instance;
  List _personInfo = [];
  bool? _isLoading;
  bool _isMan = true;

  Future<void> fetchInfo(String uid) async {
    _isLoading = true;
    var data = await FirebaseService().getInfo(uid);
    setState(() {
      _personInfo = data;
    });
    _isLoading = false;
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
