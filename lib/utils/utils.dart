import 'package:flutter/material.dart';
import 'package:password_manager/utils/data/categories.dart';

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case 'user-not-found':
      return 'No user found for that email.';
    case 'wrong-password':
      return 'Wrong password provided for that user.';
    case 'email-already-in-use':
      return 'The email address is already in use by another account.';
    case 'weak-password':
      return 'The password provided is too weak.';
    case 'too-many-requests':
      return 'Too many requests. Please try again later.';
    case 'invalid-email':
      return 'The email address is not valid.';
    case 'operation-not-allowed':
      return 'This operation is not allowed.';
    default:
      return 'An unknown error occurred. Please try again later.';
  }
}

Color getCategoryColor(String category) {
  final categoryData = categories.firstWhere(
    (c) => c['name'] == category,
    orElse: () => {'color': Colors.grey},
  );
  return categoryData['color'];
}

IconData getCategoryIcon(String category) {
  final categoryData = categories.firstWhere(
    (c) => c['name'] == category,
    orElse: () => {'icon': Icons.lock},
  );
  return categoryData['icon'];
}

String formatDate(String dateString) {
  if (dateString.isEmpty) return 'Unknown';
  try {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return '$difference days ago';
    if (difference < 30) return '${(difference / 7).floor()} weeks ago';
    return '${(difference / 30).floor()} months ago';
  } catch (e) {
    return dateString;
  }
}

void showSnackBarContent(BuildContext context, Object error, Color color) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text("$error"), backgroundColor: color));
}

Widget buildLoadingIndicator(Color color) {
  return SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation<Color>(color),
    ),
  );
}
