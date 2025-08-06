import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/model/user_model.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FireStoreService _fireStoreService = FireStoreService.instance;

  User? get currentUser => _auth.currentUser;

  Future<UserModel?> createUserWithEmailAndPassword(
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
    } catch (e) {
      debugPrint('Failed to create user: $e');
    }
    return null;
  }

  Future<UserModel?> loginInWithEmailAndPassword(
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
    } catch (e) {
      debugPrint('Failed to login: $e');
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

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint('Failed to send password reset email: $e');
    }
  }
}
