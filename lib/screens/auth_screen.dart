// lib/screens/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/utils/validation_utils.dart';
import 'package:gamifier/widgets/common/custom_button.dart';
import 'package:gamifier/widgets/common/custom_text_field.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  String? _educationLevel;
  String? _specialty;
  String? _language; // New field

  bool _isLogin = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _educationLevel = AppConstants.educationLevels.first; // Initialize
    _specialty = AppConstants.defaultCourseTopics.first; // Initialize
    _language = AppConstants.supportedLanguages.first; // Initialize new field
  }

  Future<void> _submitAuthForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      if (_isLogin) {
        await firebaseService.signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        if (mounted) {
          // After successful login, check if profile is complete.
          // This ensures existing users created before these fields were added go to onboarding.
          final userProfile = await firebaseService.getUserProfile(firebaseService.currentUser!.uid);
          if (userProfile == null || userProfile.username.isEmpty || userProfile.educationLevel == null || userProfile.specialty == null || userProfile.language == null) {
            Navigator.of(context).pushReplacementNamed(AppRouter.onboardingRoute);
          } else {
            Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
          }
        }
      } else {
        await firebaseService.registerWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _usernameController.text.trim(),
          educationLevel: _educationLevel, // Pass new fields
          specialty: _specialty, // Pass new fields
          language: _language, // Pass new field
        );
        if (mounted) {
          // New users go directly to home if profile complete upon registration.
          Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred: ${e.toString()}';
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
          icon: Icon(Icons.arrow_drop_down, color: AppColors.textColorSecondary),
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
    _emailController.dispose();
    _passwordController.dispose();
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isLogin ? 'Welcome Back!' : 'Join Gamifier!',
                    style: AppColors.neonTextStyle(fontSize: 32),
                  ),
                  const SizedBox(height: AppConstants.spacing * 4),
                  if (!_isLogin) ...[
                    CustomTextField(
                      controller: _usernameController,
                      labelText: 'Username',
                      icon: Icons.person,
                      validator: ValidationUtils.validateUsername,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: AppConstants.spacing * 2),
                    _buildDropdownField(
                      label: 'Education Level',
                      value: _educationLevel!,
                      items: AppConstants.educationLevels,
                      onChanged: (value) {
                        setState(() {
                          _educationLevel = value;
                        });
                      },
                      icon: Icons.school,
                    ),
                    const SizedBox(height: AppConstants.spacing * 2),
                    _buildDropdownField(
                      label: 'Specialty (e.g., "AI", "Web Dev")',
                      value: _specialty!,
                      items: AppConstants.defaultCourseTopics,
                      onChanged: (value) {
                        setState(() {
                          _specialty = value;
                        });
                      },
                      icon: Icons.star,
                    ),
                    const SizedBox(height: AppConstants.spacing * 2),
                    _buildDropdownField( // New language dropdown
                      label: 'Preferred Language',
                      value: _language!,
                      items: AppConstants.supportedLanguages,
                      onChanged: (value) {
                        setState(() {
                          _language = value;
                        });
                      },
                      icon: Icons.language,
                    ),
                    const SizedBox(height: AppConstants.spacing * 2),
                  ],
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    icon: Icons.email,
                    validator: ValidationUtils.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppConstants.spacing * 2),
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    icon: Icons.lock,
                    validator: ValidationUtils.validatePassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: AppConstants.spacing * 4),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppConstants.spacing * 2),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: AppColors.errorColor, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  _isLoading
                      ? const CircularProgressIndicator(color: AppColors.accentColor)
                      : CustomButton(
                          onPressed: _submitAuthForm,
                          text: _isLogin ? 'Login' : 'Register',
                          icon: _isLogin ? Icons.login : Icons.app_registration,
                        ),
                  const SizedBox(height: AppConstants.spacing * 2),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                        _errorMessage = null;
                        // Reset dropdowns to first value when toggling form type
                        _educationLevel = AppConstants.educationLevels.first;
                        _specialty = AppConstants.defaultCourseTopics.first;
                        _language = AppConstants.supportedLanguages.first; // Reset language
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'Don\'t have an account? Register'
                          : 'Already have an account? Login',
                      style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
