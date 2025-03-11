/// A widget that allows users to support the app via donations.
///
/// The widget displays a "Buy Me Coffee" section, which when tapped,
/// opens a modal bottom sheet with a list of wallet addresses for donations.
///
/// ### Components:
/// - Displays a support message and an image button prompting users to donate.
/// - Tapping the widget opens a bottom sheet with a list of wallet addresses to support the app.
///
/// ### Functionality:
/// - [showModalBottomSheet] When tapped, the widget opens a bottom sheet displaying wallet addresses.
///

part of '../profile_page.dart';

final class BuyMeCoffeeWidget extends StatefulWidget {
  const BuyMeCoffeeWidget({super.key});

  @override
  State<BuyMeCoffeeWidget> createState() => _BuyMeCoffeeWidgetState();
}

class _BuyMeCoffeeWidgetState extends State<BuyMeCoffeeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.horizontalSmall(),
      child: InkWell(
        onTap: () {
          // Show the bottom sheet when tapped
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: context.deviceHeight / 2,
                decoration: context.isDarkMode
                    ? ProjectBoxDecorations.profilePageDarkThemeBoxDecoration
                    : ProjectBoxDecorations.profilePageLightThemeBoxDecoration,
                child: ListView.builder(
                  // Item count is based on the length of wallet addresses
                  itemCount: ProjectConstants.buyMeCoffeeWalletAddress.length,
                  itemBuilder: (context, index) {
                    var list = ProjectConstants.buyMeCoffeeWalletAddress[index];
                    // List items are displayed using BottomSheetListWidget
                    return BottomSheetListWidget(
                      url: list[0],
                      name: list[1],
                      walletAddress: list[2],
                    );
                  },
                ),
              );
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Support message displayed on the widget
            Text(
              context.mLocalizations.supportUs,
              style: context.textThemeBodyLarge!.copyWith(
                color: ProjectCustomColors.mGreyPrimary,
              ), // Grey text color for the support message
            ),
            const EmptyWidget(height: 10), // Spacer between text and image
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.deviceWidht * 0.25),
              child: Image.asset(
                ProjectConstants.buyMeCoffeeImagePath, // Image for the "Buy Me Coffee" button
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
