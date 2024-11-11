import 'package:flutter/material.dart';
import '../../../../product/components/styles/application_constants.dart';

class BlockchainImageWidgets extends StatelessWidget {
  const BlockchainImageWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widht/10,
      ),
      child: Image.asset(
        ApplicationConstants.blockchainImagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}