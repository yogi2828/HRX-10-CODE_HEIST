// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/common/loading_indicator.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);

    firebaseService.authStateChanges.listen((User? user) {
      if (user == null) {
        // No user signed in, navigate to AuthScreen
        Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
      } else {
        // User signed in, check if profile exists (onboarding completed)
        _checkUserProfile(user.uid);
      }
    });
  }

  Future<void> _checkUserProfile(String uid) async {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    try {
      final userProfile = await firebaseService.streamUserProfile(uid).first;
      if (userProfile != null && userProfile.educationLevel != null && userProfile.specialty != null) {
        // Profile complete, navigate to Home
        Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
      } else {
        // Profile incomplete, navigate to Onboarding
        Navigator.of(context).pushReplacementNamed(AppRouter.onboardingRoute);
      }
    } catch (e) {
      print('Error checking user profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user data: $e', style: const TextStyle(color: AppColors.errorColor))),
      );
      Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/splash_logo.json', // Placeholder for your splash animation
                width: 200,
                height: 200,
                repeat: true,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/avatars/avatar1.png', // Fallback image
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: AppConstants.padding * 2),
              Text(
                AppConstants.appName,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppConstants.spacing),
              Text(
                AppConstants.appTagline,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textColorSecondary,
                ),
              ),
              const SizedBox(height: AppConstants.padding * 3),
              const LoadingIndicator(),
              const SizedBox(height: AppConstants.padding),
              Text(
                'Loading...',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
