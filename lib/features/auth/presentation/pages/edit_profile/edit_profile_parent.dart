import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/pages/edit_profile/edit_profile_desktop.dart';
import 'package:kagojkolom/features/auth/presentation/pages/edit_profile/edit_profile_mobile.dart';
import 'package:kagojkolom/features/auth/presentation/pages/edit_profile/edit_profile_tablet.dart';
import 'package:kagojkolom/shared/responsive/responsive_layout.dart';

class EditProfileParent extends StatelessWidget {
  const EditProfileParent({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: const EditProfileMobile(),
      tabletScaffold: const EditProfileTablet(),
      desktopScaffold: const EditProfileDesktop());
  }
}