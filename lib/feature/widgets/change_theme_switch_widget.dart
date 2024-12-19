import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../product/components/styles/custom_colors.dart';
import '../../product/components/theme/theme_provider.dart';

final class ChangeThemeSwitchWidget extends StatelessWidget {
  const ChangeThemeSwitchWidget({super.key,required this.isDarkTheme});

  final bool isDarkTheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.dual(
      current: isDarkTheme,
      spacing: 10,
      first: true,
      second: false,
      styleBuilder: (isDarkTheme) => ToggleStyle(
        indicatorColor: isDarkTheme ? Colors.black : Colors.yellow,
        backgroundColor: isDarkTheme
            ? CustomColors.mBlackPrimary
            : CustomColors.mYellow,
      ),
      iconBuilder: (isDarkTheme) => isDarkTheme
          ? const Icon(
        Icons.dark_mode,
        color: Colors.white,
        size: 30,
      )
          : const Icon(
        Icons.light_mode,
        color: Colors.pink,
        size: 30,
      ),
      onChanged: (value) {
        Provider.of<ThemeProvider>(context, listen: false)
            .changeTheme();
      },
    );
  }
}
