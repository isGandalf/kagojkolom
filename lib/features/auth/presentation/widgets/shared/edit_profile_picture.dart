import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';

class EditProfilePicture extends StatelessWidget {
  const EditProfilePicture({super.key, required this.profilePictureUrl});

  final String? profilePictureUrl;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: const CircleBorder(),
      child: InkWell(
        hoverColor: AppColorsCommon.primaryBlue,
        onTap: () {},

        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 140,
            width: 140,
            child: Stack(
              children: [
                ClipOval(
                  child: Image.asset(
                    profilePictureUrl ?? 'lib/assets/images/2151100221.jpg',
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: 50,
                      height: 25,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(101, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Edit',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
