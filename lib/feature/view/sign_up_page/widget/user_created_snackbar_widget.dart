/// A custom [SnackBar] widget that displays a message when a new user is created.
///
/// This widget extends [SnackBar] and provides a custom message and styling for
/// the snack bar that appears when a new user is successfully created.
/// [context] The context used for localization and navigation
///
part of '../sign_up_page.dart';

class UserCreatedSnackBarWidget extends SnackBar {
  UserCreatedSnackBarWidget({required this.context, super.key})
      : super(
          backgroundColor: ProjectCustomColors.mYellow,
          duration: const Duration(seconds: 2),
          content: Text(
            context.mLocalizations.newUserCreated,
            style: const TextStyle(color: ProjectCustomColors.bgColor),
          ),
        );
  final BuildContext context;
}
