import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/pages/my_profile/my_profile_desktop.dart';
import 'package:kagojkolom/features/auth/presentation/pages/my_profile/my_profile_mobile.dart';
import 'package:kagojkolom/features/auth/presentation/pages/my_profile/my_profile_tablet.dart';
import 'package:kagojkolom/shared/responsive/responsive_layout.dart';

class MyProfileParent extends StatelessWidget {
  const MyProfileParent({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: const MyProfileMobile(),
      tabletScaffold: const MyProfileTablet(),
      desktopScaffold: const MyProfileDesktop(),
    );
  }
}
