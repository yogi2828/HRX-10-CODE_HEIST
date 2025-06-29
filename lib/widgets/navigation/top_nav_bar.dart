// gamifier/lib/widgets/navigation/top_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/common/xp_level_display.dart'; // Import XP/Level display

class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  const TopNavBar({super.key});

  @override
  State<TopNavBar> createState() => _TopNavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(AppConstants.topNavBarHeight);
}

class _TopNavBarState extends State<TopNavBar> {
  UserProfile? _userProfile;
  late FirebaseService _firebaseService;
  late Stream<UserProfile?> _userProfileStream;

  @override
  void initState() {
    super.initState();
    _firebaseService = Provider.of<FirebaseService>(context, listen: false);
    _userProfileStream = _firebaseService.streamUserProfile();
    _userProfileStream.listen((profile) {
      if (mounted) {
        setState(() {
          _userProfile = profile;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the current route is the auth screen to hide the nav bar
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final bool isAuthScreen = currentRoute == AppRouter.authRoute;
    final bool isSplashScreen = currentRoute == AppRouter.splashRoute;

    if (isAuthScreen || isSplashScreen) {
      return const SizedBox.shrink(); // Hide nav bar on auth and splash screens
    }

    return AppBar(
      backgroundColor: AppColors.backgroundColor.withOpacity(0.8), // Semi-transparent
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppConstants.borderRadius),
        ),
      ),
      toolbarHeight: AppConstants.topNavBarHeight,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // App Logo/Name
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(AppRouter.homeRoute),
            child: Row(
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return AppColors.buttonGradient().createShader(bounds);
                  },
                  child: const Icon(Icons.psychology_alt, size: AppConstants.iconSize * 1.5, color: Colors.white),
                ),
                const SizedBox(width: AppConstants.spacing),
                Text(
                  AppConstants.appName,
                  style: AppColors.neonTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
          // Navigation Links (Responsive)
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800), // Max width for nav links
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavLink(context, 'Home', AppRouter.homeRoute, Icons.home_rounded),
                    _buildNavLink(context, 'Courses', AppRouter.levelSelectionRoute, Icons.school_rounded),
                    _buildNavLink(context, 'Progress', AppRouter.progressRoute, Icons.bar_chart_rounded),
                    _buildNavLink(context, 'Community', AppRouter.communityRoute, Icons.people_alt_rounded),
                    _buildNavLink(context, 'Chat', AppRouter.chatRoute, Icons.chat_rounded),
                    // Add more navigation items as needed
                  ],
                ),
              ),
            ),
          ),
          // User Profile and Logout
          Row(
            children: [
              if (_userProfile != null)
                XpLevelDisplay(userProfile: _userProfile!), // XP and Level display
              const SizedBox(width: AppConstants.spacing),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRouter.profileRoute);
                },
                borderRadius: BorderRadius.circular(AppConstants.avatarSize),
                child: Container(
                  width: AppConstants.avatarSize * 0.6,
                  height: AppConstants.avatarSize * 0.6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.accentColor, width: 2),
                    image: _userProfile?.avatarUrl != null && _userProfile!.avatarUrl!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(_userProfile!.avatarUrl!),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage('assets/avatars/avatar1.png'), // Default avatar
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.spacing),
              IconButton(
                icon: const Icon(Icons.logout_rounded, color: AppColors.textColor),
                tooltip: 'Logout',
                onPressed: () async {
                  await _firebaseService.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.authRoute, (route) => false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String title, String routeName, IconData icon) {
    final bool isSelected = ModalRoute.of(context)?.settings.name == routeName;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Navigator.of(context).pushNamed(routeName);
        }
      },
      child: AnimatedContainer(
        duration: AppConstants.defaultAnimationDuration,
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor.withOpacity(0.5) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(
            color: isSelected ? AppColors.accentColor : Colors.transparent,
            width: isSelected ? 2 : 0,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.accentColor : AppColors.textColorSecondary, size: AppConstants.iconSize * 0.8),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.accentColor : AppColors.textColorSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





