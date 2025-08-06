import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/utils/extensions/string_extensions.dart';
import 'package:password_manager/modules/auth/screens/log_in_screen.dart';
import 'package:password_manager/modules/auth/service/auth_service.dart';
import 'package:password_manager/modules/auth/widgets/auth_form_text_field.dart';
import 'package:password_manager/utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailSent = false;
  bool _isLoading = false;

  void _sendResetEmail(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });
    AuthService.instance.forgotPassword(_emailController.text, context);
    if (!context.mounted) return;
    FocusScope.of(context).unfocus();
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _isEmailSent = true;
    });
  }

  void _resendEmail(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    AuthService.instance.forgotPassword(_emailController.text, context);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
    if (!context.mounted) return;
    showSnackBarContent(context, 'Reset email sent again!', Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
          top: size.height * 0.16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Forgot Password?',
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text:
                        _isEmailSent
                            ? '\nCheck your email for reset link'
                            : '\nEnter your email to reset password',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.05),
            if (!_isEmailSent) ...[
              Form(
                key: _formKey,
                child: AuthFormTextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.isValidEmail()) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: size.height * 0.05),
              FilledButton(
                onPressed: _isLoading ? null : () => _sendResetEmail(context),
                child:
                    _isLoading
                        ? buildLoadingIndicator(Colors.black)
                        : Text('Send Reset Email'),
              ),
            ] else ...[
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 30),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email Sent!',
                            style: GoogleFonts.bebasNeue(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Check your email for the password reset link.',
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Didn\'t receive the email?',
                style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
              ),
              SizedBox(height: size.height * 0.02),
              OutlinedButton(
                onPressed: _isLoading ? null : () => _resendEmail(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.yellowAccent[700]!),
                  foregroundColor: Colors.yellowAccent[700],
                ),
                child:
                    _isLoading
                        ? buildLoadingIndicator(Colors.yellowAccent[700]!)
                        : Text(
                          'Resend Email',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
              ),
            ],
            SizedBox(height: size.height * 0.05),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                  );
                },
                child: Text(
                  'Back to Login',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
