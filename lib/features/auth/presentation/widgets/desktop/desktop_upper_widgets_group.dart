import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop/desktop_left_column_option.dart';

class DesktopUpperWidgetsGroup extends StatelessWidget {
  final void Function(int) onPageSelect;
  final int selectedPage;

  const DesktopUpperWidgetsGroup({
    super.key,
    required this.onPageSelect,
    required this.selectedPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Options: notes, favourites, share, calendar
      child: Column(
        children: [
          DeskTopLeftColumnOption(
            optionName: 'All notes',
            onTap: () {
              onPageSelect(0);
            },
            icon: Icons.notes,
            isSelected: selectedPage == 0,
          ),
          DeskTopLeftColumnOption(
            optionName: 'Favourites',
            onTap: () {
              onPageSelect(1);
            },
            icon: Icons.favorite,
            isSelected: selectedPage == 1,
          ),
          DeskTopLeftColumnOption(
            optionName: 'Shared with me',
            onTap: () {
              onPageSelect(2);
            },
            icon: Icons.share,
            isSelected: selectedPage == 2,
          ),
          DeskTopLeftColumnOption(
            optionName: 'Calendar',
            onTap: () {
              onPageSelect(3);
            },
            icon: Icons.calendar_month_outlined,
            isSelected: selectedPage == 3,
          ),
        ],
      ),
    );
  }
}
