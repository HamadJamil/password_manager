import 'package:flutter/material.dart';
import 'package:password_manager/utils/utils.dart';

class AuthFormButton extends StatefulWidget {
  const AuthFormButton({super.key, required this.buttonText, this.onPressed});
  final String buttonText;
  final VoidCallback? onPressed;

  @override
  State<AuthFormButton> createState() => _AuthFormButtonState();
}

class _AuthFormButtonState extends State<AuthFormButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed:
          isLoading
              ? null
              : () {
                setState(() {
                  isLoading = true;
                });
                widget.onPressed!();
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    isLoading = false;
                  });
                });
              },
      child:
          isLoading
              ? buildLoadingIndicator(Colors.black)
              : Text(widget.buttonText),
    );
  }
}
