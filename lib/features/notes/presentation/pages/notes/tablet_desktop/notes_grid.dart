import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/notes_grid_view.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is NotesLoadedState) {
          print(state.notePageType);
          final List<NoteEntity> notesToShow;
          switch (state.notePageType) {
            case NotePageType.myNotes:
              notesToShow = state.myNotes;
              break;
            case NotePageType.favourites:
              notesToShow = state.favNotes;
              break;
            case NotePageType.trash:
              notesToShow = state.trashNotes;
              break;
            case NotePageType.sharedWithMe:
              notesToShow = state.sharedWithMeNotes;
              break;
          }
          return NotesGridView(
            noteList: notesToShow,
            notePageType: state.notePageType,
          );
        } else if (state is NotesLoadingState) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else {
          return const Expanded(
            child: Center(child: Text('Failed to load your notes')),
          );
        }
      },
    );
  }
}
