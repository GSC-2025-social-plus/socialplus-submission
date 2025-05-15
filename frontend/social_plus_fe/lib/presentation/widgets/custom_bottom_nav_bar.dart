import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/home.png', width: 30),
          activeIcon: Image.asset('assets/images/home.png', width: 30),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/talk.png', width: 45),
          activeIcon: Image.asset('assets/images/talk.png', width: 45),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/profile.png', width: 30),
          activeIcon: Image.asset('assets/images/profile.png', width: 30),
          label: '',
        ),

      ],
    );
  }
}