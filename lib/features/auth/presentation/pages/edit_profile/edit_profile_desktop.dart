import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/pages/edit_profile/edit_profile_view/edit_profile_view_parent.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_for_about_setting.dart';

class EditProfileDesktop extends StatelessWidget {
  const EditProfileDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForAboutSetting(),
      body: Center(
        heightFactor: 1.2,
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 700, maxHeight: 550),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                BackButton(onPressed: () => Navigator.pop(context)),
                SizedBox(width: 15),

                // edit profile view
                Flexible(fit: FlexFit.loose, child: EditProfileViewParent()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
