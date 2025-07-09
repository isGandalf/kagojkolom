import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/pages/my_profile/my_profile_parent.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';

class EditProfileButtons extends StatelessWidget {
  const EditProfileButtons({
    super.key,
    required TextEditingController firstName,
    required TextEditingController lastName,
    required this.profilePictureUrl,
  }) : _firstName = firstName,
       _lastName = lastName;

  final TextEditingController _firstName;
  final TextEditingController _lastName;
  final String? profilePictureUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },

            child: Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
        ),
        SizedBox(width: 20),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              context.read<UserBloc>().add(
                UpdateUserDetailsButtonPressedEvent(
                  firstName: _firstName.text,
                  lastName: _lastName.text,
                  profilePictureUrl: profilePictureUrl!,
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyProfileParent(),
                ),
                (route) => false,
              );
            },

            child: Text(
              'Save changes',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
