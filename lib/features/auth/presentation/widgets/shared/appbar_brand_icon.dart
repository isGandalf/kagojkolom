import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/homepage_parent.dart';

class AppBarBrandIcon extends StatelessWidget {
  const AppBarBrandIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width < 1200;
    return isTablet ? BrandIconForTablet() : BrandIconForDesktop();
  }
}

class BrandIconForDesktop extends StatelessWidget {
  const BrandIconForDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomepageParent();
                },
              ),
            ),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset('lib/assets/images/icon.png'),
              ),
              SizedBox(width: 10),
              Text(
                'KagojKolom',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class BrandIconForTablet extends StatelessWidget {
  const BrandIconForTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomepageParent();
                },
              ),
            ),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset('lib/assets/images/icon.png'),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
