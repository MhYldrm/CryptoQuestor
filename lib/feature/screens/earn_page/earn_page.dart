import 'package:crypto_questor/feature/screens/earn_page/widget/earn_page_title_part_widget.dart';
import 'package:crypto_questor/feature/screens/earn_page/widget/earns_list_widget.dart';
import 'package:flutter/material.dart';
import '../../../product/components/styles/custom_colors.dart';
import '../../../product/models/earn_model.dart';
import '../coin_details_page/widget/show_error_widget.dart';
import 'mixin/earn_page_mixin.dart';

class EarnPage extends StatefulWidget {
  const EarnPage({super.key});

  @override
  State<EarnPage> createState() => _EarnPageState();
}

class _EarnPageState extends State<EarnPage> with EarnPageMixin{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: CustomColors.bgcolor,
          body: Column(
            children: [
              const Expanded(
                flex: 1,
                child: EarnPageTitlePartWidget(),
              ),
              Expanded(
                flex: 7,
                child: ValueListenableBuilder<bool>(
                  valueListenable: isLoadingNotifier,
                  builder: (context, isLoading, child) {
                    if (isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ValueListenableBuilder<List<EarnModel>>(
                        valueListenable: earnListNotifier,
                        builder: (context, earnList, child) {
                          return earnList.isNotEmpty
                              ? EarnsListWidget(earnList: earnList)
                              : const ShowErrorWidget();
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