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
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _educationLevel = AppConstants.educationLevels.first;
    _specialty = AppConstants.defaultCourseTopics.first;
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.padding * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Gamifier!',
                  style: AppColors.neonTextStyle(fontSize: 32),
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    border: Border.all(color: AppColors.borderColor, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _educationLevel,
                      isExpanded: true,
                      dropdownColor: AppColors.cardColor,
                      icon: const Icon(Icons.arrow_drop_down, color: AppColors.textColorSecondary),
                      style: const TextStyle(color: AppColors.textColor, fontSize: 16),
                      onChanged: (String? newValue) {
                        setState(() {
                          _educationLevel = newValue;
                        });
                      },
                      items: AppConstants.educationLevels
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spacing * 2),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    border: Border.all(color: AppColors.borderColor, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _specialty,
                      isExpanded: true,
                      dropdownColor: AppColors.cardColor,
                      icon: const Icon(Icons.arrow_drop_down, color: AppColors.textColorSecondary),
                      style: const TextStyle(color: AppColors.textColor, fontSize: 16),
                      onChanged: (String? newValue) {
                        setState(() {
                          _specialty = newValue;
                        });
                      },
                      items: AppConstants.defaultCourseTopics
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
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
                _isLoading
                    ? const CircularProgressIndicator(color: AppColors.accentColor)
                    : CustomButton(
                        onPressed: _completeOnboarding,
                        text: 'Start My Journey!',
                        icon: Icons.rocket_launch,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}