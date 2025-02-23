/// [imageUrl] Get Earn İmage URL
/// [title] Earn Campaign Title Text
/// [mWhitePrimary] White color title text
///
part of '../earn_details_page.dart';

class EarnImagePartWidget extends StatelessWidget {
  const EarnImagePartWidget(
      {required this.title, required this.imageUrl, super.key});

  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            child: Image.network(
          imageUrl,
          width: context.deviceWidht,
          fit: BoxFit.fill,
        )),
        Positioned(
          bottom: 0.1,
          child: Container(
            height: ApplicationSize.size40.value,
            width: context.deviceWidht,
            decoration: ProjectBoxDecorations.earnDetailsPageBoxDecoration,
            child: Padding(
              padding: const ProjectPaddings.verticalSmall(),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.textThemeTitleLarge?.copyWith(
                    color: CustomColors.mWhitePrimary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.1,
          left: 1,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded)),
        ),
      ],
    );
  }
}
