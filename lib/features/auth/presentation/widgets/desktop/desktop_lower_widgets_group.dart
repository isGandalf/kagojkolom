import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop/desktop_left_column_option.dart';

class DesktopLowerWidgetsGroup extends StatelessWidget {
  final void Function(int) onPageSelect;
  final int selectedPage;
  const DesktopLowerWidgetsGroup({
    super.key,
    required this.onPageSelect,
    required this.selectedPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          DeskTopLeftColumnOption(
            optionName: 'Trash',
            onTap: () {
              onPageSelect(4);
            },
            icon: Icons.delete_outlined,
            isSelected: selectedPage == 4,
          ),
          DeskTopLeftColumnOption(
            optionName: 'Trash',
            onTap: () {
              onPageSelect(5);
            },
            icon: Icons.logout_outlined,
            isSelected: selectedPage == 5,
          ),
        ],
      ),
    );
  }
}
