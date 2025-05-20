import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/bottom_nav_bar.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/floating_button.dart';
import 'package:kagojkolom/shared/widgets/search_field.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/tab_view.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/user_header.dart';

class HomepageMobile extends StatefulWidget {
  const HomepageMobile({super.key});

  @override
  State<HomepageMobile> createState() => _HomepageMobileState();
}

class _HomepageMobileState extends State<HomepageMobile> {
  final _searchController = TextEditingController();

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
                UserHeader(),
                SizedBox(height: 20),
                SearchField(searchController: _searchController),
                SizedBox(height: 10),
                TabView(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
