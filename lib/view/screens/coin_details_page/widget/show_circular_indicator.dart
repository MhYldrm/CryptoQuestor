import 'package:flutter/material.dart';
import '../../../../core/components/styles/custom_colors.dart';

class ShowCircularIndicator extends StatelessWidget {
  const ShowCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 250,
      child: Center(
        child: CircularProgressIndicator(
          color: CustomColors.mLilacPrimary,
        ),
      ),
    );
  }
}
