// // lib/widgets/navigation/custom_nav_bar.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/models/user_profile.dart'; // Import UserProfile
// import 'package:gamifier/services/firebase_service.dart'; // Import FirebaseService

// // A custom navigation bar widget designed for web, suitable for both desktop and mobile.
// // It adapts its layout based on screen width and includes navigation links
// // and a circular avatar button that leads to the profile page.
// class CustomNavBar extends StatefulWidget implements PreferredSizeWidget {
//   // Required title for the app bar
//   final String title;
//   // Optional subtitle for more context
//   final String? subtitle;
//   // Whether to automatically show a leading back button
//   final bool automaticallyImplyLeading;

//   const CustomNavBar({
//     super.key,
//     required this.title,
//     this.subtitle,
//     this.automaticallyImplyLeading = true,
//   });

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height

//   @override
//   State<CustomNavBar> createState() => _CustomNavBarState();
// }

// class _CustomNavBarState extends State<CustomNavBar> {
//   UserProfile? _currentUserProfile; // Store current user profile
//   late FirebaseService _firebaseService; // Firebase service instance

//   @override
//   void initState() {
//     super.initState();
//     _firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     _loadUserProfile(); // Load user profile on init
//   }

//   // Fetch the current user's profile and listen for updates
//   void _loadUserProfile() {
//     final user = _firebaseService.currentUser;
//     if (user != null) {
//       _firebaseService.streamUserProfile(user.uid).listen((profile) {
//         if (mounted) {
//           setState(() {
//             _currentUserProfile = profile;
//           });
//         }
//       }).onError((error) {
//         debugPrint('Error streaming user profile in CustomNavBar: $error');
//       });
//     }
//   }

//   // Navigate to a specified route, replacing the current one for main navigation items
//   void _navigateTo(BuildContext context, String routeName) {
//     // Check if the current route is already the destination to avoid unnecessary navigation
//     if (ModalRoute.of(context)?.settings.name != routeName) {
//       Navigator.of(context).pushReplacementNamed(routeName);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Determine if the screen width is small (e.g., mobile) or large (e.g., desktop)
//     final bool isSmallScreen = MediaQuery.of(context).size.width < 768;

//     return AppBar(
//       // Make the AppBar transparent to blend with the AnimatedBackground
//       backgroundColor: Colors.transparent,
//       elevation: 0, // No shadow for a modern, flat look
//       // Customize the leading widget (back button)
//       leading: widget.automaticallyImplyLeading && Navigator.of(context).canPop()
//           ? IconButton(
//               icon: const Icon(Icons.arrow_back_ios, color: AppColors.textColor),
//               onPressed: () => Navigator.of(context).pop(),
//               tooltip: 'Go back',
//             )
//           : null,
//       // Title of the screen, with optional subtitle
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.title,
//             style: AppColors.neonTextStyle(fontSize: isSmallScreen ? 20 : 28, blurRadius: 5),
//           ),
//           if (widget.subtitle != null && !isSmallScreen)
//             Text(
//               widget.subtitle!,
//               style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 14),
//             ),
//         ],
//       ),
//       centerTitle: false, // Align title to the start

//       // Actions (navigation links and profile avatar)
//       actions: isSmallScreen
//           ? [
//               // For small screens, only show the profile avatar button and potentially a menu
//               _buildProfileAvatarButton(context),
//               // Optionally add a PopupMenuButton for other navigation items on small screens
//               // This is a common pattern for mobile navigation
//               PopupMenuButton<String>(
//                 icon: const Icon(Icons.menu, color: AppColors.textColor),
//                 onSelected: (String result) {
//                   _navigateTo(context, result);
//                 },
//                 itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                   const PopupMenuItem<String>(
//                     value: AppRouter.homeRoute,
//                     child: Text('Home', style: TextStyle(color: AppColors.textColor)),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: AppRouter.progressRoute,
//                     child: Text('Progress', style: TextStyle(color: AppColors.textColor)),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: AppRouter.communityRoute,
//                     child: Text('Community', style: TextStyle(color: AppColors.textColor)),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: AppRouter.chatRoute,
//                     child: Text('AI Tutor', style: TextStyle(color: AppColors.textColor)),
//                   ),
//                   const PopupMenuItem<String>(
//                     value: AppRouter.courseCreationRoute,
//                     child: Text('Create Course', style: TextStyle(color: AppColors.textColor)),
//                   ),
//                 ],
//                 color: AppColors.cardColor, // Background color for the menu
//               ),
//             ]
//           : [
//               // For large screens, display all navigation items directly
//               _buildNavLink(context, 'Home', AppRouter.homeRoute),
//               _buildNavLink(context, 'Progress', AppRouter.progressRoute),
//               _buildNavLink(context, 'Community', AppRouter.communityRoute),
//               _buildNavLink(context, 'AI Tutor', AppRouter.chatRoute),
//               _buildNavLink(context, 'Create Course', AppRouter.courseCreationRoute),
//               const SizedBox(width: AppConstants.spacing * 2), // Spacing before profile avatar
//               _buildProfileAvatarButton(context),
//               const SizedBox(width: AppConstants.padding), // Padding on the right edge
//             ],
//     );
//   }

//   // Helper method to build navigation text buttons
//   Widget _buildNavLink(BuildContext context, String text, String routeName) {
//     // Check if this is the currently active route to highlight it
//     final bool isActive = ModalRoute.of(context)?.settings.name == routeName;
//     return TextButton(
//       onPressed: () => _navigateTo(context, routeName),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: isActive ? AppColors.accentColor : AppColors.textColorSecondary,
//           fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }

//   // Helper method to build the circular profile avatar button
//   Widget _buildProfileAvatarButton(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: AppConstants.spacing),
//       child: GestureDetector(
//         onTap: () => _navigateTo(context, AppRouter.profileRoute),
//         child: CircleAvatar(
//           radius: AppConstants.avatarSize / 2, // Use a smaller size for the avatar in the nav bar
//           backgroundImage: _currentUserProfile?.avatarAssetPath != null
//               ? AssetImage(_currentUserProfile!.avatarAssetPath)
//               : const AssetImage(AppConstants.defaultAvatarPath), // Fallback to default
//           backgroundColor: AppColors.borderColor,
//           child: _currentUserProfile?.avatarAssetPath == null
//               ? Icon(Icons.person, color: AppColors.textColorSecondary, size: AppConstants.iconSize)
//               : null,
//         ),
//       ),
//     );
//   }
// }
