import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/padding/project_paddings.dart';
import '../../../../product/components/project_decoration/project_box_decorations.dart';
import '../../../../product/components/styles/application_constants.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../widgets/empty_widget.dart';
import 'bottom_sheet_list_widget.dart';

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
                  itemCount:
                      ApplicationConstants.buyMeCoffeeWalletAddress.length,
                  itemBuilder: (context, index) {
                    var list =
                        ApplicationConstants.buyMeCoffeeWalletAddress[index];
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
            // Support message
            Text(
              context.mLocalizations.supportUs,
              style: context.textThemeBodyLarge!
                  .copyWith(color: CustomColors.mGreyPrimary),
            ),
            const EmptyWidget(height: 10), // Spacer widget
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.deviceWidht * 0.25),
              child: Image.asset(
                ApplicationConstants.buyMeCoffeeImagePath,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
