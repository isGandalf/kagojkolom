import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/floating_button.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/tablet_right_column.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/tablet_middle_column.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/tablet_left_column.dart';

class HomepageTablet extends StatefulWidget {
  const HomepageTablet({super.key});

  @override
  State<HomepageTablet> createState() => _HomepageTabletState();
}

class _HomepageTabletState extends State<HomepageTablet> {
  List<Map<String, dynamic>> sampleNotes = [
    {
      'title': 'Meeting Notes',
      'content':
          'Discuss project milestones and deadlines. Discuss project milestones and deadlines.',
      'date': DateTime.now(),
      'isFavourite': true,
      'isPrivate': false,
    },
    {
      'title': 'Grocery List',
      'content': 'Milk, eggs, bread, coffee, and fruits.',
      'date': DateTime.now(),
      'isFavourite': false,
      'isPrivate': true,
    },
    {
      'title': 'Flutter Tips',
      'content': 'Use const constructors and avoid rebuilds.',
      'date': DateTime.now(),
      'isFavourite': true,
      'isPrivate': false,
    },
    {
      'title': 'Travel Plan',
      'content': 'Book flights and hotels for June vacation.',
      'date': DateTime.now(),
      'isFavourite': false,
      'isPrivate': false,
    },
  ];

  Map<String, dynamic>? selectedNote;
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

  void noteSelection(Map<String, dynamic>? note) {
    setState(() {
      selectedNote = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(),
        // drawer column
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // left column
            TabletLeftColumn(),
            VerticalDivider(thickness: 1, width: 0),

            // middle column
            SizedBox(
              width: 300,
              child: MiddleColumn(
                sampleNotes: sampleNotes,
                selectedNote: selectedNote,
                onSelect: noteSelection,
              ),
            ),
            VerticalDivider(thickness: 1, width: 1),

            // right column
            TabletRightColumn(selectedNote: selectedNote),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {},
              shape: CircleBorder(),
              child: Icon(Icons.share),
            ),
            SizedBox(height: 20),
            FloatingButton(),
          ],
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
