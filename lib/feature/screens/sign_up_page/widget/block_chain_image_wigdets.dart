part of '../sign_up_page.dart';

class BlockchainImageWidgets extends StatelessWidget {
  const BlockchainImageWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widht / 10,
      ),
      child: Image.asset(
        ApplicationConstants.blockchainImagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}
