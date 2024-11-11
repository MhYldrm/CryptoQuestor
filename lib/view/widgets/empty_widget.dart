import 'package:flutter/material.dart';

/// [height] height value.
///
final class EmptyWidget extends StatelessWidget {
  final double height;
  const EmptyWidget({
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
