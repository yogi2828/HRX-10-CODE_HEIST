// // lib/widgets/common/custom_app_bar.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/widgets/navigation/top_nav_bar.dart'; // Import the new TopNavBar

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool automaticallyImplyLeading;
//   final bool showTopNavBar; // New parameter to control TopNavBar visibility
//   final int? currentNavBarIndex; // New parameter for TopNavBar

//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.automaticallyImplyLeading = false,
//     this.showTopNavBar = false, // Default to false
//     this.currentNavBarIndex,
//   });

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight + (AppConstants.buttonNavBarHeight)); // Adjusted height

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(
//         title,
//         style: AppColors.neonTextStyle(fontSize: 22, color: AppColors.accentColor),
//       ),
//       centerTitle: true,
//       automaticallyImplyLeading: automaticallyImplyLeading,
//       backgroundColor: AppColors.primaryColorDark.withOpacity(0.7), // Slightly transparent
//       elevation: 0,
//       flexibleSpace: showTopNavBar && currentNavBarIndex != null
//           ? Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TopNavBar(currentIndex: currentNavBarIndex!),
//                 const SizedBox(height: AppConstants.padding / 2), // Small gap
//               ],
//             )
//           : null,
//     );
//   }
// }