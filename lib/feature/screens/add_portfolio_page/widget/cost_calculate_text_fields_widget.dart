import 'package:flutter/material.dart';

/// [CostCalculateTextFieldsWidget] is a stateless widget designed to provide
/// a text input field specifically for numeric inputs, such as price or quantity.
///
/// - [controller] A [TextEditingController] that manages the text being entered into the field.
/// - [onChanged] A callback function triggered whenever the text in the field changes,
///   passing the updated value as a [String].
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
