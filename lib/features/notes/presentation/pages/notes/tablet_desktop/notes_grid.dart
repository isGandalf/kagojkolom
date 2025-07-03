import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/notes_grid_view.dart';

class NotesGrid extends StatefulWidget {
  final TextEditingController searchController;
  const NotesGrid({super.key, required this.searchController});

  @override
  State<NotesGrid> createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  List<NoteEntity> _getNotes(NotesLoadedState state) {
    switch (state.notePageType) {
      case NotePageType.myNotes:
        return state.myNotes;
      case NotePageType.favourites:
        return state.favNotes;
      case NotePageType.trash:
        return state.trashNotes;
      case NotePageType.sharedWithMe:
        return state.sharedWithMeNotes;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_searchKeypress);
  }

  void _searchKeypress() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_searchKeypress);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is NotesLoadedState) {
          print(state.notePageType);
          print(state.runtimeType);
          final List<NoteEntity> notesToShow = _getNotes(state);
          final searchText = widget.searchController.text.toLowerCase();
          final filteredNotes =
              searchText.isEmpty
                  ? notesToShow
                  : notesToShow.where((note) {
                    return note.noteTitle.toLowerCase().contains(searchText) ||
                        note.noteContent.toLowerCase().contains(searchText);
                  }).toList();

          return NotesGridView(
            noteList: filteredNotes,
            notePageType: state.notePageType,
          );
        } else if (state is NotesLoadingState) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else {
          print(state.runtimeType);
          return const Expanded(
            child: Center(child: Text('Failed to load your notes')),
          );
        }
      },
    );
  }
}
