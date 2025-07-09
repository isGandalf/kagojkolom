import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';

class ResetPasswordAlertBox extends StatefulWidget {
  const ResetPasswordAlertBox({super.key});

  @override
  State<ResetPasswordAlertBox> createState() => _ResetPasswordAlertBoxState();
}

class _ResetPasswordAlertBoxState extends State<ResetPasswordAlertBox> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'An email will be sent with a reset password link',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(hintText: 'Email'),
            controller: _emailController,
          ),
        ],
      ),
      actions: [
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Close',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (_emailController.text.isNotEmpty) {
                context.read<UserBloc>().add(
                  ResetPasswordButtonPressedEvent(email: _emailController.text),
                );
                Navigator.of(context).pop();
              }
            },
            child: Text(
              'Send email',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
