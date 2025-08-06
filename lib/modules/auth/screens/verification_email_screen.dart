import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/modules/auth/service/auth_service.dart';
import 'package:password_manager/utils/utils.dart';

class VerificationEmailScreen extends StatefulWidget {
  const VerificationEmailScreen({super.key});

  @override
  State<VerificationEmailScreen> createState() =>
      _VerificationEmailScreenState();
}

class _VerificationEmailScreenState extends State<VerificationEmailScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          'Check your email inbox for the email verification link.',
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
              onPressed:
                  isLoading
                      ? null
                      : () {
                        setState(() {
                          isLoading = true;
                        });
                        AuthService.instance.verifyEmail(context);
                        Future.delayed(const Duration(seconds: 2));

                        setState(() {
                          isLoading = false;
                        });
                      },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.yellowAccent[700]!),
                foregroundColor: Colors.yellowAccent[700],
              ),
              child:
                  isLoading
                      ? buildLoadingIndicator(Colors.yellowAccent[700]!)
                      : Text(
                        'Resend Email',
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
