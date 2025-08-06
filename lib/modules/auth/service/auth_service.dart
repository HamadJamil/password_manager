import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/model/user_model.dart';
import 'package:password_manager/modules/auth/service/fire_store_service.dart';
import 'package:password_manager/utils/utils.dart';

class AuthService {
  AuthService._();

  static AuthService get instance => AuthService._();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FireStoreService _fireStoreService = FireStoreService.instance;

  User? get currentUser => _auth.currentUser;
  bool get isUserLoggedIn => _auth.currentUser != null;
  String? get userId => _auth.currentUser?.uid;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserModel?> signUpUserWithEmailAndPassword(
    BuildContext context,
    String name,
    String email,
    String password,
  ) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        final UserModel userModel = UserModel(
          id: result.user!.uid,
          name: name,
          email: email,
          password: password,
          createdAt: DateTime.now().toString(),
        );
        await _fireStoreService.createUser(userModel);
        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return null;
      showErrorSnackbar(context, getMessageFromErrorCode(e.code), Colors.red);
    }
    return null;
  }

  Future<UserModel?> loginInWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        final UserModel? userModel = await _fireStoreService.getUserById(
          result.user!.uid,
        );
        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return null;
      showErrorSnackbar(context, getMessageFromErrorCode(e.code), Colors.red);
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint('Failed to sign out: $e');
    }
  }

  Future<void> forgotPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showErrorSnackbar(context, getMessageFromErrorCode(e.code), Colors.red);
    }
  }
}
