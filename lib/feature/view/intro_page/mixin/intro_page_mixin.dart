/// A mixin to manage the state of the [IntroPage] widget.
/// This mixin is used to handle the state of the bottom navigation and
/// manage the currently selected tab and screen on the [IntroPage].
///
/// [_currentTab] - The index of the currently selected tab in the bottom navigation bar. It is used to track which tab is active and should be visually highlighted.
/// [_bucket] - A [PageStorageBucket] instance used to store and restore the state of the current screen when the user navigates between different tabs in the [IntroPage].
/// [_currentScreen] - The widget that represents the current screen being displayed. This screen will be swapped depending on the active tab in the bottom navigation.
///
part of '../intro_page.dart';

mixin IntroPageMixin on State<IntroPage> {
  // current page tab
  int _currentTab = ProjectConstants.zeroNumInt;

  // Page Tab Controller
  final PageStorageBucket _bucket = PageStorageBucket();

  // Current Screen
  Widget _currentScreen = const HomePage();
}
