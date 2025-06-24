import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_card_for_update.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_dialog.dart';
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

  @override
  Widget build(BuildContext context) {
    final crossAxis = MediaQuery.of(context).size.width ~/ 300;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 30),
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
    );
  }
}

