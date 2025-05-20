import 'package:flutter/material.dart';

class HomepageTablet extends StatelessWidget {
  const HomepageTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: SafeArea(
              child: ListTile(
                leading: IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
                title: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 600,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
                trailing: IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*

IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
                  SizedBox(width: 400, child: TextField()),
                  IconButton(onPressed: () {}, icon: Icon(Icons.abc)),

                  */
