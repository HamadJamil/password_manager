import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/model/user_model.dart';
import 'package:password_manager/modules/auth/service/auth_service.dart';
import 'package:password_manager/modules/auth/widgets/auth_form_button.dart';
import 'package:password_manager/modules/home/provider/home_screen_provider.dart';
import 'package:password_manager/utils/extensions/string_extensions.dart';
import 'package:password_manager/modules/auth/screens/forgot_password_screen.dart';
import 'package:password_manager/modules/auth/widgets/auth_form_text_field.dart';
import 'package:password_manager/modules/auth/widgets/auth_from_password_field.dart';
import 'package:password_manager/modules/home/screens/home_screen.dart';
import 'package:password_manager/modules/auth/screens/sign_up_screen.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
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
                    text: 'Welcome Back',
                    style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '\nLogin to your account',
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
                      return 'Please enter a valid email';
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
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                AuthFormButton(
                  buttonText: 'Log In',
                  onPressed: () => _login(context),
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Divider(color: Colors.white54, thickness: 1),
                      ),
                    ),
                    Text(
                      'OR',
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Divider(color: Colors.white54, thickness: 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.white54),
                  label: Text(
                    'Continue with Google',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ),

                SizedBox(height: size.height * 0.1),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
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
                            builder: (builder) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
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

  void _login(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      UserModel? userModel = await AuthService.instance
          .loginInWithEmailAndPassword(
            context,
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
      if (userModel != null) {
        if (!context.mounted) return;
        showErrorSnackbar(context, 'Login Successful', Colors.green);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => ChangeNotifierProvider(
                  create: (_) => HomeScreenProvider(),
                  child: HomeScreen(),
                ),
          ),
        );
      }
    }
  }
}
