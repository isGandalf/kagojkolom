import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop/desktop_left_column_option.dart';

class DesktopUpperWidgetsGroup extends StatelessWidget {
  const DesktopUpperWidgetsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Options: notes, favourites, share, calendar
      child: Column(
        children: [
          DeskTopLeftColumnOption(
            optionName: 'All notes',
            onTap: () {
              print('Clicked all notes');
            },
            icon: Icons.notes,
          ),
          DeskTopLeftColumnOption(
            optionName: 'Favourites',
            onTap: () {
              print('Clicked Favourites');
            },
            icon: Icons.favorite,
          ),
          DeskTopLeftColumnOption(
            optionName: 'Shared with me',
            onTap: () {
              print('Shared with me');
            },
            icon: Icons.share,
          ),
          DeskTopLeftColumnOption(
            optionName: 'Calendar',
            onTap: () {
              print('clicked Calendar');
            },
            icon: Icons.calendar_month_outlined,
          ),
        ],
      ),
    );
  }
}
