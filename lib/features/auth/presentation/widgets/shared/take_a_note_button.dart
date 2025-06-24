import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';

class TakeANoteButton extends StatelessWidget {
  const TakeANoteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        ),
        backgroundColor: WidgetStatePropertyAll(AppColorsCommon.primaryBlue),
      ),
      label: Text(
        'Take a note',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      icon: Icon(Icons.edit_square, size: 20),
    );
  }
}
