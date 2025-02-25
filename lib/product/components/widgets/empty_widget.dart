import 'package:flutter/material.dart';

/// [height] height value.
///
final class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    required this.height,
    super.key,
  });
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
