import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/utils/utils.dart';

class FormPasswordButton extends StatefulWidget {
  const FormPasswordButton({
    super.key,
    required this.onPressed,
    required this.isEditing,
  });
  final VoidCallback onPressed;
  final bool isEditing;

  @override
  State<FormPasswordButton> createState() => _FormPasswordButtonState();
}

class _FormPasswordButtonState extends State<FormPasswordButton> {
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
                widget.onPressed();
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    isLoading = false;
                  });
                });
              },
      child:
          isLoading
              ? buildLoadingIndicator(Colors.black)
              : Text(
                widget.isEditing ? 'Update Password' : 'Save Password',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
    );
  }
}
