// lib/screens/avatar_customizer_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/avatar_asset.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/common/custom_button.dart';
import 'package:gamifier/widgets/gamification/avatar_customizer.dart';

class AvatarCustomizerScreen extends StatefulWidget {
  const AvatarCustomizerScreen({super.key});

  @override
  State<AvatarCustomizerScreen> createState() => _AvatarCustomizerScreenState();
}

class _AvatarCustomizerScreenState extends State<AvatarCustomizerScreen> {
  String? _selectedAvatarPath;
  UserProfile? _userProfile;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      final currentUser = firebaseService.currentUser;
      if (currentUser != null) {
        final profile = await firebaseService.getUserProfile(currentUser.uid);
        setState(() {
          _userProfile = profile;
          _selectedAvatarPath = profile?.avatarAssetPath;
        });
      } else {
        setState(() {
          _errorMessage = 'User not logged in.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load user profile: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onAvatarSelected(AvatarAsset avatar) {
    setState(() {
      _selectedAvatarPath = avatar.assetPath;
    });
  }

  Future<void> _saveAvatar() async {
    if (_userProfile == null || _selectedAvatarPath == null) {
      setState(() {
        _errorMessage = 'No avatar selected or user profile not loaded.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      await firebaseService.updateUserProfile(
        _userProfile!.uid,
        {'avatarAssetPath': _selectedAvatarPath},
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Avatar updated successfully!')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to save avatar: ${e.toString()}';
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
      appBar: const CustomAppBar(title: 'Customize Avatar'),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient(),
        ),
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
                  : Column(
                      children: [
                        Expanded(
                          child: AvatarCustomizer(
                            selectedAvatarPath: _selectedAvatarPath,
                            onAvatarSelected: _onAvatarSelected,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppConstants.padding),
                          child: CustomButton(
                            onPressed: _saveAvatar,
                            text: 'Save Avatar',
                            icon: Icons.save,
                            isLoading: _isLoading,
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}