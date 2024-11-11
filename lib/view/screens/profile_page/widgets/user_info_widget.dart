import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/view/widgets/padding/project_paddings.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/styles/custom_colors.dart';
import '../../../../core/components/styles/application_constants.dart';

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
            child: isLoading == null // Check if loading state is null
                ? const CircularProgressIndicator(
                    color: CustomColors.mYellow) // Show loading indicator
                : isLoading == false // Check if loading is complete
                    ? ListView.builder(
                        itemCount: 1, // Display one user info card
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                color:
                                                    CustomColors.mWhitePrimary),
                                      ),
                                    ),
                                    Text(
                                      personInfo[index]
                                          ['email'], // Display user's email
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
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
                                  child: const Icon(
                                      Icons.manage_accounts_rounded,
                                      color: CustomColors
                                          .mYellow), // Icon for managing accounts
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
                                          const Icon(
                                              Icons.change_circle_rounded,
                                              color: CustomColors.mYellow),
                                          Text(
                                            context.mLocalizations
                                                .changeGenderImage,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
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
                        child:
                            CircularProgressIndicator()), // Show loading indicator if still loading
          ),
        ],
      ),
    );
  }
}
