import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/global/logger.dart';
import 'package:kagojkolom/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/homepage_parent.dart';
import 'package:kagojkolom/features/auth/presentation/pages/login/login_parent.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';
import 'package:kagojkolom/shared/widgets/custom_dialog_box_with_one_button.dart';
import 'package:kagojkolom/shared/widgets/custom_elevated_button.dart';
import 'package:kagojkolom/shared/widgets/custom_text_form_field.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) => current is LoginActionState,
      buildWhen: (previous, current) => current is LoginStandardState,
      listener: (context, state) async {
        logger.d(state.runtimeType);
        if (state is LoginFailedActionState) {
          final message = state.message;
          await customDialogBoxWithOneButton(
            context,
            message,
            Icons.error_outline_sharp,
            Colors.red,
            'Okay',
            () => Navigator.of(context).pop(),
          );
          if (!context.mounted) {
            return;
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginParent()),
            (route) => false,
          );
        } else if (state is LoginSuccessActionState) {
          final userEntity = state.userEntity;
          context.read<UserBloc>().add(LoadUserEvent(userEntity: userEntity));
          context.read<NotesBloc>().add(
            NotePageInitialEvent(notePageType: NotePageType.myNotes),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomepageParent()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        logger.d(state.runtimeType);
        final isLoading = state is LoginLoadingState;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Center(
              child: SizedBox(
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'KagojKolom',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Your thoughts, neatly penned',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 40),
                          CustomTextFormField(
                            hintText: 'Email',
                            controller: _emailController,
                            disabled: isLoading,
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: 'Password',
                            controller: _passwordController,
                            disabled: isLoading,
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: CustomElevatedButton(
                              formKey: _formKey,
                              onTap: () async {
                                context.read<LoginBloc>().add(
                                  LoginButtonPressedEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              },
                              isLoading: isLoading,
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
