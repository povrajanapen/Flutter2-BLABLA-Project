import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

class RidePrefTile extends StatelessWidget {
  final String title;
  final IconData iconLeft;
  final bool isSelected;
  final VoidCallback? onPressed;

  //-for when the location is selected
  final IconData? iconRight;
  final VoidCallback? onRightIconTap;

  const RidePrefTile({
    required this.title,
    required this.iconLeft,
    this.isSelected = false,
    this.onPressed,
    this.iconRight,
    this.onRightIconTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = isSelected ? BlaColors.textNormal : BlaColors.textLight;
    return ListTile(
      onTap: onPressed,
      title: Text(title, style: BlaTextStyles.button.copyWith(color: textColor)),
      leading: Icon(
        iconLeft, 
        color: BlaColors.iconLight,
        ),
      // - only show iconRight when a location is selected
      trailing: iconRight != null 
          ? IconButton(
              icon: Icon(iconRight, color: BlaColors.iconLight,),
              onPressed: onRightIconTap,
            )
          : null, 
    );
  }
}