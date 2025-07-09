import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/pages/edit_profile/edit_profile_view/edit_profile_view_desktop.dart';
import 'package:kagojkolom/features/auth/presentation/pages/edit_profile/edit_profile_view/edit_profile_view_mobile.dart';
import 'package:kagojkolom/features/auth/presentation/pages/edit_profile/edit_profile_view/edit_profile_view_tablet.dart';
import 'package:kagojkolom/shared/responsive/responsive_layout.dart';

class EditProfileViewParent extends StatelessWidget {
  const EditProfileViewParent({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: EditProfileViewMobile(),
      tabletScaffold: EditProfileViewTablet(),
      desktopScaffold: EditProfileViewDesktop(),
    );
  }
}
