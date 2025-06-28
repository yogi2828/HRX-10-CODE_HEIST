// lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/common/loading_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedEducationLevel;
  String? _selectedSpecialty;
  String? _selectedAIPersona; // New: AI Persona selection
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedEducationLevel = AppConstants.educationLevels.first;
    _selectedSpecialty = AppConstants.defaultCourseTopics.first;
    _selectedAIPersona = 'Default'; // Default AI Persona
  }

  void _completeOnboarding() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final currentUser = firebaseService.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated.', style: TextStyle(color: AppColors.errorColor))),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      UserProfile? userProfile = await firebaseService.streamUserProfile(currentUser.uid).first;
      if (userProfile != null) {
        final updatedProfile = userProfile.copyWith(
          educationLevel: _selectedEducationLevel,
          specialty: _selectedSpecialty,
          aiPersona: _selectedAIPersona, // Save AI Persona
        );
        await firebaseService.updateUserProfile(updatedProfile);
        Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User profile not found.', style: TextStyle(color: AppColors.errorColor))),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save profile: ${e.toString()}', style: const TextStyle(color: AppColors.errorColor))),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0,
          title: const Text('Setup Your Profile', style: TextStyle(color: AppColors.textColor)),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.padding * 2),
            child: Card(
              color: AppColors.cardColor.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.padding * 2),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tell us about yourself!',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppConstants.padding * 1.5),
                      DropdownButtonFormField<String>(
                        value: _selectedEducationLevel,
                        decoration: const InputDecoration(
                          labelText: 'Education Level',
                          prefixIcon: Icon(Icons.school, color: AppColors.accentColor),
                        ),
                        items: AppConstants.educationLevels.map((String level) {
                          return DropdownMenuItem<String>(
                            value: level,
                            child: Text(level, style: const TextStyle(color: AppColors.textColor)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedEducationLevel = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your education level.';
                          }
                          return null;
                        },
                        dropdownColor: AppColors.cardColor,
                        style: const TextStyle(color: AppColors.textColor),
                      ),
                      const SizedBox(height: AppConstants.padding),
                      DropdownButtonFormField<String>(
                        value: _selectedSpecialty,
                        decoration: const InputDecoration(
                          labelText: 'Learning Interest/Specialty',
                          prefixIcon: Icon(Icons.lightbulb, color: AppColors.accentColor),
                        ),
                        items: AppConstants.defaultCourseTopics.map((String topic) {
                          return DropdownMenuItem<String>(
                            value: topic,
                            child: Text(topic, style: const TextStyle(color: AppColors.textColor)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSpecialty = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your learning interest.';
                          }
                          return null;
                        },
                        dropdownColor: AppColors.cardColor,
                        style: const TextStyle(color: AppColors.textColor),
                      ),
                      const SizedBox(height: AppConstants.padding),
                      DropdownButtonFormField<String>(
                        value: _selectedAIPersona,
                        decoration: const InputDecoration(
                          labelText: 'AI Tutor Persona',
                          prefixIcon: Icon(Icons.smart_toy, color: AppColors.accentColor),
                        ),
                        items: const [
                          DropdownMenuItem<String>(value: 'Default', child: Text('Default', style: TextStyle(color: AppColors.textColor))),
                          DropdownMenuItem<String>(value: 'Strict Professor', child: Text('Strict Professor', style: TextStyle(color: AppColors.textColor))),
                          DropdownMenuItem<String>(value: 'Friendly Guide', child: Text('Friendly Guide', style: TextStyle(color: AppColors.textColor))),
                          DropdownMenuItem<String>(value: 'Sarcastic Mentor', child: Text('Sarcastic Mentor', style: TextStyle(color: AppColors.textColor))),
                        ].toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedAIPersona = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an AI persona.';
                          }
                          return null;
                        },
                        dropdownColor: AppColors.cardColor,
                        style: const TextStyle(color: AppColors.textColor),
                      ),
                      const SizedBox(height: AppConstants.padding * 2),
                      _isLoading
                          ? const LoadingIndicator()
                          : ElevatedButton(
                              onPressed: _completeOnboarding,
                              child: const Text('Start Learning!'),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
