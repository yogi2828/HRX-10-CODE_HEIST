// lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:gamifier/utils/validation_utils.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/common/custom_button.dart';
import 'package:gamifier/widgets/common/custom_text_field.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _usernameController = TextEditingController();
  String? _educationLevel;
  String? _specialty;
  String? _language;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserProfileAndSetDefaults();
  }

  // Load existing profile details to pre-fill
  Future<void> _loadUserProfileAndSetDefaults() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      final user = firebaseService.currentUser;
      if (user != null) {
        final userProfile = await firebaseService.getUserProfile(user.uid);
        if (userProfile != null) {
          _usernameController.text = userProfile.username;

          // Ensure selected value is in the list, otherwise default to first.
          _educationLevel = AppConstants.educationLevels.contains(userProfile.educationLevel)
              ? userProfile.educationLevel
              : AppConstants.educationLevels.first;
          _specialty = AppConstants.defaultCourseTopics.contains(userProfile.specialty)
              ? userProfile.specialty
              : AppConstants.defaultCourseTopics.first;
          _language = AppConstants.supportedLanguages.contains(userProfile.language)
              ? userProfile.language
              : AppConstants.supportedLanguages.first;
        } else {
          // If no profile exists (e.g., brand new user after auth without profile creation)
          _educationLevel = AppConstants.educationLevels.first;
          _specialty = AppConstants.defaultCourseTopics.first;
          _language = AppConstants.supportedLanguages.first;
        }
      } else {
        // Fallback for non-logged-in state (should not happen if routed from Splash correctly)
        _educationLevel = AppConstants.educationLevels.first;
        _specialty = AppConstants.defaultCourseTopics.first;
        _language = AppConstants.supportedLanguages.first;
      }
    } catch (e) {
      debugPrint('Error loading user profile for onboarding: $e');
      _educationLevel = AppConstants.educationLevels.first;
      _specialty = AppConstants.defaultCourseTopics.first;
      _language = AppConstants.supportedLanguages.first;
      _errorMessage = 'Failed to load profile details. Please try again.';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _completeOnboarding() async {
    if (_usernameController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a username.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      final user = firebaseService.currentUser;

      if (user != null) {
        await firebaseService.updateUserProfile(
          user.uid,
          {
            'username': _usernameController.text.trim(),
            'educationLevel': _educationLevel,
            'specialty': _specialty,
            'language': _language,
          },
        );
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
        }
      } else {
        setState(() {
          _errorMessage = 'User not logged in. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to complete onboarding: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
      decoration: BoxDecoration(
        color: AppColors.cardColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.cardColor,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.textColorSecondary), // Fixed 'icons' to 'Icons'
          style: const TextStyle(color: AppColors.textColor, fontSize: 16),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String itemValue) {
            return DropdownMenuItem<String>(
              value: itemValue,
              child: Row(
                children: [
                  Icon(icon, color: AppColors.textColorSecondary, size: 20),
                  SizedBox(width: AppConstants.spacing),
                  Text(itemValue),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient(),
        ),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator(color: AppColors.accentColor)
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.padding * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to ${AppConstants.appName}!',
                        style: AppColors.neonTextStyle(fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppConstants.spacing),
                      Text(
                        AppConstants.appTagline,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.textColorSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppConstants.spacing * 4),
                      Text(
                        'Let\'s set up your profile for a personalized learning journey.',
                        style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppConstants.spacing * 4),
                      CustomTextField(
                        controller: _usernameController,
                        labelText: 'Choose a Username',
                        icon: Icons.person_outline,
                        validator: (value) => ValidationUtils.validateField(value, 'Username'),
                      ),
                      const SizedBox(height: AppConstants.spacing * 2),
                      _buildDropdownField(
                        label: 'Your Education Level',
                        value: _educationLevel!,
                        items: AppConstants.educationLevels,
                        onChanged: (String? newValue) {
                          setState(() {
                            _educationLevel = newValue;
                          });
                        },
                        icon: Icons.school,
                      ),
                      const SizedBox(height: AppConstants.spacing * 2),
                      _buildDropdownField(
                        label: 'Your Area of Specialty',
                        value: _specialty!,
                        items: AppConstants.defaultCourseTopics,
                        onChanged: (String? newValue) {
                          setState(() {
                            _specialty = newValue;
                          });
                        },
                        icon: Icons.star,
                      ),
                      const SizedBox(height: AppConstants.spacing * 2),
                      _buildDropdownField(
                        label: 'Preferred Course Language', // New field for language
                        value: _language!,
                        items: AppConstants.supportedLanguages,
                        onChanged: (String? newValue) {
                          setState(() {
                            _language = newValue;
                          });
                        },
                        icon: Icons.language,
                      ),
                      const SizedBox(height: AppConstants.spacing * 4),
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppConstants.spacing * 2),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: AppColors.errorColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      CustomButton(
                        onPressed: _completeOnboarding,
                        text: 'Start My Journey!',
                        icon: Icons.rocket_launch,
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