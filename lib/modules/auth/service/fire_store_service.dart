import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/model/user_model.dart';
import 'package:password_manager/modules/auth/service/auth_service.dart';

class FireStoreService {
  FireStoreService._();

  static FireStoreService get instance => FireStoreService._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  get userStream =>
      _firestore
          .collection('users')
          .doc(AuthService.instance.userId)
          .snapshots();

  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      debugPrint('Failed to create user in Firestore: $e');
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      final DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(userId).get();
      if (documentSnapshot.exists) {
        return UserModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>,
        );
      }
    } catch (e) {
      debugPrint('Failed to get user from Firestore: $e');
    }
    return null;
  }

  Future<void> updateUUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).update(user.toJson());
    } catch (e) {
      debugPrint('Failed to update user in Firestore: $e');
    }
  }
}
