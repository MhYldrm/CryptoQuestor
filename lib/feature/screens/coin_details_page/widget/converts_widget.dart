/// A custom widget for displaying a conversion interface with two input fields
/// - one for the coin amount and one for the equivalent balance in USD.
/// It includes text fields with a currency icon and a divider separating the fields.
///
/// [imageUrl] - The URL of the image representing the coin. This image is displayed next to the first input field.
/// [coinController] - A [TextEditingController] for managing the input in the first text field (the coin amount).
/// [balanceController] - A [TextEditingController] for managing the input in the second text field (the balance in USD).
/// [onChangedFirst] - A callback function that is called when the value in the first text field (coin amount) changes.
/// [onChangedSec] - A callback function that is called when the value in the second text field (balance in USD) changes.
///
part of '../coin_details_page.dart';

class ConvertsWidget extends StatelessWidget {
  const ConvertsWidget(
      {super.key,
      required this.imageUrl,
      required this.coinController,
      required this.balanceController,
      required this.onChangedFirst,
      required this.onChangedSec});

  final String imageUrl;
  final TextEditingController coinController;
  final TextEditingController balanceController;
  final void Function(String)? onChangedFirst;
  final void Function(String)? onChangedSec;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.horizontalMedium(),
      child: Row(
        children: [
          Container(
            height: ApplicationSize.size70.value,
            width: ApplicationSize.size160.value,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? CustomColors.mLightGrey
                  : CustomColors.mYellow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const ProjectPaddings.allSmall(),
              child: Row(
                children: [
                  SizedBox(
                    width: ApplicationSize.xxLarge.value,
                    height: ApplicationSize.xxsLarge.value,
                    child: TextField(
                      controller: coinController,
                      onChanged: onChangedFirst,
                      keyboardType: TextInputType.number,
                      cursorColor: CustomColors.mPurple,
                      decoration: const InputDecoration(
                        hintMaxLines: ApplicationConstants.oneNumInt,
                        border: InputBorder.none,
                        hintText: "0.00",
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1.5,
                    color: CustomColors.mGreyPrimary.withOpacity(0.5),
                  ),
                  SizedBox(
                    width: ApplicationSize.xxSmall.value,
                  ),
                  Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                    height: ApplicationSize.size30.value,
                    width: ApplicationSize.size30.value,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: ApplicationSize.size70.value,
            width: ApplicationSize.size160.value,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? CustomColors.mLightGrey
                  : CustomColors.mYellow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const ProjectPaddings.allSmall(),
              child: Row(
                children: [
                  SizedBox(
                    width: ApplicationSize.xxLarge.value,
                    height: ApplicationSize.xxsLarge.value,
                    child: TextField(
                      controller: balanceController,
                      onChanged: onChangedSec,
                      keyboardType: TextInputType.number,
                      cursorColor: CustomColors.mPurple,
                      decoration: const InputDecoration(
                        hintMaxLines: ApplicationConstants.oneNumInt,
                        border: InputBorder.none,
                        hintText: "0.00",
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1.5,
                    color: CustomColors.mGreyPrimary.withOpacity(0.5),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    ApplicationConstants.usd,
                    style: context.textThemeBodyMedium?.copyWith(
                      color: context.isDarkMode
                          ? CustomColors.mWhitePrimary
                          : CustomColors.bgcolor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
