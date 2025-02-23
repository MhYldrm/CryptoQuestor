part of '../coin_details_page.dart';

class ShowCircularIndicator extends StatelessWidget {
  const ShowCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ApplicationSize.size250.value,
      child: const Center(
        child: CircularProgressIndicator(
          color: CustomColors.mLilacPrimary,
        ),
      ),
    );
  }
}
