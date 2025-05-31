import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop/desktop_left_column_option.dart';

class DesktopLowerWidgetsGroup extends StatelessWidget {
  const DesktopLowerWidgetsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          DeskTopLeftColumnOption(
            optionName: 'Trash',
            onTap: () {
              print('clicked Trash');
            },
            icon: Icons.delete_outlined,
          ),
          DeskTopLeftColumnOption(
            optionName: 'Trash',
            onTap: () {
              print('Sign Out');
            },
            icon: Icons.logout_outlined,
          ),
        ],
      ),
    );
  }
}
