import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/auth/presentation/pages/my_profile/my_profile_desktop.dart';
import 'package:kagojkolom/features/auth/presentation/pages/my_profile/my_profile_mobile.dart';
import 'package:kagojkolom/features/auth/presentation/pages/my_profile/my_profile_tablet.dart';
import 'package:kagojkolom/features/auth/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/homepage_parent.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_brand_icon.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_for_about_setting.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_profile_section.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';
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
