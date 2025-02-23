import 'package:crypto_questor/product/components/padding/project_paddings.dart';
import 'package:crypto_questor/product/components/styles/custom_colors.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../product/components/styles/application_size.dart';

/// A widget that displays an error message when an API request fails.
/// It shows a centered message indicating that there was an issue with the request.
/// [isApiRequestFailed] Text to be displayed when an error is returned as a result of many requests in the free API
///
class ShowErrorWidget extends StatefulWidget {
  const ShowErrorWidget({super.key});

  @override
  State<ShowErrorWidget> createState() => _ShowErrorWidgetState();
}

class _ShowErrorWidgetState extends State<ShowErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ApplicationSize.size250.value,
      child: Padding(
        padding: const ProjectPaddings.allxSmall(),
        child: Center(
          child: Padding(
            padding: const ProjectPaddings.allLarge(),
            child: Text(
              context.mLocalizations.isApiRequestFailed,
              style: TextStyle(
                color: context.isDarkMode
                    ? CustomColors.mWhitePrimary
                    : CustomColors.bgcolor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
