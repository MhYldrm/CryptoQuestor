/// A custom material button widget with an icon and a label.
/// This button widget is designed to be used in navigation bars, such as a bottom navigation bar.
/// It includes customization options for icon color, label text, and handling tap events.
///
/// [icon] - The icon to display in the button. This is typically a [IconData] object.
/// [label] - The text label to display below the icon in the button.
/// [isSelected] - A boolean value that indicates whether the button is in the selected state. It determines the color of the icon and the label text.
/// [onTap] - A callback function that is triggered when the button is tapped.
///
part of '../intro_page.dart';

class CustomMaterialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomMaterialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: ApplicationSize.size40.value,
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: ApplicationSize.size20.value,
            color: isSelected
                ? context.isDarkMode
                    ? CustomColors.mYellow
                    : CustomColors.mPinkPrimary
                : CustomColors.mGreyPrimary,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: ApplicationSize.size11.value,
              color: isSelected
                  ? context.isDarkMode
                      ? CustomColors.mYellow
                      : CustomColors.bgcolor
                  : CustomColors.mGreyPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
