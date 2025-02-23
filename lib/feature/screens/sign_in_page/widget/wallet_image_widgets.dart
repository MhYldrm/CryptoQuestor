/// A widget that displays a wallet image centered with a responsive padding.
///
/// The widget ensures the image is responsive by adjusting its horizontal padding
/// based on the screen width. The image is displayed using a specified asset path
/// for the wallet image.
///
part of '../sign_in_page.dart';

class WalletImageWidgets extends StatelessWidget {
  const WalletImageWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widht / 4.5,
      ),
      child: Image.asset(
        ApplicationConstants.walletImagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}
