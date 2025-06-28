// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'services/firebase_service.dart';
import 'services/gemini_api_service.dart';
import 'services/audio_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseService>(
          create: (_) => FirebaseService(),
        ),
        ChangeNotifierProvider<GeminiApiService>(
          create: (_) => GeminiApiService(),
        ),
        ChangeNotifierProvider<AudioService>(
          create: (_) => AudioService(),
        ),
      ],
      child: const App(),
    ),
  );
}
