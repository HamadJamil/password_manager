import 'package:flutter/material.dart';
import 'package:password_manager/modules/auth/screens/log_in_screen.dart';
import 'package:password_manager/modules/auth/screens/verification_email_screen.dart';
import 'package:password_manager/modules/auth/service/auth_service.dart';
import 'package:password_manager/modules/home/provider/home_screen_provider.dart';
import 'package:password_manager/modules/home/screens/home_screen.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.instance.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: buildLoadingIndicator(Colors.blue)),
          );
        }
        if (snapshot.hasData) {
          if (AuthService.instance.currentUser?.emailVerified == false) {
            return const VerificationEmailScreen();
          }
          return ChangeNotifierProvider(
            create: (context) => HomeScreenProvider(),
            child: HomeScreen(),
          );
        }
        return const LogInScreen();
      },
    );
  }
}
