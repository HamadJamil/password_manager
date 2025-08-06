import 'package:flutter/material.dart';
import 'package:password_manager/theme/app_theme.dart';
import 'package:password_manager/utils/utils.dart';

class FormPasswordField extends StatefulWidget {
  const FormPasswordField({super.key, required this.passwordController});
  final TextEditingController passwordController;

  @override
  State<FormPasswordField> createState() => _FormPasswordFieldState();
}

class _FormPasswordFieldState extends State<FormPasswordField> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: isPasswordVisible,
      obscuringCharacter: '*',
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter a password';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
        prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.generating_tokens, color: Colors.grey[600]),
              onPressed: () => _generatePassword(context),
              tooltip: 'Generate Password',
            ),
            IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppTheme.primaryColor!),
        ),
      ),
    );
  }

  void _generatePassword(BuildContext context) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*';
    final random = DateTime.now().millisecondsSinceEpoch;
    String password = '';

    for (int i = 0; i < 12; i++) {
      password += chars[(random + i) % chars.length];
    }

    setState(() {
      widget.passwordController.text = password;
    });

    showSnackBarContent(
      context,
      'Password generated successfully!',
      Colors.green,
    );
  }
}
