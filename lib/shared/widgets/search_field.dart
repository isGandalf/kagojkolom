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
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20),
        hintText: 'Search',
        hintStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          onPressed: () {
            _searchController.clear();
          },
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }
}
