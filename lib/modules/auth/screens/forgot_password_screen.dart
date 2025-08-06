import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/modules/auth/screens/log_in_screen.dart';
import 'package:password_manager/theme/app_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailSent = false;
  bool _isLoading = false;

  void _sendResetEmail() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate sending email (replace with actual implementation)
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _isEmailSent = true;
    });
  }

  void _resendEmail() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate resending email (replace with actual implementation)
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reset email sent again!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],

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
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: AppTheme.textFieldStyle,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              FilledButton(
                onPressed: _isLoading ? null : _sendResetEmail,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(size.width, 50),
                  backgroundColor: Colors.yellowAccent[700],
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child:
                    _isLoading
                        ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black,
                            ),
                          ),
                        )
                        : Text('Send Reset Email'),
              ),
            ] else ...[
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
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
                onPressed: _isLoading ? null : _resendEmail,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(size.width, 50),
                  backgroundColor: Colors.transparent,
                  side: BorderSide(color: Colors.yellowAccent[700]!),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child:
                    _isLoading
                        ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.yellowAccent[700]!,
                            ),
                          ),
                        )
                        : Text(
                          'Resend Email',
                          style: GoogleFonts.poppins(
                            color: Colors.yellowAccent[700],
                            fontSize: 16,
                          ),
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
