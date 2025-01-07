import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/padding/project_paddings.dart';
import '../../../../product/components/styles/application_constants.dart';
import '../../../../product/components/styles/custom_colors.dart';

/// A widget to display user information, including their name, email, and gender-specific avatar.
/// It also allows users to change the gender image by tapping a menu icon.
/// [isLoading] A boolean that indicates whether the user data is still loading or has been fetched.
/// [isMan] A boolean representing the user's gender (true for male, false for female).
/// [personInfo] A list containing user information such as name and email.
/// [chanceGender] A callback function to change the gender image when the menu option is selected.
///
final class UserInfoWidget extends StatelessWidget {
  final bool? isLoading; // Indicates if the user data is currently loading
  final bool isMan; // Represents the user's gender
  final List<dynamic> personInfo; // Holds user information
  final VoidCallback chanceGender; // Callback to change the gender image

  const UserInfoWidget({
    super.key,
    required this.isLoading,
    required this.isMan,
    required this.personInfo,
    required this.chanceGender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.topMedium(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 140,
            child: isLoading == null
                ? const CircularProgressIndicator(color: CustomColors.mYellow)
                : isLoading == false // Check if loading is complete
                    ? ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: isMan // Display gender-specific image
                                      ? Image.asset(
                                          ApplicationConstants.manImagePath,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
                                          ApplicationConstants.womanImagePath,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        personInfo[index]
                                            ['name'], // Display user's name
                                        overflow: TextOverflow.ellipsis,
                                        style: context.textThemeBodyLarge
                                            ?.copyWith(
                                          color: context.isDarkMode
                                              ? CustomColors.mWhitePrimary
                                              : CustomColors.bgcolor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      personInfo[index]
                                          ['email'], // Display user's email
                                      style: context.textThemeLabelMedium
                                          ?.copyWith(
                                        color: CustomColors.mGreyPrimary,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: PopupMenuButton(
                                  child: Icon(
                                    Icons.manage_accounts_rounded,
                                    color: context.isDarkMode
                                        ? CustomColors.mYellow
                                        : CustomColors.mPinkPrimary,
                                  ),
                                  onSelected: (value) {
                                    if (value ==
                                        context
                                            .mLocalizations.changeGenderImage) {
                                      chanceGender(); // Change gender when selected
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: context
                                          .mLocalizations.changeGenderImage,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.change_circle_rounded,
                                            color: context.isDarkMode
                                                ? CustomColors.mYellow
                                                : CustomColors.mPinkPrimary,
                                          ),
                                          Text(
                                            context.mLocalizations
                                                .changeGenderImage,
                                            style: context.textThemeLabelMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ), // Show loading indicator if still loading
          ),
        ],
      ),
    );
  }
}
