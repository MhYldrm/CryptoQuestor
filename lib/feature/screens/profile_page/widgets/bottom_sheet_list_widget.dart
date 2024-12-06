import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../product/components/padding/project_paddings.dart';
import '../../../../product/components/styles/custom_colors.dart';


/// A widget that represents a list item in a bottom sheet. It displays a cryptocurrency's logo,
/// name, and wallet address. When tapped, it copies the wallet address to the clipboard and shows
/// a snack bar notification confirming the action.
///
/// [url] The URL of the cryptocurrency's logo image.
/// [name] The name of the cryptocurrency.
/// [walletAddress] The cryptocurrency wallet address that can be copied to the clipboard.
///
final class BottomSheetListWidget extends StatelessWidget {
  const BottomSheetListWidget(
      {super.key, required this.url, required this.name, required this.walletAddress});

  final String url;
  final String name;
  final String walletAddress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.topAndLeftSmall(),
      child: SizedBox(
        height: context.deviceHeight * 0.07,
        child: InkWell(
          onTap: () {
            // Copy the wallet address to the clipboard when tapped
            Clipboard.setData(ClipboardData(text: walletAddress)).then((_) {
              // Show a snack bar notification after wallet address copying
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: CustomColors.mYellow,
                  content: Text(
                    context
                        .mLocalizations.copiedBoard, // Localized copied message
                    style: context.textThemeBodyMedium
                        ?.copyWith(color: CustomColors.bgcolor),
                  ),
                ),
              );
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const ProjectPaddings.topAndRightSmall(),
                  child: Image.network(
                    url, // Load image from network
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: context.textThemeBodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.mWhitePrimary),
                    ),
                    Text(
                      walletAddress,
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeBodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: CustomColors.mGreyPrimary),
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: Padding(
                  padding: ProjectPaddings.topMedium(),
                  child: Icon(
                    Icons.content_copy,
                    size: 12,
                    color: CustomColors.mGreyPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}