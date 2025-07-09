import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/layout_type.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_card.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_page_type.dart';

class NotesGridLayout extends StatelessWidget {
  final LayoutType layoutType;
  final List<NoteEntity> noteEntityList;
  final NotePageType notePageType;
  const NotesGridLayout({
    super.key,
    required this.layoutType,
    required this.noteEntityList,
    required this.notePageType,
  });

  void _sortList(List<NoteEntity> list) {
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Widget build(BuildContext context) {
    final crossAxisItems = MediaQuery.of(context).size.width ~/ 300;

    final padding = switch (layoutType) {
      LayoutType.desktop => const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 10,
      ),
      LayoutType.tablet => const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 5,
      ),
      LayoutType.mobile => const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 5,
      ),
    };

    _sortList(noteEntityList);

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${noteEntityList.length} notes',
            style: TextStyle(color: Colors.blueGrey),
          ),
          SizedBox(height: 10),
          Expanded(
            child: MasonryGridView.builder(
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisItems,
              ),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              itemCount: noteEntityList.length,
              itemBuilder: (context, index) {
                final note = noteEntityList[index];
                return NoteCard(
                  note: note,
                  notePageType: notePageType,
                  key: ValueKey(note.noteId),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
