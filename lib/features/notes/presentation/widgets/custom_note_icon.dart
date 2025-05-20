import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';

class CustomNoteIcon extends StatelessWidget {
  const CustomNoteIcon({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(),
      icon: icon,
      color: AppColorsCommon.primaryBlue,
    );
  }
}
