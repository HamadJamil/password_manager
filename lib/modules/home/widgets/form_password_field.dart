import 'package:flutter/material.dart';
import 'package:password_manager/theme/app_theme.dart';

class FormPasswordField extends StatelessWidget {
  const FormPasswordField({
    super.key,
    required this.passwordController,
    this.isPasswordVisible = false,
  });
  final TextEditingController passwordController;
  final bool isPasswordVisible;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: !isPasswordVisible,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter a password';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
        prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.generating_tokens),
              onPressed: () => _generatePassword(context),
              tooltip: 'Generate Password',
            ),
            IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                // setState(() {
                //   isPasswordVisible = isPasswordVisible;
                // });
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
    // // Simple password generation - you can make this more sophisticated
    // const chars =
    //     'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*';
    // final random = DateTime.now().millisecondsSinceEpoch;
    // String password = '';

    // for (int i = 0; i < 12; i++) {
    //   password += chars[(random + i) % chars.length];
    // }

    // // setState(() {
    // //   passwordController.text = password;
    // //   isPasswordVisible = true;
    // // });

    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text('Password generated successfully!')));
  }
}
