// lib/screens/avatar_customizer_screen.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/avatar_asset.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/gamification/avatar_customizer.dart';
import 'package:provider/provider.dart';

class AvatarCustomizerScreen extends StatefulWidget {
  final UserProfile userProfile;

  const AvatarCustomizerScreen({super.key, required this.userProfile});

  @override
  State<AvatarCustomizerScreen> createState() => _AvatarCustomizerScreenState();
}

class _AvatarCustomizerScreenState extends State<AvatarCustomizerScreen> {
  late String _selectedAvatarPath;

  @override
  void initState() {
    super.initState();
    _selectedAvatarPath = widget.userProfile.avatarAssetPath;
  }

  void _saveAvatar() async {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final updatedProfile = widget.userProfile.copyWith(avatarAssetPath: _selectedAvatarPath);
    await firebaseService.updateUserProfile(updatedProfile);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Avatar saved successfully!')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: CustomAppBar(
          title: 'Customize Avatar',
          actions: [
            IconButton(
              icon: const Icon(Icons.save, color: AppColors.textColor),
              onPressed: _saveAvatar,
              tooltip: 'Save Avatar',
            ),
          ],
        ),
        body: SingleChildScrollView(
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
                      Text(
                        'Your Current Avatar',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor),
                      ),
                      const SizedBox(height: AppConstants.padding),
                      AvatarCustomizer(
                        selectedAvatarPath: _selectedAvatarPath,
                        onAvatarSelected: (path) {
                          setState(() {
                            _selectedAvatarPath = path;
                          });
                        },
                        showSelector: false,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: AppColors.cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select a New Avatar',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor),
                      ),
                      const SizedBox(height: AppConstants.padding),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: AppConstants.padding,
                          mainAxisSpacing: AppConstants.padding,
                        ),
                        itemCount: AppConstants.defaultAvatarAssets.length,
                        itemBuilder: (context, index) {
                          final avatar = AppConstants.defaultAvatarAssets[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedAvatarPath = avatar.assetPath;
                              });
                            },
                            child: AnimatedContainer(
                              duration: AppConstants.defaultAnimationDuration,
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                                border: _selectedAvatarPath == avatar.assetPath
                                    ? Border.all(color: AppColors.accentColor, width: 3)
                                    : null,
                                boxShadow: [
                                  if (_selectedAvatarPath == avatar.assetPath)
                                    BoxShadow(
                                      color: AppColors.accentColor.withOpacity(0.5),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    avatar.assetPath,
                                    width: AppConstants.avatarSize,
                                    height: AppConstants.avatarSize,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: AppConstants.spacing),
                                  Text(
                                    avatar.name,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
