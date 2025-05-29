import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/pages/splashscreen/splashscreen_desktop.dart';
import 'package:kagojkolom/features/auth/presentation/pages/splashscreen/splashscreen_mobile.dart';
import 'package:kagojkolom/features/auth/presentation/pages/splashscreen/splashscreen_tablet.dart';
import 'package:kagojkolom/shared/responsive/responsive_layout.dart';

class SplashscreenParent extends StatelessWidget {
  const SplashscreenParent({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileScaffold: SplashscreenMobile(),
      tabletScaffold: SplashscreenTablet(),
      desktopScaffold: SplashscreenDesktop(),
    );
  }
}
