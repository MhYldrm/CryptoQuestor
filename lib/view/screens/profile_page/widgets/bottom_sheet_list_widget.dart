import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/components/styles/custom_colors.dart';
import '../../../widgets/padding/project_paddings.dart';

final class BottomSheetListWidget extends StatelessWidget {
  const BottomSheetListWidget(
      {super.key, required this.url, required this.name, required this.walletAddress});

  final String url; // URL for the cryptocurrency logo
  final String name; // Name of the cryptocurrency
  final String walletAddress; // Wallet address to be copied

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
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
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
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.mWhitePrimary),
                    ),
                    Text(
                      walletAddress,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
