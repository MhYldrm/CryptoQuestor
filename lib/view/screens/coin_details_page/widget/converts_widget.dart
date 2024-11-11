import 'package:flutter/material.dart';
import '../../../../core/components/styles/application_constants.dart';
import '../../../../core/components/styles/custom_colors.dart';

/// A custom widget for displaying a conversion interface with two input fields
/// - one for the coin amount and one for the equivalent balance in USD.
/// It includes text fields with a currency icon and a divider separating the fields.
///
/// [imageUrl] - The URL of the image representing the coin. This image is displayed next to the first input field.
/// [coinController] - A [TextEditingController] for managing the input in the first text field (the coin amount).
/// [balanceController] - A [TextEditingController] for managing the input in the second text field (the balance in USD).
/// [onChangedFirst] - A callback function that is called when the value in the first text field (coin amount) changes.
/// [onChangedSec] - A callback function that is called when the value in the second text field (balance in USD) changes.
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 160,
            decoration: BoxDecoration(
              color: CustomColors.mLightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 50,
                    child: TextField(
                      controller: coinController,
                      onChanged: onChangedFirst,
                      keyboardType: TextInputType.number,
                      cursorColor: CustomColors.mPurple,
                      decoration: const InputDecoration(
                        hintMaxLines: 1,
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
                  Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: 70,
            width: 160,
            decoration: BoxDecoration(
              color: CustomColors.mLightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 50,
                    child: TextField(
                      controller: balanceController,
                      onChanged: onChangedSec,
                      keyboardType: TextInputType.number,
                      cursorColor: CustomColors.mPurple,
                      decoration: const InputDecoration(
                        hintMaxLines: 1,
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
                  const Text(
                    ApplicationConstants.usd,
                    style: TextStyle(fontWeight: FontWeight.w300),
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
