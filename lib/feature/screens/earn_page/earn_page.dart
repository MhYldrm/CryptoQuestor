import 'package:crypto_questor/feature/screens/earn_page/widget/earn_page_title_part_widget.dart';
import 'package:crypto_questor/feature/screens/earn_page/widget/earns_list_widget.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../product/models/earn_model.dart';
import '../coin_details_page/widget/show_error_widget.dart';
import 'mixin/earn_page_mixin.dart';

/// [EarnPage] is a stateful widget that displays a list of earning opportunities.
///
/// Key Responsibilities:
/// - Displays a title section at the top of the page.
/// - Fetches and displays a list of earning opportunities.
/// - Shows a loading indicator while data is being fetched.
/// - Displays an error widget if the list is empty or an error occurs.
class EarnPage extends StatefulWidget {
  const EarnPage({super.key});

  @override
  State<EarnPage> createState() => _EarnPageState();
}

class _EarnPageState extends State<EarnPage> with EarnPageMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.projectTheme!.primaryColor,
        body: Column(
          children: [
            // Title Section
            const Expanded(
              flex: 1,
              child: EarnPageTitlePartWidget(),
            ),
            // Earn List or Loading/Error Section
            Expanded(
              flex: 7,
              child: ValueListenableBuilder<bool>(
                valueListenable: isLoadingNotifier,
                builder: (context, isLoading, child) {
                  if (isLoading) {
                    // Loading Indicator
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    // Earn List or Error Widget
                    return ValueListenableBuilder<List<EarnModel>>(
                      valueListenable: earnListNotifier,
                      builder: (context, earnList, child) {
                        return earnList.isNotEmpty
                            ? EarnsListWidget(earnList: earnList)
                            : const ShowErrorWidget(); // Error Widget
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
