// // lib/widgets/navigation/bottom_nav_bar.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/utils/app_router.dart';

// class BottomNavBar extends StatelessWidget {
//   final int currentIndex;

//   const BottomNavBar({
//     super.key,
//     required this.currentIndex,
//   });

//   void _onItemTapped(BuildContext context, int index) {
//     // Determine if we should replace the current route or push a new one
//     // Course Creation (index 4) should push, allowing back navigation to the previous main screen.
//     // Other main screens (Home, Progress, Community, AI Tutor, Profile) should replace to avoid deep navigation stacks.
//     if (index == currentIndex) return; // Prevent navigating to the same route again

//     switch (index) {
//       case 0:
//         Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//         break;
//       case 1:
//         Navigator.of(context).pushReplacementNamed(AppRouter.progressRoute);
//         break;
//       case 2:
//         Navigator.of(context).pushReplacementNamed(AppRouter.communityRoute);
//         break;
//       case 3:
//         Navigator.of(context).pushReplacementNamed(AppRouter.chatRoute);
//         break;
//       case 4: // Create Course
//         // Use pushNamed to allow navigating back to the previous main tab
//         Navigator.of(context).pushNamed(AppRouter.courseCreationRoute);
//         break;
//       case 5:
//         Navigator.of(context).pushReplacementNamed(AppRouter.profileRoute);
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: (index) => _onItemTapped(context, index),
//       backgroundColor: AppColors.primaryColorDark.withOpacity(0.9),
//       selectedItemColor: AppColors.accentColor,
//       unselectedItemColor: AppColors.textColorSecondary,
//       type: BottomNavigationBarType.fixed,
//       selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//       unselectedLabelStyle: const TextStyle(fontSize: 11),
//       elevation: 8,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Replaced Icon with an empty SizedBox
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Replaced Icon with an empty SizedBox
//           label: 'Progress',
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Replaced Icon with an empty SizedBox
//           label: 'Community',
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Replaced Icon with an empty SizedBox
//           label: 'AI Tutor',
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Replaced Icon with an empty SizedBox
//           label: 'Create Course',
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Replaced Icon with an empty SizedBox
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }