/// A widget that represents a list item in a bottom sheet. It displays a cryptocurrency's logo,
/// name, and wallet address. When tapped, it copies the wallet address to the clipboard and shows
/// a snack bar notification confirming the action.
///
/// [url] The URL of the cryptocurrency's logo image.
/// [name] The name of the cryptocurrency.
/// [walletAddress] The cryptocurrency wallet address that can be copied to the clipboard.
///
part of '../profile_page.dart';

final class BottomSheetListWidget extends StatelessWidget {
  const BottomSheetListWidget({
    required this.url,
    required this.name,
    required this.walletAddress,
    super.key,
  });

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
                  backgroundColor: ProjectCustomColors.mYellow,
                  content: Text(
                    context
                        .mLocalizations.copiedBoard, // Localized copied message
                    style: context.textThemeBodyMedium
                        ?.copyWith(color: ProjectCustomColors.bgColor),
                  ),
                ),
              );
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
                        color: context.isDarkMode
                            ? ProjectCustomColors.mWhitePrimary
                            : ProjectCustomColors.bgColor,
                      ),
                    ),
                    Text(
                      walletAddress,
                      overflow: TextOverflow.ellipsis,
                      style: context.textThemeBodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ProjectCustomColors.mGreyPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: ProjectPaddings.topMedium(),
                  child: Icon(
                    Icons.content_copy,
                    size: 11,
                    color: ProjectCustomColors.mGreyPrimary,
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
