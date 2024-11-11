import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/view/screens/profile_page/widgets/bottom_sheet_list_widget.dart';
import 'package:crypto_questor/view/widgets/padding/project_paddings.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/styles/application_constants.dart';
import '../../../../core/components/styles/custom_colors.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/project_decoration/project_box_decorations.dart';

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
                decoration: ProjectBoxDecorations.profilePageBoxDecoration,
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
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: CustomColors.mGreyPrimary),
            ),
            EmptyWidget(height: 10), // Spacer widget
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
