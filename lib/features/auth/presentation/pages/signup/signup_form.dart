import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/pages/login/login_parent.dart';
import 'package:kagojkolom/features/auth/presentation/pages/signup/signup_parent.dart';
import 'package:kagojkolom/shared/widgets/custom_dialog_box_with_one_button.dart';
import 'package:kagojkolom/shared/widgets/custom_elevated_button.dart';
import 'package:kagojkolom/shared/widgets/custom_text_form_field.dart';
import 'package:logger/logger.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final logger = Logger();

  // controllers for the text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocConsumer<SignupBloc, SignupState>(
        listenWhen: (previous, current) => current is SignupActionState,
        listener: (context, state) async {
          if (state is SignupSuccessActionState) {
            final message = state.message;
            await customDialogBoxWithOneButton(
              context,
              message,
              Icons.check_circle_rounded,
              Colors.green,
              'Okay',
              () => Navigator.of(context).pop(),
            );
            if (!context.mounted) return;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginParent()),
              (route) => false,
            );
          } else if (state is SignupFailedActionState) {
            final message = state.message;
            await customDialogBoxWithOneButton(
              context,
              message,
              Icons.error_outline_sharp,
              Colors.red,
              'Okay',
              () => Navigator.of(context).pop(),
            );
            if (!context.mounted) return;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignupParent()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is SignupLoadingState;

          return Scaffold(
            body: Center(
              child: SizedBox(
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30),
                          Text(
                            'Create an account',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 40),
                          CustomTextFormField(
                            hintText: 'First name',
                            controller: _firstNameController,
                            disabled: isLoading,
                            isObscure: false,
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: 'Last name',
                            controller: _lastNameController,
                            disabled: isLoading,
                            isObscure: false,
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: 'email',
                            controller: _emailController,
                            disabled: isLoading,
                            isObscure: false,
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            hintText: 'Password',
                            controller: _passwordController,
                            disabled: isLoading,
                            isObscure: true,
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: CustomElevatedButton(
                              formKey: _formKey,
                              onTap: () async {
                                context.read<SignupBloc>().add(
                                  SignupButtonPressedEvent(
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              },
                              isLoading: isLoading,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text.rich(
                            TextSpan(
                              text: 'Already have an account? ',
                              children: <InlineSpan>[
                                TextSpan(
                                  text: ' Click here',
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      const LoginParent(),
                                            ),
                                          );
                                        },
                                  style: TextStyle(
                                    color: AppColorsCommon.primaryBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
