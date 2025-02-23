part of '../splash_page.dart';

class SplashImagesCardWidget extends StatelessWidget {
  const SplashImagesCardWidget(
      {super.key, required this.imageUrl, required this.description});

  final String imageUrl;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.projectTheme!.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: ApplicationSize.size200.value,
            width: ApplicationSize.size300.value,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 80,
            width: 300,
            child: Text(description,
                style: GoogleFonts.permanentMarker(
                  color: context.isDarkMode
                      ? CustomColors.mYellow
                      : CustomColors.bgcolor,
                  fontSize: ApplicationSize.size20.value,
                  fontWeight: FontWeight.w100,
                )),
          ),
        ],
      ),
    );
  }
}
