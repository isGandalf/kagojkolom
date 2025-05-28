import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/tablet_drawer_icon.dart';

class TabletLeftColumn extends StatelessWidget {
  const TabletLeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TabletDrawerIcon(onPressed: () {}, icon: Icons.notes),
              TabletDrawerIcon(onPressed: () {}, icon: Icons.favorite),
              TabletDrawerIcon(onPressed: () {}, icon: Icons.share),
              TabletDrawerIcon(
                onPressed: () {},
                icon: Icons.calendar_month_outlined,
              ),
            ],
          ),

          Column(
            children: [
              TabletDrawerIcon(onPressed: () {}, icon: Icons.delete_forever),
              TabletDrawerIcon(onPressed: () {}, icon: Icons.logout),
            ],
          ),
        ],
      ),
    );
  }
}
