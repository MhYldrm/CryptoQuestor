import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/styles/custom_colors.dart';
import '../../sign_up_page/sign_up_page.dart';

class SignUpLinkWidget extends StatelessWidget {
  final double widht;
  const SignUpLinkWidget({
    required this.widht,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: widht),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.mLocalizations.isNotHaveAccount,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: CustomColors.mGreyPrimary),
          ),
          const SizedBox(width: 10,),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const SignUpPage()));
              },
              child:  Text(
                context.mLocalizations.signUp,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mYellow),
              ))
        ],
      ),
    );
  }
}