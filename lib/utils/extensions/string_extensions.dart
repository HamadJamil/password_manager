extension StringExtensions on String {
  bool isValidEmail() {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  bool isValidPassword() {
    return length >= 6;
  }

  bool isValidUsername() {
    return RegExp(r'^[a-zA-Z0-9_ ]{3,}$').hasMatch(this);
  }
}
