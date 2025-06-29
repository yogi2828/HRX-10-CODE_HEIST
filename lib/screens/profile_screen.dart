// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/navigation/top_nav_bar.dart'; // Changed to TopNavBar
import 'package:gamifier/widgets/common/custom_button.dart';
import 'package:gamifier/widgets/gamification/badge_display.dart';
import 'package:gamifier/widgets/common/xp_level_display.dart';
import 'package:gamifier/widgets/gamification/streak_display.dart';
import 'package:gamifier/widgets/common/night_sky_background.dart'; // Import NightSkyBackground

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? _userProfile;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final user = firebaseService.currentUser;

    if (user != null) {
      firebaseService.streamUserProfile(user.uid).listen((profile) {
        if (mounted) {
          setState(() {
            _userProfile = profile;
            _isLoading = false;
          });
        }
      }).onError((error) {
        debugPrint('Error streaming user profile: $error');
        if (mounted) {
          setState(() {
            _errorMessage = 'Failed to load profile: ${error.toString()}';
            _isLoading = false;
          });
        }
      });
    } else {
      setState(() {
        _errorMessage = 'User not logged in.';
        _isLoading = false;
      });
    }
  }

  Future<void> _signOut() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<FirebaseService>(context, listen: false).signOut();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error signing out: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TopNavBar( // Replaced CustomAppBar
        currentIndex: 5,
        title: 'My Profile',
      ),
      body: NightSkyBackground( // Wrap content with NightSkyBackground
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
              : _errorMessage != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.padding),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: AppColors.errorColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : _userProfile == null
                      ? const Center(
                          child: Text(
                            'User profile not found. Please log in again.',
                            style: TextStyle(color: AppColors.textColorSecondary),
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(AppConstants.padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: AppConstants.avatarSize,
                                      backgroundImage: AssetImage(_userProfile!.avatarAssetPath),
                                      backgroundColor: AppColors.borderColor,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: IconButton(
                                        icon: const Icon(Icons.edit, color: AppColors.accentColor),
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(AppRouter.avatarCustomizerRoute);
                                        },
                                        tooltip: 'Customize Avatar',
                                        style: IconButton.styleFrom(
                                          backgroundColor: AppColors.primaryColor,
                                          shape: const CircleBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: AppConstants.spacing * 2),
                              Text(
                                _userProfile!.username,
                                style: AppColors.neonTextStyle(fontSize: 28),
                                textAlign: TextAlign.center,
                              ),
                              if (_userProfile!.email.isNotEmpty) ...[
                                const SizedBox(height: AppConstants.spacing),
                                Text(
                                  _userProfile!.email,
                                  style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              const SizedBox(height: AppConstants.spacing * 3),
                              XpLevelDisplay(xp: _userProfile!.xp, level: _userProfile!.level),
                              const SizedBox(height: AppConstants.spacing * 2),
                              StreakDisplay(currentStreak: _userProfile!.currentStreak),
                              const SizedBox(height: AppConstants.spacing * 3),
                              if (_userProfile!.educationLevel != null && _userProfile!.educationLevel!.isNotEmpty)
                                Card(
                                  color: AppColors.cardColor.withOpacity(0.8),
                                  margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
                                  child: Padding(
                                    padding: const EdgeInsets.all(AppConstants.padding),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.school, color: AppColors.secondaryColor),
                                        const SizedBox(width: AppConstants.spacing),
                                        Text(
                                          'Education Level: ${_userProfile!.educationLevel}',
                                          style: const TextStyle(color: AppColors.textColor, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (_userProfile!.specialty != null && _userProfile!.specialty!.isNotEmpty)
                                Card(
                                  color: AppColors.cardColor.withOpacity(0.8),
                                  margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
                                  child: Padding(
                                    padding: const EdgeInsets.all(AppConstants.padding),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.star, color: AppColors.xpColor),
                                        const SizedBox(width: AppConstants.spacing),
                                        Text(
                                          'Specialty: ${_userProfile!.specialty}',
                                          style: const TextStyle(color: AppColors.textColor, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(height: AppConstants.spacing * 2),
                              Text(
                                'Badges Earned (${_userProfile!.earnedBadges.length})',
                                style: AppColors.neonTextStyle(fontSize: 20, color: AppColors.secondaryColor),
                              ),
                              const SizedBox(height: AppConstants.spacing),
                              _userProfile!.earnedBadges.isEmpty
                                  ? const Text(
                                      'No badges earned yet. Keep learning!',
                                      style: TextStyle(color: AppColors.textColorSecondary),
                                    )
                                  : BadgeDisplay(badgeIds: _userProfile!.earnedBadges),
                              const SizedBox(height: AppConstants.spacing * 4),
                              CustomButton(
                                onPressed: _signOut,
                                text: 'Sign Out',
                                icon: Icons.logout,
                                isLoading: _isLoading,
                              ),
                            ],
                          ),
                        ),
        ),
      ),
    );
  }
}