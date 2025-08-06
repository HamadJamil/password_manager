import 'package:flutter/material.dart';
import 'package:password_manager/model/password_model.dart';

class HomeScreenProvider with ChangeNotifier {
  final List<PasswordModel> _passwords = [
    PasswordModel(
      id: '1',
      title: 'Facebook',
      username: 'john.doe',
      email: 'john@example.com',
      password: '••••••••',
      website: 'facebook.com',
      category: 'Social Media',
      createdAt: '2025-01-01',
    ),
    PasswordModel(
      id: '2',
      title: 'Chase Bank',
      username: 'johndoe123',
      email: 'john@example.com',
      password: '••••••••',
      website: 'chase.com',
      category: 'Banking',
      createdAt: '2025-01-05',
    ),
    PasswordModel(
      id: '3',
      title: 'Gmail',
      username: '',
      email: 'john.doe@gmail.com',
      password: '••••••••',
      website: 'gmail.com',
      category: 'Email',
      createdAt: '2025-01-10',
    ),
    PasswordModel(
      id: '4',
      title: 'Amazon',
      username: 'john.doe',
      email: 'john@example.com',
      password: '••••••••',
      website: 'amazon.com',
      category: 'Shopping',
      createdAt: '2025-01-15',
    ),
  ];
  String _selectedCategory = 'All';

  List<PasswordModel> get passwords => _passwords;
  String get selectedCategory => _selectedCategory;

  void addPassword(PasswordModel password) {
    _passwords.add(password);
    notifyListeners();
  }

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
}
