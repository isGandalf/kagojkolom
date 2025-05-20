import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/homepage_desktop.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/homepage_mobile.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/homepage_tablet.dart';
import 'package:kagojkolom/shared/responsive/responsive_layout.dart';

class HomepageParent extends StatelessWidget {
  const HomepageParent({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: HomepageMobile(),
      tabletScaffold: HomepageTablet(),
      desktopScaffold: HomepageDesktop(),
    );
  }
}
