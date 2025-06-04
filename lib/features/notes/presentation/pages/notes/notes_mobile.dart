import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/global/logger.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/notes_view_mobile.dart';

class NotesMobile extends StatefulWidget {
  const NotesMobile({super.key});

  @override
  State<NotesMobile> createState() => _NotesMobileState();
}

class _NotesMobileState extends State<NotesMobile>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<NotesBloc>().add(NotePageInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state)
      // Load the list of notes
      {
        logger.d(state.runtimeType);
        if (state is NotesLoadedState) {
          final noteList = state.myNotes;
          return Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabs: [
                      const Tab(text: 'Notes'),
                      const Tab(text: 'Favourites'),
                      const Tab(text: 'Private'),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      NotesViewMobile(noteList: noteList),
                      NotesViewMobile(noteList: noteList),
                      NotesViewMobile(noteList: noteList),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        // When list fetch failed
        else if (state is NotesLoadingState) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        // when fetching in progress
        else if (state is NotesLoadingFailedState) {
          return Center(
            child: Column(
              children: [
                Text(
                  'Error loading list, please check internet connection',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          );
        }
        // fallback state
        else {
          logger.d(state.runtimeType);
          return Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
