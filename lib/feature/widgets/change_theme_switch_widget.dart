import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../product/components/styles/custom_colors.dart';
import '../view_models/project_theme_view_model.dart';

/// [ChangeThemeSwitchWidget] is a widget that allows the user to toggle between dark and light themes.
///
/// ### Key Responsibilities:
/// - Displays a toggle switch that lets the user switch between dark and light themes.
/// - The toggle changes colors and icons based on the selected theme.
/// - Changes the theme of the application when toggled by calling the [ProjectThemeProvider]'s `changeTheme` method.
///
/// ### Widgets:
/// - [AnimatedToggleSwitch] provides the interactive toggle switch with animations for a smooth transition between the themes.
/// - [Icon] switches between the dark mode icon (moon) and light mode icon (sun), depending on the selected theme.

final class ChangeThemeSwitchWidget extends StatelessWidget {
  const ChangeThemeSwitchWidget({super.key, required this.isDarkTheme});

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
        // When the toggle switch changes, it triggers the theme change.
        Provider.of<ProjectThemeViewModel>(context, listen: false).changeTheme();
      },
    );
  }
}

