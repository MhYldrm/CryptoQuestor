import 'package:crypto_questor/view/screens/intro_page/intro_page.dart';
import 'package:flutter/material.dart';
import '../../home_page/home_page.dart';

/// A mixin to manage the state of the [IntroPage] widget.
/// This mixin is used to handle the state of the bottom navigation and
/// manage the currently selected tab and screen on the [IntroPage].
///
/// [currentTab] - The index of the currently selected tab in the bottom navigation bar. It is used to track which tab is active and should be visually highlighted.
/// [bucket] - A [PageStorageBucket] instance used to store and restore the state of the current screen when the user navigates between different tabs in the [IntroPage].
/// [currentScreen] - The widget that represents the current screen being displayed. This screen will be swapped depending on the active tab in the bottom navigation.
///
mixin IntroPageMixin on State<IntroPage> {
  // current page tab
  int currentTab = 0;

  // Page Tab Controller
  final PageStorageBucket bucket = PageStorageBucket();

  // Current Screen
  Widget currentScreen = const HomePage();
}
