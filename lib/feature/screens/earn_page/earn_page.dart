library earn_page;

import 'package:crypto_questor/product/exports/exports.dart';
import '../../../product/components/widgets/earn_card.dart';
import '../../../product/models/earn_model.dart';
import '../../../product/services/coin_services.dart';
import '../coin_details_page/widget/show_error_widget.dart';
import '../earn_details_page/earn_details_page.dart';

/// [EarnPage] is a stateful widget that displays a list of earning opportunities.
///
/// Key Responsibilities:
/// - Displays a title section at the top of the page.
/// - Fetches and displays a list of earning opportunities.
/// - Shows a loading indicator while data is being fetched.
/// - Displays an error widget if the list is empty or an error occurs.
///
part 'widget/earn_page_title_part_widget.dart';
part 'widget/earns_list_widget.dart';
part 'mixin/earn_page_mixin.dart';

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
        backgroundColor: context.projectTheme?.primaryColor,
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
