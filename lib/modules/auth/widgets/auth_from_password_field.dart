import 'package:flutter/material.dart';
import 'package:password_manager/theme/app_theme.dart';

class AuthFormPasswordField extends StatefulWidget {
  const AuthFormPasswordField({
    super.key,
    this.controller,
    this.validator,
    this.hintText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.visiblePassword,
  });
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;

  @override
  State<AuthFormPasswordField> createState() => _AuthFormPasswordFieldState();
}

class _AuthFormPasswordFieldState extends State<AuthFormPasswordField> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.prefixIcon),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
      ),
      obscuringCharacter: '*',
      keyboardType: widget.keyboardType,
      obscureText: !isPasswordVisible,
      style: AppTheme.textFieldStyle,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
