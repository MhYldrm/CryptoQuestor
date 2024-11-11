import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/styles/custom_colors.dart';
import '../../sign_in_page/sign_in_page.dart';

class ExistingAccountLinkWidget extends StatelessWidget {
  final double widht;
  const ExistingAccountLinkWidget({
    required this.widht,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: widht),
      child: Row(
        children: [
          Text(
            context.mLocalizations.isHaveAccount,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: CustomColors.mGreyPrimary),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const SignInPage()));
              },
              child: Text(
                context.mLocalizations.login,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mYellow,fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}