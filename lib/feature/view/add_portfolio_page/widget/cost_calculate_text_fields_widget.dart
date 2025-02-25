/// [CostCalculateTextFieldsWidget] is a stateless widget designed to provide
/// a text input field specifically for numeric inputs, such as price or quantity.
///
/// - [controller] A [TextEditingController] that manages the text being entered into the field.
/// - [onChanged] A callback function triggered whenever the text in the field changes,
///   passing the updated value as a [String].
///
///
part of '../add_portfolio_page.dart';

final class CostCalculateTextFieldsWidget extends StatelessWidget {
  const CostCalculateTextFieldsWidget({
    required this.controller,
    required this.onChanged,
    super.key,
  });
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        // Only digits are allowed to be entered
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: onChanged,
    );
  }
}
