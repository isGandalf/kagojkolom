import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20),
        hintText: 'Search',
        hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        prefixIcon: Icon(Icons.search),
        suffixIcon: IconButton(
          onPressed: () {
            _searchController.clear();
          },
          icon: Icon(Icons.clear),
        ),
      ),
    );
  }
}
