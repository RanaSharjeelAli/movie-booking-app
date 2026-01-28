import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/app_theme.dart';
import '../utils/responsive_utils.dart';
import '../screens/movie_list_screen.dart';
import '../screens/search_screen.dart';
import '../screens/media_library_screen.dart';
import '../screens/more_screen.dart';
import 'custom_bottom_nav.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final pages = const [
    MovieListScreen(), // Dashboard screen
    SearchScreen(), // Watch screen
    MediaLibraryScreen(), // Media Library screen
    MoreScreen(), // More screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: pages[_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
