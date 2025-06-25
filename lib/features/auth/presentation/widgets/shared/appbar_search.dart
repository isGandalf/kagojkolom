import 'package:flutter/material.dart';

class AppBarSearch extends StatelessWidget {
  final TextEditingController searchController;
  const AppBarSearch({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final width = maxWidth > 600 ? 600.0 : maxWidth;

          return Align(
            child: SizedBox(
              width: width,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
