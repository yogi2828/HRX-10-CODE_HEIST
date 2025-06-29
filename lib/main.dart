
// gamifier/lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart'; // Import for web URL strategy

import 'app.dart';
import 'services/firebase_service.dart';
import 'services/gemini_api_service.dart';
import 'services/audio_service.dart';
import 'firebase_options.dart'; // Keep this, assuming it handles web configuration

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy(); // Configure URL strategy for Flutter Web

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
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
      child: const App(),
    ),
  );
}