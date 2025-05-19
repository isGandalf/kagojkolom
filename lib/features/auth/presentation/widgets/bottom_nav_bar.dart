import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/custom_note_icon.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                CustomNoteIcon(onPressed: () {}, icon: Icon(Icons.list)),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: CustomNoteIcon(
                    onPressed: () {},
                    icon: Icon(Icons.label_important_outline),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CustomNoteIcon(
                    onPressed: () {},
                    icon: Icon(Icons.calendar_month_outlined),
                  ),
                ),
                CustomNoteIcon(onPressed: () {}, icon: Icon(Icons.settings)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
