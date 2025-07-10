import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/layout_type.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/notes_grid_layout.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/take_a_note_button.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/legacy/notes_grid_view_parent.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/legacy/notes_grid.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/legacy/notes_grid_view.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/custom_app_bar.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/tablet/new_layout/tablet_left_column.dart';

class HomepageTablet extends StatefulWidget {
  const HomepageTablet({super.key});

  @override
  State<HomepageTablet> createState() => _HomepageTabletState();
}

class _HomepageTabletState extends State<HomepageTablet> {
  late TextEditingController searchController;
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

  void _searchKeypress() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(_searchKeypress);
    context.read<NotesBloc>().add(
      NotePageInitialEvent(notePageType: NotePageType.myNotes),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    searchController.removeListener(_searchKeypress);
    super.dispose();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      context.read<NotesBloc>().add(
        NotePageInitialEvent(notePageType: NotePageType.myNotes),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(searchController: searchController),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Row(
          children: [
            // Left column icons
            TabletLeftColumn(),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),

                  // Take a note button
                  TakeANoteButton(layoutType: LayoutType.tablet),

                  // Notes Grid
                  Expanded(
                    child: BlocConsumer<NotesBloc, NotesState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is NotesLoadedState) {
                          final notes = _getNotes(state);
                          final searchText =
                              searchController.text.toLowerCase();
                          final filteredNotes =
                              searchText.isEmpty
                                  ? notes
                                  : notes
                                      .where(
                                        (note) =>
                                            note.noteTitle.contains(
                                              searchText,
                                            ) ||
                                            note.noteContent.contains(
                                              searchText,
                                            ),
                                      )
                                      .toList();
                          return NotesGridLayout(
                            layoutType: LayoutType.tablet,
                            noteEntityList: filteredNotes,
                            notePageType: state.notePageType,
                          );
                        } else if (state is NotesLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (state is NotesLoadingFailedState) {
                          return const Center(
                            child: Text(
                              'Failed to load notes. Please check internet connection',
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
