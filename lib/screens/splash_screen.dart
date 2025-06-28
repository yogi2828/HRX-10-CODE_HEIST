// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/utils/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late FirebaseService _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = Provider.of<FirebaseService>(context, listen: false);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward().whenComplete(() {
      _checkAuthStatus();
    });
  }

  Future<void> _checkAuthStatus() async {
    // Listen to auth state changes to react when Firebase is ready and user status is known
    _firebaseService.authStateChanges.listen((User? user) async {
      // Ensure the widget is still mounted before performing navigation
      if (mounted) {
        if (user == null) {
          // No user logged in, navigate to AuthScreen
          Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
        } else {
          // User is logged in, check profile completeness
          final userProfile = await _firebaseService.getUserProfile(user.uid);
          if (userProfile == null || userProfile.username.isEmpty) {
            // User profile not complete or not found, navigate to Onboarding
            Navigator.of(context).pushReplacementNamed(AppRouter.onboardingRoute);
          } else {
            // User profile complete, navigate to HomeScreen
            Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
          }
        }
      }
      // After the first check and navigation, we don't need to listen anymore if we pushReplacement
      // If we allowed back navigation to splash, then we'd keep listening.
      // For a splash screen, usually, you navigate once and dispose listeners.
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient(),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/app_icon.png', // Ensure this asset exists and is correctly configured in pubspec.yaml
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: AppConstants.spacing * 2),
                  Text(
                    AppConstants.appName,
                    style: AppColors.neonTextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: AppConstants.spacing),
                  Text(
                    AppConstants.appTagline,
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.textColorSecondary,
                      fontStyle: FontStyle.italic,
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