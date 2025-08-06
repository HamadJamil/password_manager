import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/utils/data/categories.dart';
import 'package:password_manager/modules/home/provider/home_screen_provider.dart';
import 'package:password_manager/modules/home/widgets/category_card.dart';
import 'package:password_manager/modules/home/widgets/empty_list_state.dart';
import 'package:password_manager/modules/home/widgets/password_card.dart';
import 'package:password_manager/theme/app_theme.dart';
import 'package:password_manager/modules/home/screens/add_password_screen.dart';
import 'package:password_manager/modules/profile/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedCategory =
        context.watch<HomeScreenProvider>().selectedCategory;
    final filteredPasswords =
        context.read<HomeScreenProvider>().filteredPasswords;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'Password Manager',
          style: GoogleFonts.bebasNeue(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.primaryColor,
              child: Icon(Icons.person, color: Colors.black, size: 20),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          SizedBox(width: size.width * 0.02),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.045,
              bottom: size.width * 0.045,
              top: size.height * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoryCard(
                        name: 'All',
                        icon: Icons.grid_view,
                        color: Colors.grey,
                        count: context
                            .read<HomeScreenProvider>()
                            .passwordCategoryLength('All'),
                        isSelected: selectedCategory == 'All',
                      ),
                      SizedBox(width: size.width * 0.032),
                      ...categories.map(
                        (category) => Padding(
                          padding: EdgeInsets.only(right: size.width * 0.032),
                          child: CategoryCard(
                            name: category['name'],
                            icon: category['icon'],
                            color: category['color'],
                            count: context
                                .read<HomeScreenProvider>()
                                .passwordCategoryLength(category['name']),
                            isSelected: selectedCategory == category['name'],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.045),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedCategory == 'All'
                              ? 'All Passwords (${filteredPasswords.length})'
                              : '$selectedCategory (${filteredPasswords.length})',
                          style: GoogleFonts.bebasNeue(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.grey[600]),
                          onPressed: () {
                            // Handle search
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                        filteredPasswords.isEmpty
                            ? const EmptyListState()
                            : ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              itemCount: filteredPasswords.length,
                              itemBuilder: (context, index) {
                                return PasswordCard(
                                  password: filteredPasswords[index],
                                );
                              },
                            ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPasswordScreen()),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        child: Icon(Icons.add, color: Colors.black, size: 28),
      ),
    );
  }
}
