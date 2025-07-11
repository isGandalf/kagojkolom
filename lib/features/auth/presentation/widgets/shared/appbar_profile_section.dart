import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/profile_popup.dart';

class AppBarProfileSection extends StatelessWidget {
  const AppBarProfileSection({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
  });

  final String firstName;
  final String lastName;
  final String? profilePicture;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          profilePopUp(context);
        },
        child: SizedBox(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  firstName,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 40,
                width: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    profilePicture ?? 'lib/assets/images/2151100221.jpg',
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
