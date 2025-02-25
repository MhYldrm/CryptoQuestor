import 'package:crypto_questor/product/extension/project_extensions.dart';
import 'package:flutter/material.dart';
import '../styles/project_custom_colors.dart';

/// [onPressed] is the function called when the button is pressed.
/// [buttonText] represents the text displayed on the button.
/// [mYellow] Yellow color button background
/// [mPurple] Purple color button text
class ProjectCustomButton extends StatelessWidget {
  const ProjectCustomButton({
    required this.onPressed,
    required this.buttonText,
    super.key,
  });
  final VoidCallback? onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.deviceWidht * 0.1),
      child: SizedBox(
        height: context.deviceHeight * 0.05,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                ProjectCustomColors.mYellow, // Yellow button background color
          ),
          child: Text(
            buttonText,
            style: context.textThemeTitleMedium?.copyWith(
              color: ProjectCustomColors.mPurple,
            ), // Purple Text color
          ),
        ),
      ),
    );
  }
}
