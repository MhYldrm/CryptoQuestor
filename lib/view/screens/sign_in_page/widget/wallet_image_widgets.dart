import 'package:flutter/material.dart';
import '../../../../core/components/styles/application_constants.dart';

class WalletImageWidgets extends StatelessWidget {
  const WalletImageWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widht/4.5,
      ),
      child: Image.asset(
        ApplicationConstants.walletImagePath,
      fit: BoxFit.fill,
      ),
    );
  }
}
