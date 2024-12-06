import 'package:flutter/material.dart';

final class CostCalculateTextFieldsWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CostCalculateTextFieldsWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
    );
  }
}