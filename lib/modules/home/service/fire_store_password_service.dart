import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:password_manager/model/password_model.dart';
import 'package:password_manager/modules/auth/service/auth_service.dart';

class FireStorePasswordService {
  FireStorePasswordService._();

  static FireStorePasswordService get instance => FireStorePasswordService._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser = AuthService.instance.currentUser;

  Future<void> addNewPassword(PasswordModel password) async {
    try {
      await _firestore
          .collection('users')
          .doc(_currentUser?.uid)
          .collection('passwords')
          .doc(password.id)
          .set(password.toJson());
    } catch (e) {
      debugPrint('Failed to create password entry : $e');
    }
  }

  Future<void> deletePassword(String passwordId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_currentUser?.uid)
          .collection('passwords')
          .doc(passwordId)
          .delete();
    } catch (e) {
      debugPrint('Failed to delete password Entry : $e');
    }
  }

  Future<void> updatePassword(PasswordModel password) async {
    try {
      await _firestore
          .collection('users')
          .doc(_currentUser?.uid)
          .collection('passwords')
          .doc(password.id)
          .update(password.toJson());
    } catch (e) {
      debugPrint('Failed to update password entry : $e');
    }
  }

  Future<List<PasswordModel>> getPasswords() async {
    return await _firestore
        .collection('users')
        .doc(_currentUser?.uid)
        .collection('passwords')
        .get()
        .then((snapshot) {
          return snapshot.docs.map((doc) {
            return PasswordModel.fromJson(doc.data());
          }).toList();
        });
  }
}
