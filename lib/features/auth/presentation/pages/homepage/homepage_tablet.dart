import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/custom_app_bar.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/floating_action_button_options.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/middle_column_note_list.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/tablet/tablet_left_column.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/notes_tablet.dart';

class HomepageTablet extends StatefulWidget {
  const HomepageTablet({super.key});

  @override
  State<HomepageTablet> createState() => _HomepageTabletState();
}

class _HomepageTabletState extends State<HomepageTablet> {
  NoteEntity? selectedNote;
  late TextEditingController _noteTitleController;
  late TextEditingController _noteContentController;

  @override
  void initState() {
    super.initState();
    _noteTitleController = TextEditingController();
    _noteContentController = TextEditingController();
  }

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  void noteSelection(NoteEntity note) {
    setState(() {
      selectedNote = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        // Loading state
        if (state is NotesLoadingState) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        // notes loading success state
        else if (state is NotesLoadedState) {
          final allNotes = state.allNotes;
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: CustomAppBar(),
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // left column
                  TabletLeftColumn(),
                  VerticalDivider(thickness: 1, width: 0),

                  // middle column
                  SizedBox(
                    width: 300,
                    child: MiddleColumnNoteList(
                      noteEntity: allNotes,
                      selectedNote: selectedNote,
                      onSelect: noteSelection,
                    ),
                  ),
                  VerticalDivider(thickness: 1, width: 1),

                  // right column (notes view)
                  NotesTablet(selectedNote: selectedNote),
                ],
              ),
              floatingActionButton: FloatingActionButtonOptions(),
              //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            ),
          );
        } else {
          return Center(child: Text('Failed to load data'));
        }
      },
    );
  }
}
