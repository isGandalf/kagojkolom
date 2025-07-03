import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_card.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/update_note/note_dialog_for_update.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/three_dot_menu.dart';

class NotesGridView extends StatelessWidget {
  final List<NoteEntity> noteList;
  final NotePageType notePageType;
  const NotesGridView({
    super.key,
    required this.noteList,
    required this.notePageType,
  });

  void sortedList(List<NoteEntity> noteList) {
    noteList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Widget build(BuildContext context) {
    final crossAxis = MediaQuery.of(context).size.width ~/ 300;
    sortedList(noteList);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 10),
            Text(
              '   ${noteList.length} notes',
              style: TextStyle(color: Colors.blueGrey),
            ),
            //SizedBox(height: 10),
            Expanded(
              child: MasonryGridView.builder(
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxis,
                  //childAspectRatio: 500 / 600,
                ),
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  final note = noteList[index];
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
      ),
    );
  }
}
