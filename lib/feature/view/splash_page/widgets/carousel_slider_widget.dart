part of '../splash_page.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({
    required this.items,
    required this.onIndexChanged,
    super.key,
  });

  final List<Widget> items;
  final ValueChanged<int> onIndexChanged;

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.items,
      options: CarouselOptions(
        height: ProjectSizes.size500.value,
        enlargeFactor: 0.45,
        autoPlayInterval: const Duration(seconds: 2),
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          widget.onIndexChanged(index);
        },
      ),
    );
  }
}
