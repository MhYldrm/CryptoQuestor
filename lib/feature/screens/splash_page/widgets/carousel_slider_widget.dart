part of '../splash_page.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({
    super.key,
    required this.items,
    required this.onIndexChanged,
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
          height: ApplicationSize.size500.value,
          autoPlay: false,
          enlargeFactor: 0.45,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayInterval: const Duration(seconds: 2),
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            widget.onIndexChanged(index);
          }),
    );
  }
}
