// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/common/loading_indicator.dart';
import 'package:gamifier/widgets/gamification/avatar_customizer.dart';
import 'package:gamifier/widgets/gamification/badge_display.dart';
import 'package:gamifier/widgets/gamification/leaderboard_list.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? _userProfile;
  bool _isLoading = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() {
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
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && _userProfile != null) {
      // For now, we'll just log the path. Real implementation would upload to storage (e.g., Firebase Storage)
      // and update the userProfile.avatarAssetPath with the URL.
      // Since the current avatar system uses local assets, this is a placeholder.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image picked: ${pickedFile.path}. Upload to storage functionality to be implemented.', style: const TextStyle(color: AppColors.infoColor))),
      );
    }
  }

  void _logout() async {
    await Provider.of<FirebaseService>(context, listen: false).signOut();
    Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
  }

  void _navigateToAvatarCustomizer() {
    if (_userProfile != null) {
      Navigator.of(context).pushNamed(
        AppRouter.avatarCustomizerRoute,
        arguments: _userProfile,
      );
    }
  }

  void _showAIPersonaDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String? tempSelectedPersona = _userProfile?.aiPersona;
        return AlertDialog(
          backgroundColor: AppColors.cardColor,
          title: const Text('Choose AI Persona'),
          content: DropdownButtonFormField<String>(
            value: tempSelectedPersona,
            decoration: const InputDecoration(
              labelText: 'AI Tutor Persona',
            ),
            items: const [
              DropdownMenuItem<String>(value: 'Default', child: Text('Default', style: TextStyle(color: AppColors.textColor))),
              DropdownMenuItem<String>(value: 'Strict Professor', child: Text('Strict Professor', style: TextStyle(color: AppColors.textColor))),
              DropdownMenuItem<String>(value: 'Friendly Guide', child: Text('Friendly Guide', style: TextStyle(color: AppColors.textColor))),
              DropdownMenuItem<String>(value: 'Sarcastic Mentor', child: Text('Sarcastic Mentor', style: TextStyle(color: AppColors.textColor))),
            ].toList(),
            onChanged: (String? newValue) {
              tempSelectedPersona = newValue;
            },
            dropdownColor: AppColors.cardColor,
            style: const TextStyle(color: AppColors.textColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: AppColors.accentColor)),
            ),
            ElevatedButton(
              onPressed: () async {
                if (tempSelectedPersona != null && _userProfile != null) {
                  final firebaseService = Provider.of<FirebaseService>(context, listen: false);
                  final updatedProfile = _userProfile!.copyWith(aiPersona: tempSelectedPersona);
                  await firebaseService.updateUserProfile(updatedProfile);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('AI Persona updated successfully!')),
                  );
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: const CustomAppBar(title: 'My Profile'),
        body: _isLoading
            ? const LoadingIndicator()
            : _userProfile == null
                ? Center(
                    child: Text(
                      'No user profile found. Please log in.',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textColorSecondary),
                      textAlign: TextAlign.center,
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(AppConstants.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          color: AppColors.cardColor,
                          margin: const EdgeInsets.only(bottom: AppConstants.padding),
                          child: Padding(
                            padding: const EdgeInsets.all(AppConstants.padding),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: _navigateToAvatarCustomizer,
                                  child: AvatarCustomizer(
                                    selectedAvatarPath: _userProfile!.avatarAssetPath,
                                    onAvatarSelected: (path) {}, // No direct selection here, handled by navigation
                                    showSelector: false,
                                  ),
                                ),
                                const SizedBox(height: AppConstants.padding),
                                Text(
                                  _userProfile!.username,
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Level ${_userProfile!.level} | XP: ${_userProfile!.xp}',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.xpColor),
                                ),
                                const SizedBox(height: AppConstants.spacing),
                                Text(
                                  'Current Streak: ${_userProfile!.currentStreak} days',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.streakColor),
                                ),
                                const SizedBox(height: AppConstants.padding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ActionChip(
                                      avatar: const Icon(Icons.school, color: AppColors.textColor),
                                      label: Text(_userProfile!.educationLevel ?? 'Not Set'),
                                      labelStyle: const TextStyle(color: AppColors.textColor),
                                      backgroundColor: AppColors.secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                                      ),
                                    ),
                                    const SizedBox(width: AppConstants.spacing),
                                    ActionChip(
                                      avatar: const Icon(Icons.topic, color: AppColors.textColor),
                                      label: Text(_userProfile!.specialty ?? 'Not Set'),
                                      labelStyle: const TextStyle(color: AppColors.textColor),
                                      backgroundColor: AppColors.secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppConstants.padding),
                                ElevatedButton.icon(
                                  onPressed: _showAIPersonaDialog,
                                  icon: const Icon(Icons.smart_toy),
                                  label: Text('AI Persona: ${_userProfile!.aiPersona ?? 'Default'}'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: AppColors.cardColor,
                          margin: const EdgeInsets.only(bottom: AppConstants.padding),
                          child: Padding(
                            padding: const EdgeInsets.all(AppConstants.padding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Earned Badges',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor),
                                ),
                                const SizedBox(height: AppConstants.padding),
                                BadgeDisplay(earnedBadgeIds: _userProfile!.earnedBadges),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: AppColors.cardColor,
                          margin: const EdgeInsets.only(bottom: AppConstants.padding),
                          child: Padding(
                            padding: const EdgeInsets.all(AppConstants.padding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Leaderboard',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor),
                                ),
                                const SizedBox(height: AppConstants.padding),
                                LeaderboardList(),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _logout,
                          icon: const Icon(Icons.logout),
                          label: const Text('Logout'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.errorColor,
                            padding: const EdgeInsets.symmetric(vertical: AppConstants.padding),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
