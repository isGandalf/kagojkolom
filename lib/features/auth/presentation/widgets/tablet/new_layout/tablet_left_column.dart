import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_page_type.dart';

class TabletLeftColumn extends StatelessWidget {
  const TabletLeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 50,
      child: Column(
        children: [
          TabletLeftColumnOption(
            icon: Icons.notes,
            onTap: () {
              context.read<NotesBloc>().add(
                NotePageOptionPressedEvent(
                  selectedNotePage: NotePageType.myNotes,
                ),
              );
            },
            pageType: NotePageType.myNotes,
          ),
          TabletLeftColumnOption(
            icon: Icons.favorite,
            onTap: () {
              context.read<NotesBloc>().add(
                NotePageOptionPressedEvent(
                  selectedNotePage: NotePageType.favourites,
                ),
              );
            },
            pageType: NotePageType.favourites,
          ),
          TabletLeftColumnOption(
            icon: Icons.share,
            onTap: () {
              context.read<NotesBloc>().add(
                NotePageOptionPressedEvent(
                  selectedNotePage: NotePageType.sharedWithMe,
                ),
              );
            },
            pageType: NotePageType.sharedWithMe,
          ),
          TabletLeftColumnOption(
            icon: Icons.delete_outline,
            onTap: () {
              context.read<NotesBloc>().add(
                NotePageOptionPressedEvent(
                  selectedNotePage: NotePageType.trash,
                ),
              );
            },
            pageType: NotePageType.trash,
          ),
        ],
      ),
    );
  }
}

class TabletLeftColumnOption extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final NotePageType pageType;
  const TabletLeftColumnOption({
    super.key,
    required this.icon,
    required this.onTap,
    required this.pageType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        NotePageType currentPage = NotePageType.myNotes;
        if (state is NotesLoadedState) {
          currentPage = state.notePageType;
          //print(currentPage);
        }
        final bool isSelected = pageType == currentPage;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color:
                  isSelected ? AppColorsCommon.primaryBlue : Colors.transparent,
            ),
            child: IconButton(
              onPressed: onTap,
              icon: Icon(
                icon,
                color: isSelected ? Colors.white : AppColorsCommon.primaryBlue,
              ),
            ),
          ),
        );
      },
    );
  }
}
