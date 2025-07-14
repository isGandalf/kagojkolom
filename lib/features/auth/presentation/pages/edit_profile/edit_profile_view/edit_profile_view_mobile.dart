import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/edit_profile_buttons.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/edit_profile_picture.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/edit_user_name.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/delete_all_notes.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';

class EditProfileViewMobile extends StatefulWidget {
  const EditProfileViewMobile({super.key});

  @override
  State<EditProfileViewMobile> createState() => _EditProfileViewMobileState();
}

class _EditProfileViewMobileState extends State<EditProfileViewMobile> {
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late String _profilePictureUrl;

  String? selectedAvatar;

  @override
  void initState() {
    super.initState();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _profilePictureUrl = '';
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    super.dispose();
  }

  Future<dynamic> updateUserFailed(
    BuildContext context,
    UpdateUserDetailsFailedActionState state,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(Icons.cancel_outlined, size: 30),
          iconColor: Colors.redAccent.shade400,
          iconPadding: EdgeInsets.all(10),
          content: Text(state.message),
        );
      },
    );
  }

  Future<dynamic> updateUserSuccess(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(Icons.check_circle_outline_outlined, size: 30),
          iconColor: Colors.lightGreen,
          iconPadding: EdgeInsets.all(10),
          content: Text('Updated successfully'),
        );
      },
    );
  }

  void _updateProfilePicture(String newAvatar) {
    setState(() {
      _profilePictureUrl = newAvatar;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return BlocConsumer<UserBloc, UserState>(
      listenWhen: (previous, current) => current is UserActionStates,
      listener: (context, state) {
        if (state is UpdateUserDetailsSuccessActionState) {
          updateUserSuccess(context);
        }
        if (state is UpdateUserDetailsFailedActionState) {
          updateUserFailed(context, state);
        }
      },
      builder: (context, state) {
        if (state is LoggedInUserState) {
          final firstName = state.userEntity.firstName;
          final lastName = state.userEntity.lastName;
        
          // set the data from state to controllers
          _firstName.text = firstName;
          _lastName.text = lastName;
        
          // set profilePicture
          if (_profilePictureUrl.isEmpty) {
            _profilePictureUrl = state.userEntity.profilePictureUrl;
          }
        
          // main column - holds all data on view
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              // heading
              Text(
                'Edit profile',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 25),
        
              // Profile picture
              EditProfilePicture(
                profilePictureUrl: _profilePictureUrl,
                onAvatarChanged: _updateProfilePicture,
              ),
              const SizedBox(height: 30),
        
              // two text feilds for name
              EditUserName(
                firstName: _firstName,
                isDarkTheme: isDarkTheme,
                lastName: _lastName,
              ),
              const SizedBox(height: 30),
        
              // delete all notes feature
              Divider(),
              DeleteAllNotes(),
              Divider(),
              const SizedBox(height: 30),
        
              // buttons to save and cancel
              EditProfileButtons(
                firstName: _firstName,
                lastName: _lastName,
                profilePictureUrl: _profilePictureUrl,
              ),
              const SizedBox(height: 20),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
