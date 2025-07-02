import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';

class EditProfilePicture extends StatefulWidget {
  const EditProfilePicture({super.key, required this.profilePictureUrl, required this.onAvatarChanged});

  final String profilePictureUrl;
  final void Function(String) onAvatarChanged;

  @override
  State<EditProfilePicture> createState() => _EditProfilePictureState();
}

class _EditProfilePictureState extends State<EditProfilePicture> {
  late String selectedAvatar;

  @override
  void initState() {
    super.initState();
    selectedAvatar = widget.profilePictureUrl;
  }

  void avatarPicker(BuildContext context, Color containerColor) {
    final List<String> avatarList = [
      'lib/assets/images/2151100221.jpg',
      'lib/assets/images/ava-1.jpg',
      'lib/assets/images/ava-2.jpg',
      'lib/assets/images/ava-3.jpg',
      'lib/assets/images/ava-4.jpg',
      'lib/assets/images/ava-5.jpg',
      'lib/assets/images/ava-6.jpg',
      'lib/assets/images/ava-7.jpg',
      'lib/assets/images/ava-8.jpg',
      'lib/assets/images/ava-9.jpg',
      'lib/assets/images/ava-10.jpg',
      'lib/assets/images/ava-11.jpg',
      'lib/assets/images/ava-12.jpg',
    ];

    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Text('Choose your avatar', style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  children: [
                    ...avatarList.map((avatar) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Material(
                          clipBehavior: Clip.antiAlias,
                          shape: const CircleBorder(),
                          child: InkWell(
                            hoverColor: AppColorsCommon.primaryBlue,
                            onTap: () {
                              setState(() {
                                selectedAvatar = avatar;
                              });
                              widget.onAvatarChanged(avatar);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipOval(
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(avatar),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color containerColor =
        isDarkTheme
            ? AppColorsDark.drawerBackgroundColor
            : AppColorsLight.drawerBackgroundColor;
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: const CircleBorder(),
      child: InkWell(
        hoverColor: AppColorsCommon.primaryBlue,
        onTap: () {
          avatarPicker(context, containerColor);
        },

        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 140,
            width: 140,
            child: Stack(
              children: [
                ClipOval(child: Image.asset(selectedAvatar)),
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
