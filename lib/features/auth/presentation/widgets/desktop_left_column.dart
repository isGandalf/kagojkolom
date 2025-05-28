import 'package:flutter/material.dart';

class DesktopLeftColumn extends StatelessWidget {
  const DesktopLeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            // Options: notes, favourites, share, calendar
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  hoverColor: const Color.fromARGB(22, 96, 125, 139),
                  splashColor: const Color.fromARGB(21, 96, 125, 139),
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.notes),
                  ),
                  title: Text('All notes'),
                  selected: true,
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  hoverColor: const Color.fromARGB(22, 96, 125, 139),
                  splashColor: const Color.fromARGB(21, 96, 125, 139),
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.favorite),
                  ),
                  title: Text('Favourites'),
                  selected: false,
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  hoverColor: const Color.fromARGB(22, 96, 125, 139),
                  splashColor: const Color.fromARGB(21, 96, 125, 139),
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.share),
                  ),
                  title: Text('Shared with me'),
                  selected: false,
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  hoverColor: const Color.fromARGB(22, 96, 125, 139),
                  splashColor: const Color.fromARGB(21, 96, 125, 139),
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.calendar_month_outlined),
                  ),
                  title: Text('Calendar'),
                  selected: false,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // Options: delete and signout
          SizedBox(
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  hoverColor: const Color.fromARGB(22, 96, 125, 139),
                  splashColor: const Color.fromARGB(21, 96, 125, 139),
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.delete_forever),
                  ),
                  title: Text('Trash'),
                  selected: false,
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  hoverColor: const Color.fromARGB(22, 96, 125, 139),
                  splashColor: const Color.fromARGB(21, 96, 125, 139),
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.logout, color: Colors.red),
                  ),
                  title: Text('Sign out'),
                  selected: false,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
