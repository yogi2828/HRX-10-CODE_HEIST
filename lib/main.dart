import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import for SharedPreferences

import 'app.dart';
import 'services/firebase_service.dart';
import 'services/gemini_api_service.dart';
import 'services/audio_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences to check onboarding status
  final prefs = await SharedPreferences.getInstance();
  final bool onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
    // You might want to show an error dialog or a specific error screen here
  }

  runApp(
    MultiProvider(
      providers: [
        Provider<FirebaseService>(
          create: (_) => FirebaseService(),
        ),
        Provider<GeminiApiService>(
          create: (_) => GeminiApiService(),
        ),
        Provider<AudioService>(
          create: (_) => AudioService(),
          dispose: (_, audioService) => audioService.dispose(),
        ),
      ],
      child: const App(), // App widget will handle routing based on auth/onboarding
    ),
  );
}
