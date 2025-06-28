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

  @override
  void initState() {
    super.initState();
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
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    firebaseService.authStateChanges.listen((User? user) async {
      if (mounted) {
        if (user == null) {
          Navigator.of(context).pushReplacementNamed(AppRouter.onboardingRoute);
        } else {
          final userProfile = await firebaseService.getUserProfile(user.uid);
          if (userProfile == null || userProfile.username.isEmpty) {
            Navigator.of(context).pushReplacementNamed(AppRouter.onboardingRoute);
          } else {
            Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
          }
        }
      }
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
                    'assets/app_icon.png',
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