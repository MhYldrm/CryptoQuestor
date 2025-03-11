/// A widget to display user information, including their name, email, and gender-specific avatar.
/// It also allows users to change the gender image by tapping a menu icon.
/// [isLoading] A boolean that indicates whether the user data is still loading or has been fetched.
/// [isMan] A boolean representing the user's gender (true for male, false for female).
/// [ userInfoProvider.profileInfoList] A list containing user information such as name and email.
/// [chanceGender] A callback function to change the gender image when the menu option is selected.
///
part of '../profile_page.dart';

final class UsersInfoWidget extends StatelessWidget {
  const UsersInfoWidget({
    required this.isMan,
    required this.chanceGender,
    super.key});

  final bool isMan; // Represents the user's gender
  final VoidCallback chanceGender;

  @override
  Widget build(BuildContext context) {
    final userInfoProvider =  Provider.of<ProfileInfoViewModel>(context);
    return Consumer(
      builder: (BuildContext context, value, Widget? child) {
        return Padding(
          padding: const ProjectPaddings.topMedium(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 140,
                child: userInfoProvider.isLoading == false // Check if loading is complete
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
                              ProjectConstants.manImagePath,
                              fit: BoxFit.fill,
                            )
                                : Image.asset(
                              ProjectConstants.womanImagePath,
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
                                  userInfoProvider.profileInfoList[index]
                                  ['name'], // Display user's name
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textThemeBodyLarge
                                      ?.copyWith(
                                    color: context.isDarkMode
                                        ? ProjectCustomColors
                                        .mWhitePrimary
                                        : ProjectCustomColors.bgColor,
                                  ),
                                ),
                              ),
                              Text(
                                userInfoProvider.profileInfoList[index]
                                ['email'], // Display user's email
                                style: context.textThemeLabelMedium
                                    ?.copyWith(
                                  color: ProjectCustomColors.mGreyPrimary,
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
                                  ? ProjectCustomColors.mYellow
                                  : ProjectCustomColors.mPinkPrimary,
                            ),
                            onSelected: (value) {
                              if (value == context.mLocalizations.changeGenderImage){
                                chanceGender(); // Change gender when selected
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: context.mLocalizations.changeGenderImage,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.change_circle_rounded,
                                      color: context.isDarkMode
                                          ? ProjectCustomColors.mYellow
                                          : ProjectCustomColors.mPinkPrimary,
                                    ),
                                    Text(
                                      context.mLocalizations.changeGenderImage,
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
      },
    );
  }
}
