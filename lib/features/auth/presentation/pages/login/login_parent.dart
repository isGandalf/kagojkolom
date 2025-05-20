import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/pages/login/login_desktop.dart';
import 'package:kagojkolom/features/auth/presentation/pages/login/login_mobile.dart';
import 'package:kagojkolom/features/auth/presentation/pages/login/login_tablet.dart';
import 'package:kagojkolom/shared/responsive/responsive_layout.dart';

class LoginParent extends StatelessWidget {
  const LoginParent({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: LoginMobile(),
      tabletScaffold: LoginTablet(),
      desktopScaffold: LoginDesktop(),
    );
  }
}
