import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/tablet/tablet_drawer_icon.dart';

class TabletLeftColumn extends StatelessWidget {
  final void Function(int) onPageSelect;
  final int selectedPage;
  const TabletLeftColumn({
    super.key,
    required this.onPageSelect,
    required this.selectedPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TabletDrawerIcon(
                onPressed: () {
                  onPageSelect(0);
                },
                icon: Icons.notes,
                isSelected: selectedPage == 0,
              ),
              TabletDrawerIcon(
                onPressed: () {
                  onPageSelect(1);
                },
                icon: Icons.favorite,
                isSelected: selectedPage == 1,
              ),
              TabletDrawerIcon(
                onPressed: () {
                  onPageSelect(2);
                },
                icon: Icons.share,
                isSelected: selectedPage == 2,
              ),
              TabletDrawerIcon(
                onPressed: () {
                  onPageSelect(3);
                },
                icon: Icons.calendar_month_outlined,
                isSelected: selectedPage == 3,
              ),
            ],
          ),

          Column(
            children: [
              TabletDrawerIcon(
                onPressed: () {
                  onPageSelect(4);
                },
                icon: Icons.delete_forever,
                isSelected: selectedPage == 4,
              ),
              TabletDrawerIcon(
                onPressed: () {
                  onPageSelect(5);
                },
                icon: Icons.logout,
                isSelected: selectedPage == 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
