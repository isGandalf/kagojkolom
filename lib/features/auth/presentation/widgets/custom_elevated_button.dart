import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.onTap,
    required this.isLoading,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final Future<void> Function() onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          isLoading
              ? null
              : () async {
                if (_formKey.currentState!.validate()) {
                  await onTap();
                }
              },
      child: isLoading ? CircularProgressIndicator.adaptive() : Text('Submit'),
    );
  }
}
