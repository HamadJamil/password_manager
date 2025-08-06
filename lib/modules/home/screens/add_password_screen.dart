import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/modules/home/service/fire_store_password_service.dart';
import 'package:password_manager/modules/home/widgets/form_password_button.dart';
import 'package:password_manager/utils/data/categories.dart';
import 'package:password_manager/modules/home/widgets/form_password_field.dart';
import 'package:password_manager/modules/home/widgets/form_text_field.dart';
import 'package:password_manager/theme/app_theme.dart';
import 'package:password_manager/model/password_model.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPasswordScreen extends StatefulWidget {
  final PasswordModel? passwordToEdit;

  const AddPasswordScreen({super.key, this.passwordToEdit});

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _websiteController = TextEditingController();

  String _selectedCategory = 'Social Media';

  @override
  void initState() {
    super.initState();
    if (widget.passwordToEdit != null) {
      _populateFields();
    }
  }

  void _populateFields() {
    final password = widget.passwordToEdit!;
    _titleController.text = password.title ?? '';
    _usernameController.text = password.username ?? '';
    _emailController.text = password.email ?? '';
    _passwordController.text = password.password ?? '';
    _websiteController.text = password.website ?? '';
    _selectedCategory = password.category ?? 'Social Media';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.passwordToEdit != null;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? 'Edit Password' : 'Add New Password',
          style: GoogleFonts.bebasNeue(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),

                      _buildSectionTitle('Title'),
                      FormTextField(
                        controller: _titleController,
                        hintText: 'e.g., Facebook, Gmail, Bank Account',
                        prefixIcon: Icons.title,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      _buildSectionTitle('Category'),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCategory,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey[600],
                            ),
                            items:
                                categories.map((category) {
                                  return DropdownMenuItem<String>(
                                    value: category['name'],
                                    child: Row(
                                      children: [
                                        Icon(
                                          category['icon'],
                                          color: category['color'],
                                          size: 20,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          category['name'],
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      _buildSectionTitle('Login Credentials'),
                      FormTextField(
                        controller: _usernameController,
                        hintText: 'Username (optional)',
                        prefixIcon: Icons.person,
                      ),
                      SizedBox(height: 16),
                      FormTextField(
                        controller: _emailController,
                        hintText: 'Email (optional)',
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),
                      FormPasswordField(
                        passwordController: _passwordController,
                      ),
                      SizedBox(height: 20),

                      // Website Field
                      _buildSectionTitle('Website/App'),
                      FormTextField(
                        controller: _websiteController,
                        hintText: 'e.g., facebook.com, gmail.com',
                        prefixIcon: Icons.language,
                        keyboardType: TextInputType.url,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Save Button
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: FormPasswordButton(
              onPressed:
                  () =>
                      widget.passwordToEdit != null
                          ? updatePassword(context)
                          : _savePassword(context),
              isEditing: isEditing,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.grey[700],
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _savePassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    PasswordModel passwordModel = PasswordModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      username: _usernameController.text,
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      website: _websiteController.text.trim(),
      category: _selectedCategory,
      createdAt: DateTime.now().toIso8601String(),
    );
    context.read<FireStorePasswordService>().addNewPassword(passwordModel);
    await Future.delayed(Duration(seconds: 1));

    if (!context.mounted) return;
    showSnackBarContent(context, 'Password saved successfully!', Colors.green);
    Navigator.pop(context);
  }

  void updatePassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    PasswordModel passwordModel = PasswordModel(
      id: widget.passwordToEdit?.id,
      title: _titleController.text,
      username: _usernameController.text,
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      website: _websiteController.text.trim(),
      category: _selectedCategory,
      createdAt:
          widget.passwordToEdit?.createdAt ?? DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
    context.read<FireStorePasswordService>().updatePassword(passwordModel);
    await Future.delayed(Duration(seconds: 1));

    if (!context.mounted) return;
    showSnackBarContent(
      context,
      'Password updated successfully!',
      Colors.green,
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _websiteController.dispose();
    super.dispose();
  }
}
