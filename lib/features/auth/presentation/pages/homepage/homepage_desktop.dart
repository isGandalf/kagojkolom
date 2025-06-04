import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop/ddesktop_left_column.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop/new_layout/desktop_left_column.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop/new_layout/desktop_left_column_option.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop/new_layout/notes_grid_view.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/custom_app_bar.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/three_dot_menu.dart';

class HomepageDesktop extends StatefulWidget {
  const HomepageDesktop({super.key});

  @override
  State<HomepageDesktop> createState() => _HomepageDesktopState();
}

class _HomepageDesktopState extends State<HomepageDesktop> {
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(NotePageInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          // Left column - different note list
          DesktopLeftColumn(),

          // Gridview
          NotesGridView(),
        ],
      ),
    );
  }
}




































// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kagojkolom/core/global/logger.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/shared/all_notes_page.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/shared/custom_app_bar.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/desktop/desktop_left_column.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/shared/favourite_page.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/shared/floating_action_button_options.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/shared/shared_with_me_page.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/shared/sign_out_page.dart';
// import 'package:kagojkolom/features/calendar/calendar_widget_page.dart';
// import 'package:kagojkolom/features/notes/presentation/widgets/middle_column_note_list.dart';
// import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
// import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/notes_desktop.dart';
// import 'package:kagojkolom/features/notes/presentation/widgets/trash_notes.dart';

// class HomepageDesktop extends StatefulWidget {
//   const HomepageDesktop({super.key});

//   @override
//   State<HomepageDesktop> createState() => _HomepageDesktopState();
// }

// class _HomepageDesktopState extends State<HomepageDesktop> {
//   // Variables to store a note from different notelist (lists: allNotes, fav, sharedWithMe, deleted)
//   NoteEntity? selectedFromAllNotes;
//   NoteEntity? selectedFromFavNotes;
//   NoteEntity? selectedFromSharedWithMe;
//   NoteEntity? selectedFromDeletedNotes;


//   // Variable to store a specfic noteList. Initially on apphold, list 0 will be build which is allNotes.
//   late int selectedPage;

//   @override
//   void initState() {
//     super.initState();
//     selectedPage = 0;
//     context.read<NotesBloc>().add(NotePageInitialEvent());
//   }

//   void noteSelectionFromAllNotes(NoteEntity note) {
//     setState(() {
//       selectedFromAllNotes = note;
//     });
//   }

  

//   void pageSelect(int index) {
//     setState(() {
//       selectedPage = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NotesBloc, NotesState>(
//       builder: (context, state) {
//         logger.d(state.runtimeType);
//         // loading state
//         if (state is NotesLoadingState) {
//           return Scaffold(
//             appBar: CustomAppBar(),
//             body: Center(child: CircularProgressIndicator.adaptive()),
//           );
//         }
//         // logged state
//         else if (state is NotesLoadedState) {
//           final allNotes = state.allNotes;

//           // load left column pages
//           List<Widget> pages = [
//             AllNotesPage(
//               noteEntityList: allNotes,
//               onSelect: noteSelectionFromAllNotes,
//               selectedNote: selectedFromAllNotes,
//             ),
//             FavouritePage(),
//             SharedWithMePage(),
//             CalendarWidgetPage(),
//             TrashNotes(),
//             SignOutPage(),
//           ];

//           //

//           return Scaffold(
//             appBar: CustomAppBar(),
//             body: Row(
//               children: [
//                 // left column
//                 DesktopLeftColumn(
//                   onPageSelect: pageSelect,
//                   selectedPage: selectedPage,
//                 ),
//                 VerticalDivider(thickness: 1, width: 0),

//                 // middle column
//                 SizedBox(
//                   width: 400,
//                   child: pages[selectedPage],

//                   // MiddleColumnNoteList(
//                   //   noteEntityList: allNotes,
//                   //   selectedNote: selectedNote,
//                   //   onSelect: noteSelection,
//                   // ),
//                 ),
//                 VerticalDivider(thickness: 1, width: 1),

//                 // right column (notes view)
//                 if (selectedPage == 0) {
                  
//                 }
//                 NotesDesktop(selectedNote: selectedFromAllNotes),
//               ],
//             ),
//             floatingActionButton: FloatingActionButtonOptions(),
//           );
//         }
//         // failed state
//         else {
//           return Scaffold(
//             appBar: CustomAppBar(),
//             body: Center(
//               child: Column(children: [Text('Failed to load notes')]),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
