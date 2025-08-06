import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/model/user_model.dart';
import 'package:password_manager/modules/auth/service/auth_service.dart';
import 'package:password_manager/modules/auth/widgets/auth_form_button.dart';
import 'package:password_manager/utils/extensions/string_extensions.dart';
import 'package:password_manager/modules/auth/screens/log_in_screen.dart';
import 'package:password_manager/modules/auth/widgets/auth_form_text_field.dart';
import 'package:password_manager/modules/auth/widgets/auth_from_password_field.dart';
import 'package:password_manager/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.05,
            top: size.height * 0.16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Create Account',
                    style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '\nSign up to get started',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                AuthFormTextField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  hintText: 'Full Name',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (!value.isValidUsername()) {
                      return 'Username can\'t contain special characters except\nunderscore  and less than 3 characters.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                AuthFormTextField(
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
                SizedBox(height: size.height * 0.02),
                AuthFormPasswordField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (!value.isValidPassword()) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                AuthFormPasswordField(
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.05),
                AuthFormButton(
                  buttonText: 'Sign Up',
                  onPressed: () => _signUp(context),
                ),
                SizedBox(height: size.height * 0.12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => LogInScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Log In',
                        style: GoogleFonts.bebasNeue(
                          color: Colors.yellowAccent[700],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      UserModel? userModel = await AuthService.instance
          .signUpUserWithEmailAndPassword(
            context,
            _nameController.text,
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
      if (userModel != null) {
        if (!context.mounted) return;
        showErrorSnackbar(context, 'Sign Up Successful', Colors.green);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LogInScreen()),
        );
      }
    }
  }
}
