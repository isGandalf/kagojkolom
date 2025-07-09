import 'package:flutter/material.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/custom_note_icon.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(NotePageType) onPageSelected;
  const BottomNavBar({super.key, required this.onPageSelected});

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
                CustomNoteIcon(
                  onPressed: () {
                    onPageSelected(NotePageType.myNotes);
                  },
                  icon: Icon(Icons.notes),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: CustomNoteIcon(
                    onPressed: () {
                      onPageSelected(NotePageType.sharedWithMe);
                    },
                    icon: Icon(Icons.share),
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
                    onPressed: () {
                      onPageSelected(NotePageType.favourites);
                    },
                    icon: Icon(Icons.favorite_outlined),
                  ),
                ),
                CustomNoteIcon(
                  onPressed: () {
                    onPageSelected(NotePageType.trash);
                  },
                  icon: Icon(Icons.delete_forever),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
