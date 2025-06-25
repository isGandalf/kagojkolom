import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/take_a_note_button.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/notes_grid.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/notes_grid_view.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/custom_app_bar.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/tablet/new_layout/tablet_left_column.dart';

class HomepageTablet extends StatefulWidget {
  const HomepageTablet({super.key});

  @override
  State<HomepageTablet> createState() => _HomepageTabletState();
}

class _HomepageTabletState extends State<HomepageTablet> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    context.read<NotesBloc>().add(
      NotePageInitialEvent(notePageType: NotePageType.myNotes),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(searchController: searchController),
      body: Row(
        children: [
          // Left column icons
          TabletLeftColumn(),

          Expanded(
            child: Column(
              children: [
                SizedBox(height: 30),

                // Take a note button
                TakeANoteButton(),

                // Notes Grid
                NotesGrid(searchController: searchController),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
