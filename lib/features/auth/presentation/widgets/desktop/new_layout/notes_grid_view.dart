import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/three_dot_menu.dart';

class NotesGridView extends StatelessWidget {
  const NotesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final crossAxis = MediaQuery.of(context).size.width ~/ 300;
    return Expanded(
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          //NotePageType currentPage = NotePageType.myNotes;
          if (state is NotesLoadedState) {
            print(state.notePageType);
            List<NoteEntity> notesToShow;
            switch (state.notePageType) {
              case NotePageType.myNotes:
                notesToShow = state.myNotes;
                break;
              case NotePageType.favourites:
                notesToShow = state.favNotes;
                break;
              case NotePageType.sharedWithMe:
                notesToShow = state.sharedWithMeNotes;
                break;
              case NotePageType.trash:
                notesToShow = state.trashNotes;
                break;
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100.0,
                vertical: 30,
              ),
              child: MasonryGridView.builder(
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxis,
                  //childAspectRatio: 500 / 600,
                ),
                itemCount: notesToShow.length,
                itemBuilder: (context, index) {
                  final note = notesToShow[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 6,
                    ),
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        hoverColor: AppColorsCommon.primaryBlue,
                        onTap: () {},
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        note.noteTitle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        note.noteContent,
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ThreeDotMenu(noteId: note.noteId),
                                      SizedBox(height: 20),
                                      Icon(Icons.favorite_outline),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is NotesLoadingState) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else {
            return Center(child: Text('Failed to load notes'));
          }
        },
      ),
    );
  }
}
