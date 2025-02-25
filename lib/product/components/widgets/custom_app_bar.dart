import 'package:crypto_questor/product/components/styles/project_custom_colors.dart';
import 'package:crypto_questor/product/components/styles/project_sizes.dart';
import 'package:crypto_questor/product/extension/project_extensions.dart';
import 'package:flutter/material.dart';

import '../../../feature/view/intro_page/intro_page.dart';

/// A custom AppBar widget used in the app.
/// It consists of a title, an icon, and a back button.
/// [title] The title text to be displayed on the AppBar.
/// [icon] The icon to be displayed beside the title.
/// [iconSize] The size of the icon.
/// [iconColor] The color of the icon.
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.title,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    super.key,
  });
  final String title;
  final IconData icon;
  final double iconSize;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(90),
      )),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(90),
          ),
          color: context
              .projectTheme!.appBarTheme.backgroundColor, // theme'den değiştir
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(top: 23),
        child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IntroPage()),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 26,
              color: ProjectCustomColors.bgColor, // themeden değiştir
            )),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10),
        child: Row(
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
            SizedBox(
              width: ProjectSizes.size30.value,
            ),
            Text(
              title,
              style: context.textThemeHeadLineSmall?.copyWith(
                color: ProjectCustomColors.bgColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
