import 'package:flutter/material.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/notes.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

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

  @override
  Widget build(BuildContext context) {
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
                Notes(sampleNotes: sampleNotes),
                Notes(sampleNotes: sampleNotes),
                Notes(sampleNotes: sampleNotes),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
