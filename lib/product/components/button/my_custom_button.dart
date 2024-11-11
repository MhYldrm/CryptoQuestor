import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../styles/custom_colors.dart';

/// [onPressed] is the function called when the button is pressed.
/// [buttonText] represents the text displayed on the button.
/// [mYellow] Yellow color button background
/// [mPurple] Purple color button text
class MyCustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  const MyCustomButton(
      {required this.onPressed, required this.buttonText, super.key});

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
                CustomColors.mYellow, // Yellow button background color
          ),
          child: Text(
            buttonText,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: CustomColors.mPurple), // Purple Text color
          ),
        ),
      ),
    );
  }
}
