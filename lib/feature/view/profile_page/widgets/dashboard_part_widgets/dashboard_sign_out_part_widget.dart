import 'package:crypto_questor/product/components/styles/project_sizes.dart';
import '../../../../../product/components/styles/project_exports.dart';
import '../../../splash_page/splash_page.dart';

class DashboardSignOutPartWidget extends StatelessWidget {
  const DashboardSignOutPartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await FirebaseService().signOut();
        if (context.mounted) {
          context.pushReplacement(const SplashPage());
        }
      }, // Trigger logout on tap
      child: Row(
        children: [
          CircleAvatar(
              backgroundColor: context.isDarkMode
                  ? ProjectCustomColors.mYellow
                  : ProjectCustomColors.mPinkPrimary,
              child: Icon(
                Icons.logout_outlined,
                size: ProjectSizes.small.value,
                color: context.isDarkMode
                    ? ProjectCustomColors.mBlackPrimary
                    : ProjectCustomColors.mWhitePrimary,
              )),
          SizedBox(
              width: ProjectSizes.size20.value), // Space between icon and text
          Text(
            context.mLocalizations.logout,
            style: context.textThemeTitleMedium?.copyWith(
              color: ProjectCustomColors.mPinkPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
