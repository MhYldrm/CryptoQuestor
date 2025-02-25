import 'package:crypto_questor/product/components/styles/project_sizes.dart';

import '../../../../../product/components/styles/project_exports.dart';
import '../../../../../product/components/widgets/change_theme_switch_widget.dart';

class DashboardChangeThemePartWidget extends StatelessWidget {
  const DashboardChangeThemePartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: context.isDarkMode
                  ? ProjectCustomColors.mYellow
                  : ProjectCustomColors.mPinkPrimary,
              child: Icon(
                context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                size: ProjectSizes.small.value,
                color: context.isDarkMode
                    ? ProjectCustomColors.mBlackPrimary
                    : ProjectCustomColors.mWhitePrimary,
              ),
            ),
            SizedBox(
              width: ProjectSizes.size20.value,
            ), // Space between icon and text
            Text(
              context.isDarkMode
                  ? context.mLocalizations.changeThemeToLightMode
                  : context.mLocalizations.changeThemeToDarkMode,
              style: context.textThemeTitleMedium?.copyWith(
                color: context.isDarkMode
                    ? ProjectCustomColors.mWhitePrimary
                    : ProjectCustomColors.bgColor,
              ),
            ),
          ],
        ),
        SizedBox(
          width: ProjectSizes.size20.value,
        ),
        ChangeThemeSwitchWidget(
          isDarkTheme: context.isDarkMode,
        ),
      ],
    );
  }
}
