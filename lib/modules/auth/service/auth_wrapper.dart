import 'package:flutter/material.dart';
import 'package:password_manager/modules/auth/screens/log_in_screen.dart';
import 'package:password_manager/modules/auth/service/auth_service.dart';
import 'package:password_manager/modules/home/provider/home_screen_provider.dart';
import 'package:password_manager/modules/home/screens/home_screen.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.instance.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
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
