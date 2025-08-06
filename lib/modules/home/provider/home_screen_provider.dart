import 'package:flutter/material.dart';
import 'package:password_manager/model/password_model.dart';
import 'package:password_manager/modules/home/service/fire_store_password_service.dart';

class HomeScreenProvider with ChangeNotifier {
  final FireStorePasswordService _fireStorePasswordService =
      FireStorePasswordService.instance;
  final List<PasswordModel> _passwords =
      //  [
      //   PasswordModel(
      //     id: '1',
      //     title: 'Facebook',
      //     username: 'john.doe',
      //     email: 'john@example.com',
      //     password: '••••••••',
      //     website: 'facebook.com',
      //     category: 'Social Media',
      //     createdAt: '2025-01-01',
      //   ),
      //   PasswordModel(
      //     id: '2',
      //     title: 'Chase Bank',
      //     username: 'johndoe123',
      //     email: 'john@example.com',
      //     password: '••••••••',
      //     website: 'chase.com',
      //     category: 'Banking',
      //     createdAt: '2025-01-05',
      //   ),
      //   PasswordModel(
      //     id: '3',
      //     title: 'Gmail',
      //     username: '',
      //     email: 'john.doe@gmail.com',
      //     password: '••••••••',
      //     website: 'gmail.com',
      //     category: 'Email',
      //     createdAt: '2025-01-10',
      //   ),
      //   PasswordModel(
      //     id: '4',
      //     title: 'Amazon',
      //     username: 'john.doe',
      //     email: 'john@example.com',
      //     password: '••••••••',
      //     website: 'amazon.com',
      //     category: 'Shopping',
      //     createdAt: '2025-01-15',
      //   ),
      // ];
      [];

  String _selectedCategory = 'All';

  List<PasswordModel> get passwords => _passwords;
  String get selectedCategory => _selectedCategory;

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<PasswordModel> get filteredPasswords {
    if (_selectedCategory == 'All') return _passwords;
    return _passwords.where((p) => p.category == _selectedCategory).toList();
  }

  int passwordCategoryLength(String selectedCategory) {
    if (selectedCategory == 'All') return _passwords.length;
    return _passwords.where((p) => p.category == selectedCategory).length;
  }

  Future<void> fetchPasswords() async {
    _passwords.clear();
    _passwords.addAll(await _fireStorePasswordService.getPasswords());
    debugPrint('Fetch Password');
    notifyListeners();
  }

  Future<void> addNewPassword(PasswordModel password) async {
    await _fireStorePasswordService.addNewPassword(password);
    debugPrint('Add New Password');
    await fetchPasswords();
  }

  Future<void> deletePassword(String passwordId) async {
    await _fireStorePasswordService.deletePassword(passwordId);
    debugPrint('Delete Password');
    await fetchPasswords();
  }

  Future<void> updatePassword(PasswordModel password) async {
    await _fireStorePasswordService.updatePassword(password);
    debugPrint('Update Password');
    await fetchPasswords();
  }
}
