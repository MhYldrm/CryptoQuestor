import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
          height: 500,
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
