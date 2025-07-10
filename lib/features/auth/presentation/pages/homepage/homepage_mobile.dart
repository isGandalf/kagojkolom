import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/layout_type.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/notes_grid_layout.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/mobile/bottom_nav_bar.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/floating_button.dart';
import 'package:kagojkolom/features/calendar/calendar_widget_page.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/mobile/notes_deleted.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/legacy/notes_grid_view_parent.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/legacy/notes_mobile.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/legacy/notes_shared_with_me.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/add_new_note_dialog.dart';
import 'package:kagojkolom/shared/widgets/search_field.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/mobile/user_header.dart';

class HomepageMobile extends StatefulWidget {
  const HomepageMobile({super.key});

  @override
  State<HomepageMobile> createState() => _HomepageMobileState();
}

class _HomepageMobileState extends State<HomepageMobile> {
  final _searchController = TextEditingController();
  final _noteTitleController = TextEditingController();
  final _noteContentController = TextEditingController();
  late NotePageType selectedPageType;

  List<NoteEntity> _getNotes(
    NotesLoadedState state,
    NotePageType notePageType,
  ) {
    switch (notePageType) {
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
    _searchController.addListener(_searchKeypress);
    selectedPageType = NotePageType.myNotes;
    context.read<NotesBloc>().add(
      NotePageInitialEvent(notePageType: NotePageType.myNotes),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _noteTitleController.dispose();
    _noteContentController.dispose();
    _searchController.removeListener(_searchKeypress);
    super.dispose();
  }

  void setPage(NotePageType page) {
    setState(() {
      selectedPageType = page;
    });
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // const UserHeader(),
                  // const SizedBox(height: 20),
                  SearchField(searchController: _searchController),
                  const SizedBox(height: 10),
                  Expanded(
                    child: BlocConsumer<NotesBloc, NotesState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is NotesLoadingState) {
                          print(state.runtimeType);
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (state is NotesLoadingFailedState) {
                          return const Center(
                            child: Text(
                              'Failed to load notes. Please check internet connection',
                            ),
                          );
                        } else if (state is NotesLoadedState) {
                          final notes = _getNotes(state, state.notePageType);
                          final searchText =
                              _searchController.text.toLowerCase();
                          final filteredNotes =
                              notes
                                  .where(
                                    (note) =>
                                        note.noteTitle.contains(searchText) ||
                                        note.noteContent.contains(searchText),
                                  )
                                  .toList();

                          return NotesGridLayout(
                            layoutType: LayoutType.mobile,
                            noteEntityList: filteredNotes,
                            notePageType: state.notePageType,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingButton(
          onTap: () {
            addNewNoteDialog(
              context,
              _noteTitleController,
              _noteContentController,
            );
          },
          icon: Icons.add,
          iconSize: 20,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavBar(
          onPageSelected: (NotePageType page) {
            setState(() {
              selectedPageType = page;
              print(selectedPageType);
              context.read<NotesBloc>().add(
                NotePageOptionPressedEvent(selectedNotePage: selectedPageType),
              );
            });
          },
        ),
      ),
    );
  }
}
