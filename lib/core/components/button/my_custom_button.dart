import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';

import '../styles/custom_colors.dart';

class MyCustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String textName;
  const MyCustomButton({required this.onPressed,required this.textName,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.deviceWidht / 10.5),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.mYellow,
          ),
          child:  Text(
            textName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mPurple),
          ),
        ),
      ),
    );
  }
}
