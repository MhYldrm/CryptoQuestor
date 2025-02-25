part of '../splash_page.dart';

class SplashImagesCardWidget extends StatelessWidget {
  const SplashImagesCardWidget({
    required this.imageUrl,
    required this.description,
    super.key,
  });

  final String imageUrl;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.projectTheme!.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: ProjectSizes.size200.value,
            width: ProjectSizes.size300.value,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: ProjectSizes.size80.value,
            width: ProjectSizes.size300.value,
            child: Text(
              description,
              style: GoogleFonts.permanentMarker(
                color: context.isDarkMode
                    ? ProjectCustomColors.mYellow
                    : ProjectCustomColors.bgColor,
                fontSize: ProjectSizes.size20.value,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
