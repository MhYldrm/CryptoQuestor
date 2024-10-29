import 'package:flutter/material.dart';

final class EmptyWidget extends StatelessWidget {
  double value;
   EmptyWidget({
     required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value);
  }
}