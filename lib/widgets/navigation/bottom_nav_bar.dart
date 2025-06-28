// lib/widgets/navigation/bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/utils/app_router.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
            break;
          case 1:
            Navigator.of(context).pushReplacementNamed(AppRouter.progressRoute);
            break;
          case 2:
            Navigator.of(context).pushReplacementNamed(AppRouter.aiChatRoute);
            break;
          case 3:
            Navigator.of(context).pushReplacementNamed(AppRouter.communityRoute);
            break;
          case 4:
            Navigator.of(context).pushReplacementNamed(AppRouter.profileRoute);
            break;
        }
      },
      backgroundColor: AppColors.cardColor.withOpacity(0.95),
      selectedItemColor: AppColors.accentColor,
      unselectedItemColor: AppColors.textColorSecondary,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          label: 'AI Tutor',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
