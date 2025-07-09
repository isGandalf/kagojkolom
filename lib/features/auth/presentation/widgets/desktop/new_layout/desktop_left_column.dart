import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop/new_layout/desktop_left_column_option.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_page_type.dart';

class DesktopLeftColumn extends StatelessWidget {
  const DesktopLeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          // this will contain different pages/lists:
          // My notes, Favourites, Trash, SharedWithMe
          DesktopLeftColumnOption(
            icon: Icons.notes_rounded,
            optionName: 'My notes',
            pageName: NotePageType.myNotes,
            onTap: () {
              context.read<NotesBloc>().add(
                NotePageOptionPressedEvent(
                  selectedNotePage: NotePageType.myNotes,
                ),
              );
            },
          ),
          DesktopLeftColumnOption(
            icon: Icons.favorite,
            optionName: 'Favourites',
            pageName: NotePageType.favourites,
            onTap: () {
              context.read<NotesBloc>().add(
                NotePageOptionPressedEvent(
                  selectedNotePage: NotePageType.favourites,
                ),
              );
            },
          ),
          DesktopLeftColumnOption(
            icon: Icons.share,
            optionName: 'Shared with me',
            pageName: NotePageType.sharedWithMe,
            onTap: () {
              context.read<NotesBloc>().add(
                NotePageOptionPressedEvent(
                  selectedNotePage: NotePageType.sharedWithMe,
                ),
              );
            },
          ),
          DesktopLeftColumnOption(
            icon: Icons.delete_outline_outlined,
            optionName: 'Trash',
            pageName: NotePageType.trash,
            onTap: () {
              context.read<NotesBloc>().add(
                NotePageOptionPressedEvent(
                  selectedNotePage: NotePageType.trash,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
