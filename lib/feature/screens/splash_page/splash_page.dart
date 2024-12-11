import 'package:auto_route/auto_route.dart';
import 'package:crypto_questor/feature/screens/splash_page/widgets/animated_indicator_widget.dart';
import 'package:crypto_questor/feature/screens/splash_page/widgets/carousel_slider_widget.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../product/components/button/my_custom_button.dart';
import '../../../product/components/padding/project_paddings.dart';
import '../../../product/components/styles/application_constants.dart';
import '../../../product/components/styles/custom_colors.dart';
import '../../../product/navigation/app_router.dart';
import '../sign_up_page/widget/existing_account_link_widget.dart';
import 'mixin/splash_page_mixin.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SplashPageMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.bgcolor,
        body: Padding(
          padding: const ProjectPaddings.allMedium(),
          child: Column(
            children: [
              Expanded(
                flex: 12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CarouselSliderWidget(
                      items: imagesList,
                      onIndexChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    AnimatedIndicatorWidget(
                      activeIndex: currentIndex,
                      count: imagesList.length,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    MyCustomButton(
                      onPressed: () {
                        context.router.push(const SignUpRoute());
                      },
                      buttonText: ApplicationConstants.getStarted,
                    ),
                    ExistingAccountLinkWidget(widht: context.deviceWidht / 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
