import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/pages/signup/signup_desktop.dart';
import 'package:kagojkolom/features/auth/presentation/pages/signup/signup_mobile.dart';
import 'package:kagojkolom/features/auth/presentation/pages/signup/signup_tablet.dart';
import 'package:kagojkolom/shared/responsive/responsive_layout.dart';

class SignupParent extends StatelessWidget {
  const SignupParent({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: SignupMobile(),
      tabletScaffold: SignupTablet(),
      desktopScaffold: SignupDesktop(),
    );
  }
}
