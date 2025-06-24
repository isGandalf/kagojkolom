import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/mobile/bottom_nav_bar.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/floating_button.dart';
import 'package:kagojkolom/features/calendar/calendar_widget_page.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/mobile/notes_deleted.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/mobile/notes_mobile.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/mobile/notes_shared_with_me.dart';
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

  List<Widget> pages = [
    NotesMobile(),
    NotesSharedWithMe(),
    NotesDeleted(),
    CalendarWidgetPage(),
  ];

  late int selectedWidget;

  @override
  void dispose() {
    _searchController.dispose();
    _noteTitleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedWidget = 0;
  }

  void setPage(int page) {
    setState(() {
      selectedWidget = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const UserHeader(),
                const SizedBox(height: 20),
                SearchField(searchController: _searchController),
                const SizedBox(height: 10),
                pages[selectedWidget],
                const SizedBox(height: 10),
              ],
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
          onPageSelected: (int page) {
            setPage(page);
          },
        ),
      ),
    );
  }
}
