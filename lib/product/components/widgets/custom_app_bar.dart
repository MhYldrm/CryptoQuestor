import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';

import '../../../feature/screens/intro_page/intro_page.dart';
import '../styles/custom_colors.dart';


/// A custom AppBar widget used in the app.
/// It consists of a title, an icon, and a back button.
/// [title] The title text to be displayed on the AppBar.
/// [icon] The icon to be displayed beside the title.
/// [iconSize] The size of the icon.
/// [iconColor] The color of the icon.
class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData icon;
  final double iconSize;
  final Color iconColor;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
  });

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
          color: context.projectTheme!.appBarTheme.backgroundColor, // theme'den değiştir
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(top: 23),
        child: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const IntroPage()));
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 26,
              color: CustomColors.bgcolor, // themeden değiştir
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
            const SizedBox(
              width: 30,
            ),
            Text(
              title,
              style: context.textThemeHeadLineSmall?.copyWith(
                color: CustomColors.bgcolor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
