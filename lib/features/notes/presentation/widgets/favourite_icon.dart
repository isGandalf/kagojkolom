import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';

class FavouriteIconButton extends StatefulWidget {
  const FavouriteIconButton({
    super.key,
    required this.noteId,
    required this.currentPage,
  });

  final int noteId;
  final NotePageType currentPage;

  @override
  State<FavouriteIconButton> createState() => _FavouriteIconButtonState();
}

class _FavouriteIconButtonState extends State<FavouriteIconButton> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<NotesBloc, NotesState, bool>(
      selector: (state) {
        if (state is NotesLoadedState) {
          final updatedNote = state.myNotes.firstWhere(
            (n) => n.noteId == widget.noteId,
            orElse:
                () =>
                    state.favNotes.firstWhere((n) => n.noteId == widget.noteId),
          );
          return updatedNote.isFavourite;
        }
        return false;
      },
      builder: (context, isFav) {
        //print('Inside fav button widget - ${widget.currentPage}');
        return IconButton(
          onPressed: () {
            context.read<NotesBloc>().add(
              FavouriteButtonPressedEvent(
                noteId: widget.noteId,
                notePageType: widget.currentPage,
              ),
            );
          },
          icon: Icon(isFav ? Icons.favorite : Icons.favorite_outline),
        );
      },
    );
  }
}
