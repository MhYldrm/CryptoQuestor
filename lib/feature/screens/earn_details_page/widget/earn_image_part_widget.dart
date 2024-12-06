import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/padding/project_paddings.dart';
import '../../../../product/components/project_decoration/project_box_decorations.dart';
import '../../../../product/components/styles/custom_colors.dart';

/// [imageUrl] Get Earn İmage URL
/// [title] Earn Campaign Title Text
/// [mWhitePrimary] White color title text
///
class EarnImagePartWidget extends StatelessWidget {
  const EarnImagePartWidget({required this.title,required this.imageUrl,super.key});

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
            height: 40,
            width: context.deviceWidht,
            decoration: ProjectBoxDecorations.earnDetailsPageBoxDecoration,
            child: Padding(
              padding: const ProjectPaddings.verticalSmall(),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.textThemeTitleLarge?.copyWith(color: CustomColors.mWhitePrimary,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.1,
          left: 1,
          child: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_rounded)),
        ),
      ],
    );
  }
}