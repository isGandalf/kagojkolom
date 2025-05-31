import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/global/logger.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/custom_app_bar.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop/desktop_left_column.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/floating_action_button_options.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/floating_button.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/middle_column_note_list.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/notes_view_tablet_desktop.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/notes_desktop.dart';

class HomepageDesktop extends StatefulWidget {
  const HomepageDesktop({super.key});

  @override
  State<HomepageDesktop> createState() => _HomepageDesktopState();
}

class _HomepageDesktopState extends State<HomepageDesktop> {
  late TextEditingController _noteTitleController;
  late TextEditingController _noteContentController;

  NoteEntity? selectedNote;

  @override
  void initState() {
    super.initState();
    _noteTitleController = TextEditingController();
    _noteContentController = TextEditingController();
    context.read<NotesBloc>().add(NotePageInitialEvent());
  }

  @override
  void dispose() {
    _noteContentController.dispose();
    _noteTitleController.dispose();
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
        logger.d(state.runtimeType);
        // loading state
        if (state is NotesLoadingState) {
          return Scaffold(
            appBar: CustomAppBar(),
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        // logged state
        else if (state is NotesLoadedState) {
          final allNotes = state.allNotes;
          return Scaffold(
            appBar: CustomAppBar(),
            body: Row(
              children: [
                // left column
                DesktopLeftColumn(),
                VerticalDivider(thickness: 1, width: 0),

                // middle column
                SizedBox(
                  width: 400,

                  child: MiddleColumnNoteList(
                    noteEntity: allNotes,
                    selectedNote: selectedNote,
                    onSelect: noteSelection,
                  ),
                ),
                VerticalDivider(thickness: 1, width: 1),

                // // right column (notes view)
                NotesDesktop(selectedNote: selectedNote),
                // Expanded(
                //   child: Container(
                //     color:
                //         Theme.of(context).brightness == Brightness.dark
                //             ? AppColorsDark.noteBackgroundColor
                //             : AppColorsLight.noteBackgroundColor,
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: 30.0,
                //         vertical: 20,
                //       ),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           SizedBox(width: double.infinity, child: TextField()),
                //           Expanded(child: TextField()),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            floatingActionButton: FloatingActionButtonOptions(),
          );
        }
        // failed state
        else {
          return Scaffold(
            appBar: CustomAppBar(),
            body: Center(
              child: Column(children: [Text('Failed to load notes')]),
            ),
          );
        }
      },
    );
  }
}
