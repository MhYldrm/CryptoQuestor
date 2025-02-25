/// A widget displaying a list of earn projects.
/// It renders each project in an `EarnCard` widget and navigates to the details page when tapped.
/// [earnList] A list of [EarnModel] objects that represent the available earn projects.
/// [EarnCard] Displays the project's image, title, and exchange name.
/// [EarnDetailsPage] Navigates to this page to show detailed information about the selected project.
///
part of '../earn_page.dart';

final class EarnsListWidget extends StatelessWidget {
  const EarnsListWidget({required this.earnList, super.key});

  final List<EarnModel> earnList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: earnList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final earns = earnList[index];
        return Padding(
          padding: const ProjectPaddings.listViewMediumPadding(),
          child: InkWell(
            onTap: () {
              context.push(
                EarnDetailsPage(earnModel: earns),
              );
            },
            child: EarnCard(
              imageUrl: earns.imageUrl,
              title: earns.title,
              exchangeName: earns.exchangeName,
            ),
          ),
        );
      },
    );
  }
}
