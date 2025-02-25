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
  const CustomMaterialButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: ProjectSizes.size40.value,
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: ProjectSizes.size20.value,
            color: isSelected
                ? context.isDarkMode
                    ? ProjectCustomColors.mYellow
                    : ProjectCustomColors.mPinkPrimary
                : ProjectCustomColors.mGreyPrimary,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: ProjectSizes.size11.value,
              color: isSelected
                  ? context.isDarkMode
                      ? ProjectCustomColors.mYellow
                      : ProjectCustomColors.bgColor
                  : ProjectCustomColors.mGreyPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
