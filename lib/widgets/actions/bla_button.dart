import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

enum BlaButtonType {
  primary,
  secondary,
}

class BlaButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final BlaButtonType type;

  const BlaButton({
    required this.text,
    this.icon,
    required this.onPressed,
    this.type = BlaButtonType.primary,
    super.key});

  @override
  Widget build(BuildContext context) {
    final isPrimary = type == BlaButtonType.primary;

    // - button styling based on type
    final backgroundColor = isPrimary ? BlaColors.primary : BlaColors.white;
    final textColor = isPrimary ? BlaColors.white : BlaColors.primary;
    final borderColor = isPrimary ? BorderSide.none : BorderSide(color: BlaColors.greyLight, width: 2);
    final iconColor = isPrimary ? BlaColors.white : BlaColors.primary;


    // - create a button icon if has any
    Widget buildButtonChild(Color iconColor, IconData? icon, String text, Color textColor) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
          if (icon != null) SizedBox(width: BlaSpacings.s), // - add spacing only if the icon exists
            // - create button text
            Text(text, style: BlaTextStyles.button.copyWith(color: textColor)),
        ],
      );
    }

    // - create a button
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: BlaSpacings.s),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BlaSpacings.radius),
          side: borderColor,
        ),
      ), 
        child: buildButtonChild(iconColor, icon, text, textColor)
      );
  }
}