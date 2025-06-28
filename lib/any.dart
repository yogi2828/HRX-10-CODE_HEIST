// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';

// import 'app.dart';
// import 'services/firebase_service.dart';
// import 'services/gemini_api_service.dart';
// import 'services/audio_service.dart'; // Import the new audio service
// import 'firebase_options.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } catch (e) {
//     print('Error initializing Firebase: $e');
//   }

//   runApp(
//     MultiProvider(
//       providers: [
//         Provider<FirebaseService>(
//           create: (_) => FirebaseService(),
//         ),
//         Provider<GeminiApiService>(
//           create: (_) => GeminiApiService(),
//         ),
//         Provider<AudioService>( // Provide AudioService
//           create: (_) => AudioService(),
//           dispose: (_, audioService) => audioService.dispose(),
//         ),
//       ],
//       child: const App(),
//     ),
//   );
// }
// // lib/app.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/services/firebase_service.dart'; // Import FirebaseService
// import 'package:provider/provider.dart'; // Import Provider

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Initialize FirebaseService here, or ensure it's available via MultiProvider
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);

//     return MaterialApp(
//       title: AppConstants.appName,
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         primaryColor: AppColors.primaryColor,
//         hintColor: AppColors.accentColor,
//         scaffoldBackgroundColor: Colors.transparent, // Background handled by gradient
//         fontFamily: AppConstants.defaultFontFamily,
//         textTheme: const TextTheme(
//           displayLarge: TextStyle(fontSize: 57, color: AppColors.textColor),
//           displayMedium: TextStyle(fontSize: 45, color: AppColors.textColor),
//           displaySmall: TextStyle(fontSize: 36, color: AppColors.textColor),
//           headlineLarge: TextStyle(fontSize: 32, color: AppColors.textColor),
//           headlineMedium: TextStyle(fontSize: 28, color: AppColors.textColor),
//           headlineSmall: TextStyle(fontSize: 24, color: AppColors.textColor),
//           titleLarge: TextStyle(fontSize: 22, color: AppColors.textColor),
//           titleMedium: TextStyle(fontSize: 16, color: AppColors.textColor),
//           titleSmall: TextStyle(fontSize: 14, color: AppColors.textColor),
//           bodyLarge: TextStyle(fontSize: 16, color: AppColors.textColor),
//           bodyMedium: TextStyle(fontSize: 14, color: AppColors.textColor),
//           bodySmall: TextStyle(fontSize: 12, color: AppColors.textColor),
//           labelLarge: TextStyle(fontSize: 14, color: AppColors.textColor),
//           labelMedium: TextStyle(fontSize: 12, color: AppColors.textColor),
//           labelSmall: TextStyle(fontSize: 11, color: AppColors.textColor),
//         ),
//         cardTheme: CardTheme(
//           color: AppColors.cardColor.withOpacity(0.9),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           ),
//           elevation: 8,
//           margin: EdgeInsets.zero,
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           labelStyle: const TextStyle(color: AppColors.textColorSecondary),
//           hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.7)),
//           fillColor: AppColors.cardColor.withOpacity(0.8),
//           filled: true,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             borderSide: const BorderSide(color: AppColors.accentColor, width: 2),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             borderSide: const BorderSide(color: AppColors.errorColor, width: 1),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.primaryColor,
//             foregroundColor: AppColors.textColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing * 1.5),
//             textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ),
//         textButtonTheme: TextButtonThemeData(
//           style: TextButton.styleFrom(
//             foregroundColor: AppColors.accentColor,
//             textStyle: const TextStyle(fontSize: 16),
//           ),
//         ),
//         outlinedButtonTheme: OutlinedButtonThemeData(
//           style: OutlinedButton.styleFrom(
//             foregroundColor: AppColors.accentColor,
//             side: const BorderSide(color: AppColors.accentColor),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing * 1.5),
//             textStyle: const TextStyle(fontSize: 16),
//           ),
//         ),
//         dialogTheme: DialogTheme(
//           backgroundColor: AppColors.cardColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           ),
//           titleTextStyle: const TextStyle(color: AppColors.textColor, fontSize: 20, fontWeight: FontWeight.bold),
//           contentTextStyle: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
//         ),
//         snackBarTheme: SnackBarThemeData(
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           ),
//           backgroundColor: AppColors.primaryColor,
//           contentTextStyle: const TextStyle(color: AppColors.textColor),
//         ),
//       ),
//       onGenerateRoute: AppRouter.generateRoute,
//       initialRoute: AppRouter.splashRoute,
//     );
//   }
// }
// // lib/widgets/questions/short_answer_question_widget.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/utils/validation_utils.dart';

// class ShortAnswerQuestionWidget extends StatefulWidget {
//   final Question question;
//   final ValueChanged<String> onAnswerSubmitted;

//   const ShortAnswerQuestionWidget({
//     super.key,
//     required this.question,
//     required this.onAnswerSubmitted,
//   });

//   @override
//   State<ShortAnswerQuestionWidget> createState() => _ShortAnswerQuestionWidgetState();
// }

// class _ShortAnswerQuestionWidgetState extends State<ShortAnswerQuestionWidget> {
//   final TextEditingController _controller = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _submitAnswer() {
//     if (_formKey.currentState!.validate()) {
//       widget.onAnswerSubmitted(_controller.text);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.question.questionText,
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor),
//               ),
//               const SizedBox(height: AppConstants.padding),
//               TextFormField(
//                 controller: _controller,
//                 style: const TextStyle(color: AppColors.textColor),
//                 decoration: InputDecoration(
//                   hintText: 'Type your answer here...',
//                   hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.7)),
//                   filled: true,
//                   fillColor: AppColors.primaryColor.withOpacity(0.1),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 maxLines: 3,
//                 validator: (value) => ValidationUtils.validateNotEmpty(value, 'Answer cannot be empty'),
//                 onFieldSubmitted: (value) => _submitAnswer(),
//               ),
//               const SizedBox(height: AppConstants.padding),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _submitAnswer,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.accentColor,
//                     foregroundColor: AppColors.cardColor,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                     padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
//                   ),
//                   child: const Text('Submit Answer'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/questions/scenario_question_widget.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/utils/validation_utils.dart';

// class ScenarioQuestionWidget extends StatefulWidget {
//   final Question question;
//   final ValueChanged<String> onAnswerSubmitted;

//   const ScenarioQuestionWidget({
//     super.key,
//     required this.question,
//     required this.onAnswerSubmitted,
//   });

//   @override
//   State<ScenarioQuestionWidget> createState() => _ScenarioQuestionWidgetState();
// }

// class _ScenarioQuestionWidgetState extends State<ScenarioQuestionWidget> {
//   final TextEditingController _controller = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _submitAnswer() {
//     if (_formKey.currentState!.validate()) {
//       widget.onAnswerSubmitted(_controller.text);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Scenario: ${widget.question.scenarioText ?? ''}',
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       color: AppColors.textColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Text(
//                 widget.question.questionText,
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor),
//               ),
//               const SizedBox(height: AppConstants.padding),
//               TextFormField(
//                 controller: _controller,
//                 style: const TextStyle(color: AppColors.textColor),
//                 decoration: InputDecoration(
//                   hintText: 'Describe your outcome or action...',
//                   hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.7)),
//                   filled: true,
//                   fillColor: AppColors.primaryColor.withOpacity(0.1),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 maxLines: 4,
//                 validator: (value) => ValidationUtils.validateNotEmpty(value, 'Outcome cannot be empty'),
//                 onFieldSubmitted: (value) => _submitAnswer(),
//               ),
//               const SizedBox(height: AppConstants.padding),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _submitAnswer,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.accentColor,
//                     foregroundColor: AppColors.cardColor,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                     padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
//                   ),
//                   child: const Text('Submit Outcome'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/questions/question_renderer.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/widgets/questions/mcq_question_widget.dart';
// import 'package:gamifier/widgets/questions/fill_in_blank_question_widget.dart';
// import 'package:gamifier/widgets/questions/short_answer_question_widget.dart';
// import 'package:gamifier/widgets/questions/scenario_question_widget.dart';
// import 'package:gamifier/constants/app_colors.dart';

// class QuestionRenderer extends StatelessWidget {
//   final Question question;
//   final ValueChanged<String> onAnswerSubmitted;

//   const QuestionRenderer({
//     super.key,
//     required this.question,
//     required this.onAnswerSubmitted,
//   });

//   @override
//   Widget build(BuildContext context) {
//     switch (question.type) {
//       case QuestionType.mcq:
//         return McqQuestionWidget(
//           question: question,
//           onAnswerSubmitted: onAnswerSubmitted,
//         );
//       case QuestionType.fillInBlank:
//         return FillInBlankQuestionWidget(
//           question: question,
//           onAnswerSubmitted: onAnswerSubmitted,
//         );
//       case QuestionType.shortAnswer:
//         return ShortAnswerQuestionWidget(
//           question: question,
//           onAnswerSubmitted: onAnswerSubmitted,
//         );
//       case QuestionType.scenario:
//         return ScenarioQuestionWidget(
//           question: question,
//           onAnswerSubmitted: onAnswerSubmitted,
//         );
//       default:
//         return Center(
//           child: Text(
//             'Unknown question type: ${question.type}',
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.errorColor),
//           ),
//         );
//     }
//   }
// }
// // lib/widgets/questions/mcq_question_widget.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/question.dart';

// class McqQuestionWidget extends StatefulWidget {
//   final Question question;
//   final ValueChanged<String> onAnswerSubmitted;

//   const McqQuestionWidget({
//     super.key,
//     required this.question,
//     required this.onAnswerSubmitted,
//   });

//   @override
//   State<McqQuestionWidget> createState() => _McqQuestionWidgetState();
// }

// class _McqQuestionWidgetState extends State<McqQuestionWidget> {
//   String? _selectedOption;

//   void _submitAnswer() {
//     if (_selectedOption != null) {
//       widget.onAnswerSubmitted(_selectedOption!);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please select an option.'),
//           backgroundColor: AppColors.errorColor,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.question.questionText,
//               style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor),
//             ),
//             const SizedBox(height: AppConstants.padding),
//             ...widget.question.options.map((option) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//                 child: RadioListTile<String>(
//                   title: Text(
//                     option,
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//                   ),
//                   value: option,
//                   groupValue: _selectedOption,
//                   onChanged: (String? value) {
//                     setState(() {
//                       _selectedOption = value;
//                     });
//                   },
//                   activeColor: AppColors.accentColor,
//                   tileColor: AppColors.primaryColor.withOpacity(0.1),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                 ),
//               );
//             }).toList(),
//             const SizedBox(height: AppConstants.padding),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _submitAnswer,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.accentColor,
//                   foregroundColor: AppColors.cardColor,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                   padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
//                 ),
//                 child: const Text('Submit Answer'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/questions/fill_in_blank_question_widget.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/utils/validation_utils.dart'; // Import for validation

// class FillInBlankQuestionWidget extends StatefulWidget {
//   final Question question;
//   final ValueChanged<String> onAnswerSubmitted;

//   const FillInBlankQuestionWidget({
//     super.key,
//     required this.question,
//     required this.onAnswerSubmitted,
//   });

//   @override
//   State<FillInBlankQuestionWidget> createState() => _FillInBlankQuestionWidgetState();
// }

// class _FillInBlankQuestionWidgetState extends State<FillInBlankQuestionWidget> {
//   final TextEditingController _controller = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _submitAnswer() {
//     if (_formKey.currentState!.validate()) {
//       widget.onAnswerSubmitted(_controller.text);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.question.questionText,
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor),
//               ),
//               const SizedBox(height: AppConstants.padding),
//               TextFormField(
//                 controller: _controller,
//                 style: const TextStyle(color: AppColors.textColor),
//                 decoration: InputDecoration(
//                   hintText: 'Type your answer here...',
//                   hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.7)),
//                   filled: true,
//                   fillColor: AppColors.primaryColor.withOpacity(0.1),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 validator: (value) => ValidationUtils.validateNotEmpty(value, 'Answer cannot be empty'),
//                 onFieldSubmitted: (value) => _submitAnswer(),
//               ),
//               const SizedBox(height: AppConstants.padding),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _submitAnswer,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.accentColor,
//                     foregroundColor: AppColors.cardColor,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                     padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
//                   ),
//                   child: const Text('Submit Answer'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/navigation/bottom_nav_bar.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class BottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemTapped;

//   const BottomNavBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.cardColor,
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.cardColor.withOpacity(0.5),
//             blurRadius: 10,
//             spreadRadius: 2,
//             offset: const Offset(0, -2),
//           ),
//         ],
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.borderRadius)),
//       ),
//       child: BottomNavigationBar(
//         currentIndex: selectedIndex,
//         onTap: onItemTapped,
//         backgroundColor: Colors.transparent,
//         selectedItemColor: AppColors.accentColor,
//         unselectedItemColor: AppColors.textColorSecondary,
//         type: BottomNavigationBarType.fixed,
//         selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
//         unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
//         showUnselectedLabels: true,
//         elevation: 0,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_box),
//             label: 'Create',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.leaderboard),
//             label: 'Progress',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people), // New icon for Community
//             label: 'Community',
//           ),
//           BottomNavigationBarItem( // New AI Chatbot entry
//             icon: Icon(Icons.auto_awesome),
//             label: 'AI Tutor',
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/widgets/gamification/level_path_painter.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';

// class LevelPathPainter extends CustomPainter {
//   final List<Offset> nodePositions;

//   LevelPathPainter({required this.nodePositions});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = AppColors.borderColor.withOpacity(0.5)
//       ..strokeWidth = 4.0
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     final completedPaint = Paint()
//       ..color = AppColors.successColor.withOpacity(0.7)
//       ..strokeWidth = 6.0
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     if (nodePositions.length < 2) {
//       return;
//     }

//     Path path = Path();
//     path.moveTo(nodePositions[0].dx, nodePositions[0].dy);

//     for (int i = 1; i < nodePositions.length; i++) {
//       // Draw a quadratic bezier curve for a smoother path
//       final controlPointX = (nodePositions[i - 1].dx + nodePositions[i].dx) / 2;
//       final controlPointY = nodePositions[i - 1].dy; // Keep Y closer to previous node for a gentle curve

//       path.quadraticBezierTo(
//         controlPointX,
//         controlPointY,
//         nodePositions[i].dx,
//         nodePositions[i].dy,
//       );
//     }
//     canvas.drawPath(path, paint);

//     // Optional: Draw a "completed" path segment in a different color
//     // This requires knowing which levels are completed, which is typically handled
//     // by passing more granular state down or calculating it here.
//     // For now, let's assume we can mark initial segments as completed.
//     // This is a placeholder for future enhancement to reflect actual progress.
//     if (nodePositions.length > 1) {
//       final completedPath = Path();
//       completedPath.moveTo(nodePositions[0].dx, nodePositions[0].dy);
//       // Example: Mark the first segment as completed if desired
//       // You would adapt this based on `isCompleted` status of levels
//       if (nodePositions.length > 1) {
//          final controlPointX = (nodePositions[0].dx + nodePositions[1].dx) / 2;
//          final controlPointY = nodePositions[0].dy;
//          completedPath.quadraticBezierTo(
//            controlPointX,
//            controlPointY,
//            nodePositions[1].dx,
//            nodePositions[1].dy,
//          );
//          canvas.drawPath(completedPath, completedPaint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return (oldDelegate as LevelPathPainter).nodePositions != nodePositions;
//   }
// }

// // lib/widgets/gamification/level_node.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/level.dart';

// class LevelNode extends StatelessWidget {
//   final Level level;
//   final bool isLocked;
//   final bool isCompleted;
//   final VoidCallback onTap;

//   const LevelNode({
//     super.key,
//     required this.level,
//     required this.isLocked,
//     required this.isCompleted,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Color nodeColor = AppColors.primaryColor;
//     Color iconColor = AppColors.textColor;
//     Color textColor = AppColors.textColor;
//     IconData icon = Icons.lock; // Default for locked

//     if (!isLocked) {
//       if (isCompleted) {
//         nodeColor = AppColors.successColor;
//         iconColor = AppColors.cardColor;
//         textColor = AppColors.cardColor;
//         icon = Icons.check_circle;
//       } else {
//         nodeColor = AppColors.accentColor;
//         iconColor = AppColors.cardColor;
//         textColor = AppColors.cardColor;
//         icon = Icons.play_arrow;
//       }
//     }

//     return GestureDetector(
//       onTap: isLocked ? null : onTap,
//       child: Column(
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: nodeColor,
//               border: Border.all(
//                 color: isLocked ? AppColors.borderColor : AppColors.accentColor,
//                 width: 3.0,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: nodeColor.withOpacity(0.6),
//                   blurRadius: isLocked ? 5 : 15,
//                   spreadRadius: isLocked ? 0 : 5,
//                 ),
//               ],
//             ),
//             child: level.imageAssetPath != null && level.imageAssetPath!.isNotEmpty
//                 ? ClipOval(
//                     child: Image.asset(
//                       level.imageAssetPath!,
//                       width: 80,
//                       height: 80,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Icon(icon, color: iconColor, size: 40);
//                       },
//                     ),
//                   )
//                 : Icon(
//                     icon,
//                     color: iconColor,
//                     size: 40,
//                   ),
//           ),
//           const SizedBox(height: AppConstants.spacing),
//           Text(
//             'Level ${level.order}',
//             style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                   color: AppColors.textColorSecondary,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//           Text(
//             level.title,
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   color: textColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//             textAlign: TextAlign.center,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/widgets/gamification/leaderboard_list.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/user_profile.dart';

// class LeaderboardList extends StatelessWidget {
//   final List<UserProfile> users;

//   const LeaderboardList({super.key, required this.users});

//   @override
//   Widget build(BuildContext context) {
//     if (users.isEmpty) {
//       return Center(
//         child: Text(
//           'No users on the leaderboard yet.',
//           style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//         ),
//       );
//     }

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: users.length,
//       itemBuilder: (context, index) {
//         final user = users[index];
//         final rank = index + 1;
//         Color rankColor = AppColors.textColorSecondary;
//         if (rank == 1) {
//           rankColor = AppColors.xpColor; // Gold for 1st
//         } else if (rank == 2) {
//           rankColor = AppColors.accentColor; // Silver for 2nd
//         } else if (rank == 3) {
//           rankColor = AppColors.levelColor; // Bronze for 3rd
//         }

//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//           color: AppColors.cardColor.withOpacity(0.9),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//           elevation: 2,
//           child: Padding(
//             padding: const EdgeInsets.all(AppConstants.padding),
//             child: Row(
//               children: [
//                 Container(
//                   width: 40,
//                   alignment: Alignment.center,
//                   child: Text(
//                     '$rank.',
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           color: rankColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                 ),
//                 const SizedBox(width: AppConstants.padding),
//                 CircleAvatar(
//                   radius: 24,
//                   backgroundImage: AssetImage(user.avatarAssetPath),
//                   onBackgroundImageError: (exception, stackTrace) {
//                     debugPrint('Error loading leaderboard avatar: $exception');
//                   },
//                 ),
//                 const SizedBox(width: AppConstants.padding),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         user.username,
//                         style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                               color: AppColors.textColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         'Level: ${user.level} • XP: ${user.xp}',
//                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                               color: AppColors.textColorSecondary,
//                             ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(Icons.local_fire_department, color: AppColors.xpColor, size: AppConstants.iconSize), // 🔥 icon
//                 const SizedBox(width: AppConstants.spacing / 2),
//                 Text(
//                   '${user.currentStreak}',
//                   style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                         color: AppColors.xpColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// // lib/widgets/gamification/badge_display.dart
// import 'package:flutter/material.dart' hide Badge; // Hide Badge from material.dart
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/badge.dart'; // Explicitly import your Badge model

// class BadgeDisplay extends StatelessWidget {
//   final List<Badge> badges;

//   const BadgeDisplay({super.key, required this.badges});

//   @override
//   Widget build(BuildContext context) {
//     if (badges.isEmpty) {
//       return Center(
//         child: Text(
//           'No badges to display yet.',
//           style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//         ),
//       );
//     }

//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3, // Adjust as needed
//         crossAxisSpacing: AppConstants.spacing,
//         mainAxisSpacing: AppConstants.spacing,
//         childAspectRatio: 0.8, // Adjust for badge image and text
//       ),
//       itemCount: badges.length,
//       itemBuilder: (context, index) {
//         final badge = badges[index];
//         return Card(
//           color: AppColors.cardColor.withOpacity(0.9),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//           elevation: 4,
//           child: InkWell(
//             onTap: () {
//               // Optionally show a detailed modal for the badge
//               _showBadgeDetail(context, badge);
//             },
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             child: Padding(
//               padding: const EdgeInsets.all(AppConstants.spacing),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     badge.imageUrl,
//                     width: AppConstants.badgeSize * 1.5,
//                     height: AppConstants.badgeSize * 1.5,
//                     fit: BoxFit.contain,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Icon(Icons.star, size: AppConstants.badgeSize * 1.5, color: AppColors.xpColor);
//                     },
//                   ),
//                   const SizedBox(height: AppConstants.spacing / 2),
//                   Text(
//                     badge.name,
//                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                           color: AppColors.textColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                     textAlign: TextAlign.center,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showBadgeDetail(BuildContext context, Badge badge) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: AppColors.cardColor.withOpacity(0.95),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//           title: Text(
//             badge.name,
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   color: AppColors.accentColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//             textAlign: TextAlign.center,
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset(
//                 badge.imageUrl,
//                 width: AppConstants.badgeSize * 2,
//                 height: AppConstants.badgeSize * 2,
//                 fit: BoxFit.contain,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Icon(Icons.star, size: AppConstants.badgeSize * 2, color: AppColors.xpColor);
//                 },
//               ),
//               const SizedBox(height: AppConstants.padding),
//               Text(
//                 badge.description,
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColor),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text(
//                 'Close',
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.accentColor),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
// // lib/widgets/gamification/avatar_customizer.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/avatar_asset.dart';

// class AvatarCustomizer extends StatelessWidget {
//   final List<AvatarAsset> availableAvatars;
//   final String? selectedAvatarId;
//   final Function(AvatarAsset) onAvatarSelected;

//   const AvatarCustomizer({
//     super.key,
//     required this.availableAvatars,
//     this.selectedAvatarId,
//     required this.onAvatarSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: const EdgeInsets.all(AppConstants.padding),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: AppConstants.padding,
//         mainAxisSpacing: AppConstants.padding,
//         childAspectRatio: 0.8,
//       ),
//       itemCount: availableAvatars.length,
//       itemBuilder: (context, index) {
//         final avatar = availableAvatars[index];
//         final bool isSelected = avatar.id == selectedAvatarId;

//         return GestureDetector(
//           onTap: () => onAvatarSelected(avatar),
//           child: AnimatedContainer(
//             duration: AppConstants.defaultAnimationDuration,
//             decoration: BoxDecoration(
//               color: isSelected ? AppColors.primaryColor.withOpacity(0.4) : AppColors.cardColor.withOpacity(0.7),
//               borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//               border: Border.all(
//                 color: isSelected ? AppColors.accentColor : Colors.transparent,
//                 width: isSelected ? 3.0 : 0.0,
//               ),
//               boxShadow: isSelected
//                   ? [
//                       BoxShadow(
//                         color: AppColors.accentColor.withOpacity(0.5),
//                         blurRadius: 10,
//                         spreadRadius: 2,
//                       ),
//                     ]
//                   : [],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   avatar.assetPath,
//                   width: AppConstants.avatarSize,
//                   height: AppConstants.avatarSize,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Icon(Icons.person, size: AppConstants.avatarSize, color: AppColors.errorColor);
//                   },
//                 ),
//                 const SizedBox(height: AppConstants.spacing),
//                 Text(
//                   avatar.name,
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         color: isSelected ? AppColors.accentColor : AppColors.textColor,
//                         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                       ),
//                   textAlign: TextAlign.center,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// // lib/widgets/feedback/personalized_feedback_modal.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class PersonalizedFeedbackModal extends StatelessWidget {
//   final String feedbackText;
//   final String? socraticFollowUp;
//   final String? adaptiveHints;
//   final String encouragement;
//   final bool isCorrect;

//   const PersonalizedFeedbackModal({
//     super.key,
//     required this.feedbackText,
//     this.socraticFollowUp,
//     this.adaptiveHints,
//     required this.encouragement,
//     this.isCorrect = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: AppColors.cardColor.withOpacity(0.95),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//       titlePadding: EdgeInsets.zero,
//       contentPadding: const EdgeInsets.all(AppConstants.padding),
//       title: Container(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         decoration: BoxDecoration(
//           color: isCorrect ? AppColors.successColor : AppColors.errorColor,
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.borderRadius)),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined,
//               color: AppColors.cardColor,
//               size: AppConstants.iconSize * 1.5,
//             ),
//             const SizedBox(width: AppConstants.spacing),
//             Expanded(
//               child: Text(
//                 isCorrect ? 'Correct Answer!' : 'Let\'s Review!',
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                       color: AppColors.cardColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       content: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               feedbackText,
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColor),
//             ),
//             if (socraticFollowUp != null && socraticFollowUp!.isNotEmpty) ...[
//               const SizedBox(height: AppConstants.padding),
//               Text(
//                 '🤔 Socratic Question:',
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       color: AppColors.primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               const SizedBox(height: AppConstants.spacing / 2),
//               Text(
//                 socraticFollowUp!,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
//               ),
//             ],
//             if (adaptiveHints != null && adaptiveHints!.isNotEmpty) ...[
//               const SizedBox(height: AppConstants.padding),
//               Text(
//                 '💡 Hint:',
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       color: AppColors.levelColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               const SizedBox(height: AppConstants.spacing / 2),
//               Text(
//                 adaptiveHints!,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
//               ),
//             ],
//             const SizedBox(height: AppConstants.padding),
//             Text(
//               encouragement,
//               style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                     color: AppColors.accentColor,
//                     fontWeight: FontWeight.bold,
//                     fontStyle: FontStyle.italic,
//                   ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text(
//             'Got It!',
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.accentColor),
//           ),
//         ),
//       ],
//     );
//   }
// }
// // lib/widgets/common/xp_level_display.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class XpLevelDisplay extends StatelessWidget {
//   final int xp;
//   final int level;
//   final bool showLabel; // New property to optionally show "XP" and "Level" labels

//   const XpLevelDisplay({
//     super.key,
//     required this.xp,
//     required this.level,
//     this.showLabel = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppConstants.spacing,
//         vertical: AppConstants.spacing / 2,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.cardColor.withOpacity(0.7),
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         border: Border.all(color: AppColors.borderColor, width: 1.0),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.star, color: AppColors.xpColor, size: AppConstants.iconSize),
//           const SizedBox(width: AppConstants.spacing / 2),
//           Text(
//             '${showLabel ? 'XP: ' : ''}$xp',
//             style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                   color: AppColors.xpColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//           const SizedBox(width: AppConstants.spacing),
//           Icon(Icons.military_tech, color: AppColors.levelColor, size: AppConstants.iconSize),
//           const SizedBox(width: AppConstants.spacing / 2),
//           Text(
//             '${showLabel ? 'Level: ' : ''}$level',
//             style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                   color: AppColors.levelColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/widgets/common/progress_bar.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class ProgressBar extends StatelessWidget {
//   final double progress; // Value between 0.0 and 1.0
//   final double? width;
//   final double height;
//   final Color backgroundColor;
//   final Color foregroundColor;
//   final String? label;

//   const ProgressBar({
//     super.key,
//     required this.progress,
//     this.width,
//     this.height = 10.0,
//     this.backgroundColor = AppColors.borderColor,
//     this.foregroundColor = AppColors.accentColor,
//     this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (label != null)
//           Padding(
//             padding: const EdgeInsets.only(bottom: AppConstants.spacing / 4),
//             child: Text(
//               label!,
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColorSecondary),
//             ),
//           ),
//         Container(
//           width: width,
//           height: height,
//           decoration: BoxDecoration(
//             color: backgroundColor,
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
//           ),
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               return Stack(
//                 children: [
//                   FractionallySizedBox(
//                     widthFactor: progress.clamp(0.0, 1.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: foregroundColor,
//                         borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
// // lib/widgets/common/loading_indicator.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class LoadingIndicator extends StatelessWidget {
//   final String message;

//   const LoadingIndicator({
//     super.key,
//     this.message = 'Loading...',
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black.withOpacity(0.7), // Semi-transparent black overlay
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
//               strokeWidth: 4,
//             ),
//             const SizedBox(height: AppConstants.padding),
//             Text(
//               message,
//               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                     color: AppColors.textColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: AppConstants.spacing),
//             Text(
//               'Please wait, this might take a moment...',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     color: AppColors.textColorSecondary,
//                   ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // lib/widgets/common/custom_app_bar.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final Widget? leadingWidget;
//   final Widget? trailingWidget;

//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.leadingWidget,
//     this.trailingWidget,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(
//         title,
//         style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//               color: AppColors.textColor,
//               fontWeight: FontWeight.bold,
//             ),
//       ),
//       centerTitle: true,
//       backgroundColor: AppColors.primaryColor,
//       elevation: 0,
//       leading: Padding(
//         padding: const EdgeInsets.only(left: AppConstants.padding),
//         child: leadingWidget,
//       ),
//       leadingWidth: 80, // Adjust based on leading widget size
//       actions: [
//         if (trailingWidget != null)
//           Padding(
//             padding: const EdgeInsets.only(right: AppConstants.padding),
//             child: trailingWidget,
//           ),
//       ],
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           bottom: Radius.circular(AppConstants.borderRadius),
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
// // lib/widgets/cards/mission_card.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class MissionCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final int xpReward;
//   final bool isCompleted;
//   final VoidCallback? onTap;

//   const MissionCard({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.xpReward,
//     this.isCompleted = false,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: isCompleted ? AppColors.successColor.withOpacity(0.8) : AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         side: isCompleted
//             ? const BorderSide(color: AppColors.successColor, width: 2)
//             : BorderSide.none,
//       ),
//       elevation: 4,
//       child: InkWell(
//         onTap: isCompleted ? null : onTap,
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         child: Padding(
//           padding: const EdgeInsets.all(AppConstants.padding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       title,
//                       style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                             color: isCompleted ? AppColors.cardColor : AppColors.textColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   if (isCompleted)
//                     const Icon(Icons.check_circle, color: AppColors.cardColor, size: 30)
//                   else
//                     Row(
//                       children: [
//                         Icon(Icons.star, color: AppColors.xpColor, size: AppConstants.iconSize),
//                         const SizedBox(width: AppConstants.spacing / 2),
//                         Text(
//                           '$xpReward XP',
//                           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                                 color: AppColors.xpColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Text(
//                 description,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: isCompleted ? AppColors.cardColor.withOpacity(0.9) : AppColors.textColorSecondary,
//                     ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/cards/level_card.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/level.dart';

// class LevelCard extends StatelessWidget {
//   final Level level;
//   final VoidCallback? onTap;
//   final bool isCompleted;
//   final bool isLocked;
//   final bool isCurrentOrNextPlayable;

//   const LevelCard({
//     super.key,
//     required this.level,
//     this.onTap,
//     this.isCompleted = false,
//     this.isLocked = false,
//     this.isCurrentOrNextPlayable = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Opacity(
//       opacity: isLocked ? 0.6 : 1.0,
//       child: Card(
//         margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//         color: AppColors.cardColor.withOpacity(0.9),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           side: isCompleted
//               ? const BorderSide(color: AppColors.successColor, width: 2)
//               : isCurrentOrNextPlayable
//                   ? const BorderSide(color: AppColors.accentColor, width: 1)
//                   : BorderSide.none,
//         ),
//         elevation: 4,
//         child: InkWell(
//           onTap: isLocked ? null : onTap,
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           child: Padding(
//             padding: const EdgeInsets.all(AppConstants.padding),
//             child: Row(
//               children: [
//                 // Level Icon / Image
//                 Container(
//                   width: AppConstants.avatarSize,
//                   height: AppConstants.avatarSize,
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
//                     image: level.imageAssetPath != null && level.imageAssetPath!.isNotEmpty
//                         ? DecorationImage(
//                             image: AssetImage(level.imageAssetPath!),
//                             fit: BoxFit.cover,
//                             onError: (exception, stackTrace) {
//                               debugPrint('Error loading level image: ${level.imageAssetPath!} - $exception');
//                             },
//                           )
//                         : null,
//                   ),
//                   child: level.imageAssetPath == null || level.imageAssetPath!.isEmpty
//                       ? Icon(Icons.bookmark, color: AppColors.textColor, size: AppConstants.iconSize * 1.5)
//                       : null,
//                 ),
//                 const SizedBox(width: AppConstants.padding),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Level ${level.order}: ${level.title}',
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                               color: AppColors.textColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: AppConstants.mediumTextSize, // Smaller text
//                             ),
//                       ),
//                       const SizedBox(height: AppConstants.spacing / 2),
//                       Text(
//                         level.description,
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                               color: AppColors.textColorSecondary,
//                               fontSize: AppConstants.smallTextSize, // Smaller text
//                             ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       Row(
//                         children: [
//                           Icon(Icons.star, color: AppColors.xpColor, size: AppConstants.iconSize * 0.8), // Smaller icon
//                           const SizedBox(width: AppConstants.spacing / 2),
//                           Text(
//                             'Difficulty: ${level.difficulty}',
//                             style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                                   color: AppColors.xpColor,
//                                   fontSize: AppConstants.extraSmallTextSize, // Smaller text
//                                 ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (isCompleted)
//                   const Icon(Icons.check_circle, color: AppColors.successColor, size: 36)
//                 else if (isLocked)
//                   const Icon(Icons.lock, color: AppColors.textColorSecondary, size: 36)
//                 else
//                   const Icon(Icons.play_circle_fill, color: AppColors.accentColor, size: 36),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/cards/current_lesson_card.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/widgets/common/progress_bar.dart';

// class CurrentLessonCard extends StatelessWidget {
//   final String courseTitle;
//   final String lessonTitle;
//   final double progress; // Progress of the current lesson (0.0 to 1.0)
//   final VoidCallback? onTap;

//   const CurrentLessonCard({
//     super.key,
//     required this.courseTitle,
//     required this.lessonTitle,
//     required this.progress,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//       ),
//       elevation: 6,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         child: Padding(
//           padding: const EdgeInsets.all(AppConstants.padding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 courseTitle,
//                 style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                       color: AppColors.textColorSecondary,
//                       fontStyle: FontStyle.italic,
//                     ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Text(
//                 lessonTitle,
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                       color: AppColors.textColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: AppConstants.padding),
//               ProgressBar(
//                 progress: progress,
//                 height: 15,
//                 label: 'Lesson Progress: ${(progress * 100).toInt()}%',
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: FilledButton.icon(
//                   onPressed: onTap,
//                   icon: const Icon(Icons.play_arrow),
//                   label: const Text('Continue Lesson'),
//                   style: FilledButton.styleFrom(
//                     backgroundColor: AppColors.accentColor,
//                     foregroundColor: AppColors.cardColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/cards/course_card.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/course.dart';

// class CourseCard extends StatelessWidget {
//   final Course course;
//   final VoidCallback onTap;
//   final Function(String courseId, List<String> levelIds)? onDelete; // Optional delete callback

//   const CourseCard({
//     super.key,
//     required this.course,
//     required this.onTap,
//     this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//       ),
//       elevation: 6,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         child: Padding(
//           padding: const EdgeInsets.all(AppConstants.padding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       course.title,
//                       style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                             color: AppColors.textColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: AppConstants.largeTextSize, // Small text size
//                           ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   if (onDelete != null)
//                     IconButton(
//                       icon: const Icon(Icons.delete_forever, color: AppColors.errorColor),
//                       onPressed: () => onDelete!(course.id, course.levelIds),
//                       tooltip: 'Delete Course',
//                     ),
//                 ],
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Text(
//                 course.description,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: AppColors.textColorSecondary,
//                       fontSize: AppConstants.mediumTextSize, // Small text size
//                     ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildInfoChip(
//                     context,
//                     'Difficulty: ${course.difficulty}',
//                     Icons.star,
//                     AppColors.xpColor,
//                   ),
//                   _buildInfoChip(
//                     context,
//                     'Genre: ${course.gameGenre}',
//                     Icons.casino,
//                     AppColors.levelColor,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(BuildContext context, String text, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppConstants.spacing,
//         vertical: AppConstants.spacing / 2,
//       ),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: color, size: AppConstants.iconSize * 0.8), // Small icon
//           const SizedBox(width: AppConstants.spacing / 2),
//           Text(
//             text,
//             style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                   color: color,
//                   fontSize: AppConstants.extraSmallTextSize, // Smaller text
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/utils/validation_utils.dart
// class ValidationUtils {
//   static String? validateNotEmpty(String? value, String errorMessage) {
//     if (value == null || value.trim().isEmpty) {
//       return errorMessage;
//     }
//     return null;
//   }

//   static String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email cannot be empty';
//     }
//     final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
//     if (!emailRegex.hasMatch(value)) {
//       return 'Enter a valid email address';
//     }
//     return null;
//   }

//   static String? validatePassword(String? value, {int minLength = 6}) {
//     if (value == null || value.isEmpty) {
//       return 'Password cannot be empty';
//     }
//     if (value.length < minLength) {
//       return 'Password must be at least $minLength characters long';
//     }
//     return null;
//   }

//   static String? validateConfirmPassword(String? password, String? confirmPassword) {
//     if (confirmPassword == null || confirmPassword.isEmpty) {
//       return 'Confirm password cannot be empty';
//     }
//     if (password != confirmPassword) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   static String? validateYoutubeUrl(String? url) {
//     if (url == null || url.isEmpty) {
//       return null; // URL can be empty if not provided
//     }
//     // Regex for YouTube video URLs
//     final youtubeRegex = RegExp(
//         r'^(https?:\/\/)?(www\.)?(youtube\.com|youtu\.be)\/.+$',
//         caseSensitive: false
//     );
//     if (!youtubeRegex.hasMatch(url)) {
//       return 'Please enter a valid YouTube URL';
//     }
//     return null;
//   }
// }
// // lib/utils/url_launcher_util.dart
// // This file is a placeholder. For actual URL launching, you would use
// // a package like `url_launcher`. Due to sandbox limitations, direct URL
// // launching is not available in the current environment.

// import 'package:flutter/material.dart'; // Just for ScaffoldMessenger and Text
// import 'package:url_launcher/url_launcher.dart'; // Typically imported for real usage

// class UrlLauncherUtil {
//   static Future<void> launchInBrowser(String url) async {
//     // In a real Flutter app, you'd use:
//     /*
//     final Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not launch $url';
//     }
//     */

//     // Placeholder for demo:
//     debugPrint('Attempted to launch URL: $url (simulated)');
//     // In a real app, you might show a snackbar or dialog if launching fails.
//     // For this demo, we'll just print to console.
//   }
// }
// // lib/utils/file_picker_util.dart
// // This file is a placeholder. For actual file picking, you would use
// // a package like `file_picker`. Due to sandbox limitations, direct file system
// // access is not available in the current environment.
// // For the purpose of this demo, we'll assume text input or URL input
// // covers the 'source content' requirement in CourseCreationScreen.

// import 'package:flutter/material.dart'; // Just for ScaffoldMessenger and Text

// class FilePickerUtil {
//   // This method would typically open a file picker dialog.
//   // For this simulated environment, we'll just return a placeholder.
//   static Future<String?> pickTextFileContent() async {
//     // In a real Flutter app, you'd use:
//     /*
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['txt', 'md'],
//     );
//     if (result != null && result.files.single.path != null) {
//       final file = File(result.files.single.path!);
//       return await file.readAsString();
//     }
//     return null;
//     */

//     // Placeholder for demo:
//     debugPrint('File picking is simulated. Please use the text area for content.');
//     return null; // Return null to indicate no file was picked
//   }

//   // This method would typically open a file picker dialog for image assets.
//   static Future<String?> pickImageAssetPath() async {
//     // In a real Flutter app, you'd use:
//     /*
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: false,
//     );
//     if (result != null && result.files.single.path != null) {
//       // For local assets, you might save the file to app's documents directory
//       // or just get its path if it's already an asset.
//       return result.files.single.path;
//     }
//     return null;
//     */
//     debugPrint('Image asset picking is simulated. Use predefined assets or manual path input.');
//     return null; // Return null
//   }
// }
// // lib/utils/app_router.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/screens/splash_screen.dart';
// import 'package:gamifier/screens/auth_screen.dart';
// import 'package:gamifier/screens/home_screen.dart';
// import 'package:gamifier/screens/course_creation_screen.dart';
// import 'package:gamifier/screens/lesson_screen.dart';
// import 'package:gamifier/screens/progress_screen.dart';
// import 'package:gamifier/screens/profile_screen.dart';
// import 'package:gamifier/screens/avatar_customizer_screen.dart';
// import 'package:gamifier/screens/onboarding_screen.dart';
// import 'package:gamifier/screens/level_selection_screen.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/screens/level_completion_screen.dart';
// import 'package:gamifier/screens/course_completion_screen.dart';
// import 'package:gamifier/screens/community_screen.dart';
// import 'package:gamifier/screens/ai_chat_screen.dart';

// class AppRouter {
//   static const String splashRoute = '/';
//   static const String authRoute = '/auth';
//   static const String homeRoute = '/home';
//   static const String courseCreationRoute = '/create-course';
//   static const String lessonRoute = '/lesson';
//   static const String progressRoute = '/progress';
//   static const String profileRoute = '/profile';
//   static const String avatarCustomizerRoute = '/avatar-customizer';
//   static const String onboardingRoute = '/onboarding';
//   static const String levelSelectionRoute = '/level-selection';
//   static const String levelCompletionRoute = '/level-completion';
//   static const String courseCompletionRoute = '/course-completion';
//   static const String communityRoute = '/community';
//   static const String aiChatRoute = '/ai-chat';

//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case splashRoute:
//         return MaterialPageRoute(builder: (_) => const SplashScreen());
//       case authRoute:
//         return MaterialPageRoute(builder: (_) => const AuthScreen());
//       case homeRoute:
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//       case courseCreationRoute:
//         return MaterialPageRoute(builder: (_) => const CourseCreationScreen());
//       case lessonRoute:
//         final args = settings.arguments as Map<String, dynamic>;
//         return MaterialPageRoute(
//           builder: (_) => LessonScreen(
//             courseId: args['courseId'] as String,
//             levelId: args['levelId'] as String,
//             lessonId: args['lessonId'] as String,
//           ),
//         );
//       case progressRoute:
//         return MaterialPageRoute(builder: (_) => const ProgressScreen());
//       case profileRoute:
//         return MaterialPageRoute(builder: (_) => const ProfileScreen());
//       case avatarCustomizerRoute:
//         return MaterialPageRoute(builder: (_) => const AvatarCustomizerScreen());
//       case onboardingRoute:
//         return MaterialPageRoute(builder: (_) => const OnboardingScreen());
//       case levelSelectionRoute:
//         // Ensure Course object is passed directly
//         final course = settings.arguments as Course;
//         return MaterialPageRoute(builder: (_) => LevelSelectionScreen(course: course));
//       case levelCompletionRoute:
//         final args = settings.arguments as Map<String, dynamic>;
//         return MaterialPageRoute(
//           builder: (_) => LevelCompletionScreen(
//             courseId: args['courseId'] as String,
//             levelId: args['levelId'] as String,
//             totalXpEarned: args['totalXpEarned'] as int,
//             levelScore: args['levelScore'] as int,
//             lessonsCompleted: args['lessonsCompleted'] as int,
//             totalLessons: args['totalLessons'] as int,
//           ),
//         );
//       case courseCompletionRoute:
//         final args = settings.arguments as Map<String, dynamic>;
//         return MaterialPageRoute(
//           builder: (_) => CourseCompletionScreen(
//             courseTitle: args['courseTitle'] as String,
//             totalXpEarnedInCourse: args['totalXpEarnedInCourse'] as int,
//             totalLevelsCompleted: args['totalLevelsCompleted'] as int,
//             totalLevelsInCourse: args['totalLevelsInCourse'] as int,
//           ),
//         );
//       case communityRoute:
//         return MaterialPageRoute(builder: (_) => const CommunityScreen());
//       case aiChatRoute:
//         return MaterialPageRoute(builder: (_) => const AIChatScreen());
//       default:
//         return MaterialPageRoute(builder: (_) => Text('Error: Unknown route ${settings.name}'));
//     }
//   }
// }
// // lib/utils/app_extensions.dart
// extension IterableExtensions<T> on Iterable<T> {
//   /// Returns the first element that satisfies the given predicate [test].
//   ///
//   /// Returns `null` if no element satisfies [test].
//   T? firstWhereOrNull(bool Function(T element) test) {
//     for (var element in this) {
//       if (test(element)) {
//         return element;
//       }
//     }
//     return null;
//   }
// }
// // lib/services/gemini_api_service.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/models/user_progress.dart';

// class GeminiApiService {
//   static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';
//   final String _apiKey = AppConstants.geminiApiKey;

//   Future<Map<String, dynamic>> _callGeminiApi(Map<String, dynamic> payload) async {
//     if (_apiKey.isEmpty || _apiKey == 'YOUR_GEMINI_API_HERE') {
//       throw Exception('Gemini API Key is not configured. Please set it in app_constants.dart');
//     }

//     final url = Uri.parse('$_baseUrl?key=$_apiKey');

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(payload),
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseBody = json.decode(response.body);
//         if (responseBody.containsKey('error')) {
//           throw Exception('Gemini API Error: ${responseBody['error']['message']}');
//         }
//         if (responseBody['candidates'] != null &&
//             responseBody['candidates'].isNotEmpty &&
//             responseBody['candidates'][0]['content'] != null &&
//             responseBody['candidates'][0]['content']['parts'] != null &&
//             responseBody['candidates'][0]['content']['parts'].isNotEmpty) {
//           return responseBody;
//         } else {
//           throw Exception('Gemini API response did not contain expected content structure.');
//         }
//       } else {
//         debugPrint('Gemini API Error - Status Code: ${response.statusCode}');
//         debugPrint('Response Body: ${response.body}');
//         throw Exception('Failed to call Gemini API: ${response.statusCode} - ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Network or parsing error calling Gemini API: $e');
//     }
//   }

//   String _extractJsonString(String text) {
//     String cleanedText = text;

//     final jsonCodeBlockRegex = RegExp(r'```json\s*(\{[\s\S]*?\})\s*```', dotAll: true);
//     final jsonCodeBlockMatch = jsonCodeBlockRegex.firstMatch(text);
//     if (jsonCodeBlockMatch != null && jsonCodeBlockMatch.group(1) != null) {
//       return jsonCodeBlockMatch.group(1)!;
//     }

//     final standaloneJsonRegex = RegExp(r'\{[\s\S]*\}', dotAll: true);
//     final allMatches = standaloneJsonRegex.allMatches(text);

//     String? bestValidJson;
//     for (final match in allMatches) {
//       String potentialJson = match.group(0)!;
//       potentialJson = potentialJson.trim();

//       try {
//         json.decode(potentialJson);
//         if (bestValidJson == null || potentialJson.length > bestValidJson.length) {
//           bestValidJson = potentialJson;
//         }
//       } on FormatException {
//       }
//     }

//     if (bestValidJson != null) {
//       return bestValidJson;
//     }

//     cleanedText = cleanedText.trim();
//     if (cleanedText.startsWith('```json')) {
//       cleanedText = cleanedText.substring('```json'.length).trim();
//     } else if (cleanedText.startsWith('```')) {
//       cleanedText = cleanedText.substring('```'.length).trim();
//     }
//     if (cleanedText.endsWith('```')) {
//       cleanedText = cleanedText.substring(0, cleanedText.length - '```'.length).trim();
//     }

//     int openBraces = 0;
//     int closeBraces = 0;
//     bool inString = false;
//     StringBuffer repairedJson = StringBuffer();

//     for (int i = 0; i < cleanedText.length; i++) {
//       String char = cleanedText[i];
//       if (char == '\\' && i + 1 < cleanedText.length) {
//         repairedJson.write(char);
//         repairedJson.write(cleanedText[++i]);
//         continue;
//       }

//       if (char == '"') {
//         inString = !inString;
//       } else if (char == '{' && !inString) {
//         openBraces++;
//       } else if (char == '}' && !inString) {
//         closeBraces++;
//       }
//       repairedJson.write(char);
//     }

//     while (openBraces > closeBraces) {
//       repairedJson.write('}');
//       closeBraces++;
//     }

//     if (inString) {
//       repairedJson.write('"');
//     }

//     String finalRepairedText = repairedJson.toString();
//     return finalRepairedText;
//   }

//   Future<Map<String, dynamic>> generateCourseContent({
//     required String topicName,
//     required String ageGroup,
//     required String domain,
//     required String difficulty,
//     String? educationLevel,
//     String? specialty,
//     String? sourceContent,
//     String? youtubeUrl,
//   }) async {
//     String prompt = '''
//     As an AI-powered gamification engine, your task is to transform a static course topic into an interactive, game-based learning module.
//     Generate a complete course structure including:
//     - courseTitle: A catchy title for the course.
//     - gameGenre: A suitable game genre for the course (e.g., "Fantasy", "Sci-Fi", "Adventure", "Mystery", "Cyberpunk"). Choose one from: ${AppConstants.gameThemes.join(', ')}.
//     - difficulty: The difficulty level of the course ("Beginner", "Intermediate", "Advanced", "Expert").
//     - levels: An array of 10 to 15 distinct levels, ordered from easy to hard, each tailored to the course's difficulty. Each level should have:
//         - id: A unique string ID for the level (e.g., "level_1").
//         - title: The title of the level.
//         - description: A brief, engaging description of the level.
//         - difficulty: The specific difficulty of this level (e.g., "Easy", "Medium"). The difficulty should progressively increase with the level order.
//         - order: An integer representing the sequential order of the level (e.g., 1, 2, 3...).
//         - imageAssetPath: An optional path to a local asset image for this level's icon/visual (e.g., "assets/level_icons/level1.png", "assets/level_icons/level2.png"). Create unique, descriptive paths for each.
//         - lessons: An array of 1-3 detailed lessons. Each lesson should have:
//             - id: A unique string ID for the lesson (e.g., "lesson_1_1").
//             - title: The title of the lesson.
//             - content: Comprehensive learning material for the lesson (min 200 words), suitable for a college student, formatted in Markdown.
//             - questions: An array of 3-5 small, interesting, and engaging questions for the lesson, appropriate for the level's difficulty. Each question should have:
//                 - id: A unique string ID for the question (e.g., "q1_lesson_1_1").
//                 - questionText: The question itself.
//                 - xpReward: An integer for XP reward (e.g., 10, 15, 20), appropriate for the question difficulty.
//                 - type: One of "MCQ", "FillInBlank", "ShortAnswer", "Scenario". Favor a mix of types for variety.
//                 - specific fields based on type (if applicable):
//                     - For MCQ: options (List<String>), correctAnswer (String, one of options). Ensure options are distinct and plausible, and there is only ONE correct option.
//                     - For FillInBlank: correctAnswer (String).
//                     - For ShortAnswer: expectedAnswerKeywords (String, comma-separated keywords for evaluation).
//                     - For Scenario: scenarioText (String, concise and engaging), expectedOutcome (String).

//     The course is for "$topicName" for college students in the "$domain" domain, with an overall "$difficulty" difficulty level.
//     The user's education level is "$educationLevel" and their specialty is "$specialty". Tailor content and examples to these if relevant.
//     ''';

//     if (sourceContent != null && sourceContent.isNotEmpty) {
//       prompt += '''
//       \n\nUse the following provided text as the primary source material for generating the course content, lessons, and questions. Focus on the key concepts and details within this text:\n\n"$sourceContent"
//       ''';
//     } else if (youtubeUrl != null && youtubeUrl.isNotEmpty) {
//       prompt += '''
//       \n\nConsider the topic "$topicName" as if it were a YouTube video found at this URL: $youtubeUrl. Generate the course content, lessons, and questions based on what you would expect to be covered in such a video. If possible, imagine and use key points or a transcript from this video to structure the content.
//       ''';
//     }

//     prompt += '''
//     \n\nOutput ONLY the JSON object. Do NOT include any descriptive text, markdown code block fences (\`\`\`json), or any other characters outside the JSON structure.
//     All string values within the JSON, especially multi-line content or text containing special characters (like backslashes, double quotes, or newlines), MUST be correctly escaped for JSON validity. For example, newlines should be "\\\\n", double quotes should be "\\\\\\"", and backslashes should be "\\\\\\\\".
//     The output MUST be a JSON object conforming to the following schema.
//     ''';

//     final payload = {
//       "contents": [
//         {"role": "user", "parts": [{"text": prompt}]}
//       ],
//       "generationConfig": {
//         "responseMimeType": "application/json",
//         "responseSchema": {
//           "type": "OBJECT",
//           "properties": {
//             "courseTitle": {"type": "STRING"},
//             "gameGenre": {"type": "STRING"},
//             "difficulty": {"type": "STRING"},
//             "levels": {
//               "type": "ARRAY",
//               "items": {
//                 "type": "OBJECT",
//                 "properties": {
//                   "id": {"type": "STRING"},
//                   "title": {"type": "STRING"},
//                   "description": {"type": "STRING"},
//                   "difficulty": {"type": "STRING"},
//                   "order": {"type": "INTEGER"},
//                   "imageAssetPath": {"type": "STRING"}, // New
//                   "lessons": {
//                     "type": "ARRAY",
//                     "items": {
//                       "type": "OBJECT",
//                       "properties": {
//                         "id": {"type": "STRING"},
//                         "title": {"type": "STRING"},
//                         "content": {"type": "STRING"},
//                         "questions": {
//                           "type": "ARRAY",
//                           "items": {
//                             "type": "OBJECT",
//                             "properties": {
//                               "id": {"type": "STRING"},
//                               "questionText": {"type": "STRING"},
//                               "xpReward": {"type": "INTEGER"},
//                               "type": {"type": "STRING"},
//                               "options": {
//                                 "type": "ARRAY",
//                                 "items": {"type": "STRING"}
//                               },
//                               "correctAnswer": {"type": "STRING"},
//                               "expectedAnswerKeywords": {"type": "STRING"},
//                               "scenarioText": {"type": "STRING"},
//                               "expectedOutcome": {"type": "STRING"},
//                             },
//                             "required": ["id", "questionText", "xpReward", "type"]
//                           }
//                         }
//                       },
//                       "required": ["id", "title", "content", "questions"]
//                     }
//                   }
//                 },
//                 "required": ["id", "title", "description", "difficulty", "order", "lessons"]
//               }
//             }
//           },
//           "required": ["courseTitle", "gameGenre", "difficulty", "levels"]
//         }
//       },
//       "safetySettings": [
//         {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"},
//         {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_NONE"},
//         {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_NONE"},
//         {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_NONE"}
//       ]
//     };

//     try {
//       final responseBody = await _callGeminiApi(payload);
//       final String rawJsonString = responseBody['candidates'][0]['content']['parts'][0]['text'];
//       String extractedJsonString = rawJsonString;

//       try {
//         extractedJsonString = _extractJsonString(rawJsonString);
//         return json.decode(extractedJsonString);
//       } on FormatException catch (e, stacktrace) {
//         debugPrint('FormatException during JSON decoding. Raw response: \n$rawJsonString');
//         debugPrint('Extracted string attempt: \n$extractedJsonString');
//         debugPrint('Decoding error: $e');
//         debugPrint('Stacktrace: $stacktrace');
//         throw Exception('Failed to parse AI response: JSON is malformed. Details: $e. Raw: "$rawJsonString"');
//       }
//     } catch (e) {
//       debugPrint('Error generating course content: $e');
//       rethrow;
//     }
//   }

//   Future<Map<String, dynamic>> generateSocraticFeedback({
//     required String userAnswer,
//     required String questionText,
//     required String correctAnswer,
//     required String lessonContent,
//     UserProgress? userProgress,
//   }) async {
//     String userProgressContext = "No prior specific lesson progress available.";
//     if (userProgress != null) {
//       userProgressContext = "User's overall progress: "
//           "Last lesson: ${userProgress.currentLessonId ?? 'N/A'}. "
//           "Completed lessons count: ${userProgress.lessonsProgress.values.where((p) => p.isCompleted).length}.";
//     }

//     final String prompt = '''
//     You are an AI tutor designed to provide personalized, Socratic feedback to college students.
//     Your goal is to guide students to understand concepts deeply, not just give answers.
    
//     Here is the context:
//     - User's Answer: "$userAnswer"
//     - Correct Answer: "$correctAnswer"
//     - Question Text: "$questionText"
//     - Lesson Content (for contextual understanding): "$lessonContent"
//     - User's Prior Progress Summary: "$userProgressContext"
    
//     Based on this information, provide feedback in the following JSON format.
    
//     Output ONLY the JSON object. Do NOT include any descriptive text or markdown code block fences (\`\`\`json).
//     All string values within the JSON, especially multi-line content or text containing special characters (like backslashes, double quotes, or newlines), MUST be correctly escaped for JSON validity. For example, newlines should be "\\\\n", double quotes should be "\\\\\\"", and backslashes should be "\\\\\\\\".
//     The output MUST be a JSON object conforming to the following schema.
//     {
//       "feedbackText": "Your feedback here...",
//       "socraticFollowUp": "A question to make them think...",
//       "adaptiveHints": "Subtle hints based on their answer...",
//       "encouragement": "Encouraging words adapted to their performance..."
//     }
//     ''';

//     final payload = {
//       "contents": [
//         {"role": "user", "parts": [{"text": prompt}]}
//       ],
//       "generationConfig": {
//         "responseMimeType": "application/json",
//         "responseSchema": {
//           "type": "OBJECT",
//           "properties": {
//             "feedbackText": {"type": "STRING"},
//             "socraticFollowUp": {"type": "STRING"},
//             "adaptiveHints": {"type": "STRING"},
//             "encouragement": {"type": "STRING"}
//           },
//           "required": ["feedbackText", "encouragement"]
//         }
//       },
//       "safetySettings": [
//         {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"},
//         {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_NONE"},
//         {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_NONE"},
//         {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_NONE"}
//       ]
//     };

//     try {
//       final responseBody = await _callGeminiApi(payload);
//       final String rawJsonString = responseBody['candidates'][0]['content']['parts'][0]['text'];
//       String extractedJsonString = rawJsonString;

//       try {
//         extractedJsonString = _extractJsonString(rawJsonString);
//         return json.decode(extractedJsonString);
//       } on FormatException catch (e, stacktrace) {
//         debugPrint('FormatException during JSON decoding. Raw response: \n$rawJsonString');
//         debugPrint('Extracted string attempt: \n$extractedJsonString');
//         debugPrint('Decoding error: $e');
//         debugPrint('Stacktrace: $stacktrace');
//         throw Exception('Failed to parse AI response: JSON is malformed. Details: $e. Raw: "$rawJsonString"');
//       }
//     } catch (e) {
//       debugPrint('Error generating Socratic feedback: $e');
//       rethrow;
//     }
//   }

//   Future<Map<String, dynamic>> generateAIChatResponse({
//     required List<Map<String, dynamic>> chatHistory,
//     String userContext = '',
//     String userCourseProgressContext = '',
//   }) async {
//     List<Map<String, dynamic>> conversation = [
//       {
//         "role": "user",
//         "parts": [
//           {"text": "You are an AI tutor named 'Gamifier Tutor'. Your primary goal is to help college students learn by providing clear explanations, guiding them with Socratic questions, offering hints, and clarifying concepts. You should always be encouraging and adapt your responses to the user's reported education level and specialty. If you don't know the answer, admit it. Keep your answers concise but comprehensive. Focus on academic topics. Current user context: $userContext Current user course progress context: $userCourseProgressContext"}
//         ]
//       },
//       ...chatHistory,
//     ];

//     final payload = {
//       "contents": conversation,
//       "generationConfig": {
//         "temperature": AppConstants.geminiTemperature,
//         "maxOutputTokens": AppConstants.geminiMaxOutputTokens,
//       },
//       "safetySettings": [
//         {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"},
//         {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_NONE"},
//         {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_NONE"},
//         {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_NONE"}
//       ]
//     };

//     try {
//       final responseBody = await _callGeminiApi(payload);
//       final String responseText = responseBody['candidates'][0]['content']['parts'][0]['text'];
//       return {'text': responseText};
//     } catch (e) {
//       debugPrint('Error generating AI chat response: $e');
//       rethrow;
//     }
//   }
// }
// // lib/services/firebase_service.dart
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:gamifier/models/lesson.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/models/badge.dart';
// import 'package:gamifier/models/level.dart';
// import 'package:gamifier/models/community_post.dart'; // New import for social features
// import 'package:gamifier/constants/app_constants.dart';

// class FirebaseService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Stream<User?> get authStateChanges => _auth.authStateChanges();

//   User? get currentUser => _auth.currentUser;

//   String generateNewDocId() {
//     return _firestore.collection('dummy').doc().id;
//   }

//   Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       await _ensureUserProfileExists(userCredential.user!);
//       await _updateUserStreak(userCredential.user!.uid); // Update streak on login
//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         throw FirebaseAuthException(code: 'user-not-found', message: 'No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         throw FirebaseAuthException(code: 'wrong-password', message: 'Wrong password provided.');
//       }
//       rethrow;
//     } catch (e) {
//       throw Exception('An unexpected error occurred during sign-in: $e');
//     }
//   }

//   Future<UserCredential> registerWithEmailAndPassword(String email, String password, String username) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       if (userCredential.user != null) {
//         await createUserProfile(userCredential.user!.uid, username);
//       }
//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         throw FirebaseAuthException(code: 'weak-password', message: 'The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         throw FirebaseAuthException(code: 'email-already-in-use', message: 'An account already exists for that email.');
//       }
//       rethrow;
//     } catch (e) {
//       throw Exception('An unexpected error occurred during registration: $e');
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       throw Exception('Error signing out: $e');
//     }
//   }

//   Future<void> _ensureUserProfileExists(User user) async {
//     final userDoc = _firestore.collection(AppConstants.usersCollection).doc(user.uid);
//     final docSnapshot = await userDoc.get();

//     if (!docSnapshot.exists) {
//       await createUserProfile(user.uid, user.displayName ?? 'New Learner');
//     }
//   }

//   Future<void> createUserProfile(String uid, String username, {String? educationLevel, String? specialty}) async {
//     final userProfile = UserProfile(
//       uid: uid,
//       username: username,
//       createdAt: DateTime.now(),
//       educationLevel: educationLevel,
//       specialty: specialty,
//       currentStreak: AppConstants.initialStreak, // Initialize streak
//       lastStreakUpdate: DateTime.now(), // Set initial streak update time
//     );
//     try {
//       await _firestore.collection(AppConstants.usersCollection).doc(uid).set(userProfile.toMap());
//     } catch (e) {
//       throw Exception('Error creating user profile: $e');
//     }
//   }

//   Future<UserProfile?> getUserProfile(String uid) async {
//     try {
//       final doc = await _firestore.collection(AppConstants.usersCollection).doc(uid).get();
//       if (doc.exists) {
//         return UserProfile.fromMap(doc.data()!);
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Error getting user profile: $e');
//     }
//   }

//   Future<void> updateUserProfile(String uid, Map<String, dynamic> updates) async {
//     try {
//       await _firestore.collection(AppConstants.usersCollection).doc(uid).update(updates);
//     } catch (e) {
//       throw Exception('Error updating user profile: $e');
//     }
//   }

//   Stream<UserProfile?> streamUserProfile(String uid) {
//     return _firestore
//         .collection(AppConstants.usersCollection)
//         .doc(uid)
//         .snapshots()
//         .map((snapshot) {
//       if (snapshot.exists) {
//         return UserProfile.fromMap(snapshot.data()!);
//       }
//       return null;
//     }).handleError((e) {
//       debugPrint('Error streaming user profile for $uid: $e');
//       return null;
//     });
//   }

//   Future<void> addXp(String userId, int amount) async {
//     try {
//       final userRef = _firestore.collection(AppConstants.usersCollection).doc(userId);
//       await _firestore.runTransaction((transaction) async {
//         final userDoc = await transaction.get(userRef);
//         if (!userDoc.exists) {
//           throw Exception("User does not exist to add XP!");
//         }

//         UserProfile userProfile = UserProfile.fromMap(userDoc.data()!);
//         int newXpTotal = userProfile.xp + amount;
//         int newLevel = userProfile.level;

//         int xpAtCurrentLevelStart = (newLevel - 1) * AppConstants.xpPerLevel;

//         while (newXpTotal >= xpAtCurrentLevelStart + AppConstants.xpPerLevel) {
//           newLevel++;
//           xpAtCurrentLevelStart = (newLevel - 1) * AppConstants.xpPerLevel;
//         }

//         transaction.update(userRef, {
//           'xp': newXpTotal,
//           'level': newLevel,
//         });
//       });
//     } catch (e) {
//       throw Exception('Error adding XP to user: $e');
//     }
//   }

//   Future<void> deductXp(String userId, int amount) async {
//     try {
//       final userRef = _firestore.collection(AppConstants.usersCollection).doc(userId);
//       await _firestore.runTransaction((transaction) async {
//         final userDoc = await transaction.get(userRef);
//         if (!userDoc.exists) {
//           throw Exception("User does not exist to deduct XP!");
//         }

//         UserProfile userProfile = UserProfile.fromMap(userDoc.data()!);
//         int newXpTotal = userProfile.xp - amount;
//         if (newXpTotal < 0) newXpTotal = 0; // Prevent negative XP

//         // Re-calculate level if XP drops below current level's threshold
//         int newLevel = userProfile.level;
//         while (newXpTotal < (newLevel - 1) * AppConstants.xpPerLevel && newLevel > 1) {
//           newLevel--;
//         }

//         transaction.update(userRef, {
//           'xp': newXpTotal,
//           'level': newLevel,
//         });
//       });
//     } catch (e) {
//       throw Exception('Error deducting XP from user: $e');
//     }
//   }

//   // New: Streak Management
//   Future<void> _updateUserStreak(String userId) async {
//     try {
//       final userRef = _firestore.collection(AppConstants.usersCollection).doc(userId);
//       await _firestore.runTransaction((transaction) async {
//         final userDoc = await transaction.get(userRef);
//         if (!userDoc.exists) {
//           throw Exception("User does not exist for streak update!");
//         }

//         UserProfile userProfile = UserProfile.fromMap(userDoc.data()!);
//         DateTime now = DateTime.now();
//         DateTime? lastUpdate = userProfile.lastStreakUpdate;

//         // Normalize dates to just year, month, day for comparison
//         DateTime today = DateTime(now.year, now.month, now.day);
//         DateTime? lastUpdateDay = lastUpdate != null ? DateTime(lastUpdate.year, lastUpdate.month, lastUpdate.day) : null;

//         int newStreak = userProfile.currentStreak;
//         int bonusXp = 0;

//         if (lastUpdateDay == null) {
//           // First login/activity
//           newStreak = 1;
//         } else if (today.difference(lastUpdateDay).inDays == 1) {
//           // Streak continues
//           newStreak++;
//           bonusXp = AppConstants.streakBonusXp; // Award streak bonus
//         } else if (today.difference(lastUpdateDay).inDays > 1) {
//           // Streak broken
//           newStreak = 1;
//         }
//         // If it's the same day, do nothing (streak already counted for today)

//         transaction.update(userRef, {
//           'currentStreak': newStreak,
//           'lastStreakUpdate': Timestamp.fromDate(now),
//           'xp': FieldValue.increment(bonusXp), // Add bonus XP
//         });
//         debugPrint('Streak updated for user $userId: newStreak=$newStreak, bonusXp=$bonusXp');
//       });
//     } catch (e) {
//       debugPrint('Error updating user streak: $e');
//       // Do not throw to prevent login/activity from failing due to streak update
//     }
//   }


//   Future<void> saveCourse(Course course) async {
//     try {
//       await _firestore.collection(AppConstants.coursesCollection).doc(course.id).set(course.toMap());
//     } catch (e) {
//       throw Exception('Error saving course: $e');
//     }
//   }

//   Future<Course?> getCourse(String courseId) async {
//     try {
//       final doc = await _firestore.collection(AppConstants.coursesCollection).doc(courseId).get();
//       if (doc.exists) {
//         return Course.fromMap(doc.data()!);
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Error getting course: $e');
//     }
//   }

//   Future<void> deleteCourse(String courseId, List<String> levelIds) async {
//     try {
//       final batch = _firestore.batch();

//       for (final levelId in levelIds) {
//         final levelRef = _firestore.collection(AppConstants.levelsCollection).doc(levelId);
//         final lessonsSnapshot = await levelRef.collection('lessons').get();
//         for (final lessonDoc in lessonsSnapshot.docs) {
//           final lessonRef = lessonDoc.reference;
//           final questionsSnapshot = await lessonRef.collection('questions').get();
//           for (final questionDoc in questionsSnapshot.docs) {
//             batch.delete(questionDoc.reference);
//           }
//           batch.delete(lessonRef);
//         }
//         batch.delete(levelRef);
//       }

//       final userProgressQuery = await _firestore
//           .collection(AppConstants.userProgressCollection)
//           .where('courseId', isEqualTo: courseId)
//           .get();
//       for (final doc in userProgressQuery.docs) {
//         batch.delete(doc.reference);
//       }

//       final courseRef = _firestore.collection(AppConstants.coursesCollection).doc(courseId);
//       batch.delete(courseRef);

//       await batch.commit();
//     } catch (e) {
//       throw Exception('Error deleting course $courseId: $e');
//     }
//   }

//   Stream<List<Course>> streamAllCoursesForUser(String userId) {
//     return _firestore
//         .collection(AppConstants.coursesCollection)
//         .where('creatorId', isEqualTo: userId) // Filter by creatorId
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => Course.fromMap(doc.data()!)).toList();
//     }).handleError((e) {
//       debugPrint('Error streaming user-specific courses: $e');
//       return <Course>[];
//     });
//   }

//   Stream<List<Course>> streamPublicCourses(String currentUserId) {
//     // Stream courses that are NOT created by the current user
//     return _firestore
//         .collection(AppConstants.coursesCollection)
//         .where('creatorId', isNotEqualTo: currentUserId) // Filter by creatorId
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => Course.fromMap(doc.data()!)).toList();
//     }).handleError((e) {
//       debugPrint('Error streaming public courses: $e');
//       return <Course>[];
//     });
//   }


//   Future<void> saveLevel(Level level, List<Lesson> lessons, Map<String, List<Question>> questionsPerLesson) async {
//     try {
//       final levelRef = _firestore.collection(AppConstants.levelsCollection).doc(level.id);
//       await levelRef.set(level.toMap());

//       for (final lesson in lessons) {
//         final lessonRef = levelRef.collection('lessons').doc(lesson.id);
//         await lessonRef.set(lesson.toMap());
//         for (final question in questionsPerLesson[lesson.id]!) {
//           await lessonRef.collection('questions').doc(question.id).set(question.toMap());
//         }
//       }
//     } catch (e) {
//       throw Exception('Error saving level, lessons, and questions: $e');
//     }
//   }

//   Future<Level?> getLevel(String levelId) async {
//     try {
//       final doc = await _firestore.collection(AppConstants.levelsCollection).doc(levelId).get();
//       if (doc.exists) {
//         return Level.fromMap(doc.data()!);
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Error getting level: $e');
//     }
//   }

//   Stream<List<Level>> streamLevelsForCourse(String courseId) {
//     return _firestore
//         .collection(AppConstants.levelsCollection)
//         .where('courseId', isEqualTo: courseId)
//         .orderBy('order')
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => Level.fromMap(doc.data()!)).toList();
//     }).handleError((e) {
//       debugPrint('Error streaming levels for course $courseId: $e');
//       return <Level>[];
//     });
//   }

//   Future<Lesson?> getLesson(String levelId, String lessonId) async {
//     try {
//       final doc = await _firestore.collection(AppConstants.levelsCollection).doc(levelId).collection('lessons').doc(lessonId).get();
//       if (doc.exists) {
//         return Lesson.fromMap(doc.data()!);
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Error getting lesson: $e');
//     }
//   }

//   Future<List<Question>> getLessonQuestions(String levelId, String lessonId) async {
//     try {
//       final querySnapshot = await _firestore
//           .collection(AppConstants.levelsCollection)
//           .doc(levelId)
//           .collection('lessons')
//           .doc(lessonId)
//           .collection('questions')
//           .get();

//       return querySnapshot.docs.map((doc) => Question.fromMap(doc.data())).toList();
//     } catch (e) {
//       throw Exception('Error getting lesson questions for lesson $lessonId in level $levelId: $e');
//     }
//   }

//   Future<void> saveUserProgress(UserProgress progress) async {
//     try {
//       await _firestore.collection(AppConstants.userProgressCollection).doc(progress.id).set(progress.toMap(), SetOptions(merge: true));
//     } catch (e) {
//       throw Exception('Error saving user progress: $e');
//     }
//   }

//   Future<UserProgress?> getUserCourseProgress(String userId, String courseId) async {
//     try {
//       final String progressId = '${userId}_$courseId';
//       final doc = await _firestore.collection(AppConstants.userProgressCollection).doc(progressId).get();
//       if (doc.exists) {
//         return UserProgress.fromMap(doc.data()!);
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Error getting user course progress: $e');
//     }
//   }

//   Stream<UserProgress?> streamUserCourseProgress(String userId, String courseId) {
//     final String progressId = '${userId}_$courseId';
//     return _firestore
//         .collection(AppConstants.userProgressCollection)
//         .doc(progressId)
//         .snapshots()
//         .map((snapshot) {
//       if (snapshot.exists) {
//         return UserProgress.fromMap(snapshot.data()!);
//       }
//       return null;
//     }).handleError((e) {
//       debugPrint('Error streaming user course progress for $progressId: $e');
//       return null;
//     });
//   }

//   Future<void> addEarnedBadge(String userId, Badge badge) async {
//     try {
//       final userRef = _firestore.collection(AppConstants.usersCollection).doc(userId);
//       await userRef.update({
//         'earnedBadges': FieldValue.arrayUnion([badge.id]),
//       });
//     } catch (e) {
//       throw Exception('Error adding earned badge: $e');
//     }
//   }

//   Future<Badge?> getBadge(String badgeId) async {
//     try {
//       final doc = await _firestore.collection(AppConstants.badgesCollection).doc(badgeId).get();
//       if (doc.exists) {
//         return Badge.fromMap(doc.data()!);
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Error getting badge: $e');
//     }
//   }

//   Stream<List<UserProfile>> streamLeaderboard() {
//     return _firestore
//         .collection(AppConstants.usersCollection)
//         .orderBy('xp', descending: true)
//         .limit(AppConstants.leaderboardLimit)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => UserProfile.fromMap(doc.data()!)).toList();
//     }).handleError((e) {
//       debugPrint('Error streaming leaderboard: $e');
//       return <UserProfile>[];
//     });
//   }

//   // New: Social Features
//   Future<void> createCommunityPost(CommunityPost post) async {
//     try {
//       await _firestore.collection(AppConstants.communityPostsCollection).doc(post.id).set(post.toMap());
//     } catch (e) {
//       throw Exception('Error creating community post: $e');
//     }
//   }

//   Stream<List<CommunityPost>> streamCommunityPosts() {
//     return _firestore
//         .collection(AppConstants.communityPostsCollection)
//         .orderBy('timestamp', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => CommunityPost.fromMap(doc.data()!)).toList();
//     }).handleError((e) {
//       debugPrint('Error streaming community posts: $e');
//       return <CommunityPost>[];
//     });
//   }

//   Future<void> addCommentToPost(String postId, Comment comment) async {
//     try {
//       final postRef = _firestore.collection(AppConstants.communityPostsCollection).doc(postId);
//       await postRef.update({
//         'comments': FieldValue.arrayUnion([comment.toMap()]),
//       });
//     } catch (e) {
//       throw Exception('Error adding comment to post: $e');
//     }
//   }

//   Future<void> toggleLikeOnPost(String postId, String userId) async {
//     try {
//       final postRef = _firestore.collection(AppConstants.communityPostsCollection).doc(postId);
//       await _firestore.runTransaction((transaction) async {
//         final postSnapshot = await transaction.get(postRef);
//         if (!postSnapshot.exists) {
//           throw Exception("Post does not exist!");
//         }
//         final post = CommunityPost.fromMap(postSnapshot.data()!);
//         List<String> likedBy = List<String>.from(post.likedBy);

//         if (likedBy.contains(userId)) {
//           likedBy.remove(userId);
//         } else {
//           likedBy.add(userId);
//         }

//         transaction.update(postRef, {'likedBy': likedBy});
//       });
//     } catch (e) {
//       throw Exception('Error toggling like on post: $e');
//     }
//   }

//   Future<void> addFriend(String currentUserId, String friendId) async {
//     try {
//       final currentUserRef = _firestore.collection(AppConstants.usersCollection).doc(currentUserId);
//       final friendUserRef = _firestore.collection(AppConstants.usersCollection).doc(friendId);

//       await _firestore.runTransaction((transaction) async {
//         final currentUserDoc = await transaction.get(currentUserRef);
//         final friendUserDoc = await transaction.get(friendUserRef);

//         if (!currentUserDoc.exists || !friendUserDoc.exists) {
//           throw Exception("One or both users do not exist.");
//         }

//         UserProfile currentUserProfile = UserProfile.fromMap(currentUserDoc.data()!);
//         UserProfile friendUserProfile = UserProfile.fromMap(friendUserDoc.data()!);

//         List<String> currentUserFriends = List<String>.from(currentUserProfile.friends);
//         List<String> friendUserFriends = List<String>.from(friendUserProfile.friends);

//         if (!currentUserFriends.contains(friendId)) {
//           currentUserFriends.add(friendId);
//           transaction.update(currentUserRef, {'friends': currentUserFriends});
//         }

//         if (!friendUserFriends.contains(currentUserId)) {
//           friendUserFriends.add(currentUserId);
//           transaction.update(friendUserRef, {'friends': friendUserFriends});
//         }
//       });
//     } catch (e) {
//       throw Exception('Error adding friend: $e');
//     }
//   }

//   Future<void> removeFriend(String currentUserId, String friendId) async {
//     try {
//       final currentUserRef = _firestore.collection(AppConstants.usersCollection).doc(currentUserId);
//       final friendUserRef = _firestore.collection(AppConstants.usersCollection).doc(friendId);

//       await _firestore.runTransaction((transaction) async {
//         final currentUserDoc = await transaction.get(currentUserRef);
//         final friendUserDoc = await transaction.get(friendUserRef);

//         if (!currentUserDoc.exists || !friendUserDoc.exists) {
//           throw Exception("One or both users do not exist.");
//         }

//         UserProfile currentUserProfile = UserProfile.fromMap(currentUserDoc.data()!);
//         UserProfile friendUserProfile = UserProfile.fromMap(friendUserDoc.data()!);

//         List<String> currentUserFriends = List<String>.from(currentUserProfile.friends);
//         List<String> friendUserFriends = List<String>.from(friendUserProfile.friends);

//         if (currentUserFriends.contains(friendId)) {
//           currentUserFriends.remove(friendId);
//           transaction.update(currentUserRef, {'friends': currentUserFriends});
//         }

//         if (!friendUserFriends.contains(currentUserId)) {
//           friendUserFriends.remove(currentUserId);
//           transaction.update(friendUserRef, {'friends': friendUserFriends});
//         }
//       });
//     } catch (e) {
//       throw Exception('Error removing friend: $e');
//     }
//   }
// }
// // lib/services/audio_service.dart
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/foundation.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class AudioService {
//   final AudioPlayer _correctPlayer = AudioPlayer();
//   final AudioPlayer _levelUpPlayer = AudioPlayer();
//   final AudioPlayer _incorrectPlayer = AudioPlayer(); // New player for incorrect sound

//   AudioService() {
//     // Preload sounds if possible (though AudioCache handles this usually)
//     // For local assets, Source.asset is the way to go.
//     _correctPlayer.setSource(AssetSource(AppConstants.correctSoundPath));
//     _levelUpPlayer.setSource(AssetSource(AppConstants.levelUpSoundPath));
//     _incorrectPlayer.setSource(AssetSource('assets/audios/incorrect.mp3')); // Assuming an incorrect.mp3 asset
//   }

//   Future<void> playCorrectSound() async {
//     try {
//       await _correctPlayer.stop(); // Stop any currently playing sound
//       await _correctPlayer.seek(Duration.zero); // Rewind to start
//       await _correctPlayer.play(AssetSource(AppConstants.correctSoundPath));
//     } catch (e) {
//       debugPrint('Error playing correct sound: $e');
//     }
//   }

//   Future<void> playLevelUpSound() async {
//     try {
//       await _levelUpPlayer.stop();
//       await _levelUpPlayer.seek(Duration.zero);
//       await _levelUpPlayer.play(AssetSource(AppConstants.levelUpSoundPath));
//     } catch (e) {
//       debugPrint('Error playing level up sound: $e');
//     }
//   }

//   Future<void> playIncorrectSound() async {
//     try {
//       await _incorrectPlayer.stop();
//       await _incorrectPlayer.seek(Duration.zero);
//       await _incorrectPlayer.play(AssetSource('assets/audios/incorrect.mp3'));
//     } catch (e) {
//       debugPrint('Error playing incorrect sound: $e');
//     }
//   }

//   void dispose() {
//     _correctPlayer.dispose();
//     _levelUpPlayer.dispose();
//     _incorrectPlayer.dispose();
//   }
// }
// // lib/screens/splash_screen.dart
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:provider/provider.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkAuthStatus();
//   }

//   void _checkAuthStatus() async {
//     await Future.delayed(const Duration(seconds: 2));

//     if (!mounted) return;

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);

//     FirebaseAuth.instance.authStateChanges().listen((User? user) async {
//       if (!mounted) return;

//       if (user == null) {
//         Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
//       } else {
//         try {
//           final userProfile = await firebaseService.getUserProfile(user.uid);
//           if (userProfile == null || userProfile.educationLevel == null || userProfile.specialty == null || userProfile.educationLevel!.isEmpty || userProfile.specialty!.isEmpty) {
//             Navigator.of(context).pushReplacementNamed(AppRouter.onboardingRoute);
//           } else {
//             Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//           }
//         } catch (e) {
//           Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.games,
//                 size: 100,
//                 color: AppColors.accentColor,
//               ),
//               SizedBox(height: AppConstants.padding),
//               Text(
//                 AppConstants.appName,
//                 style: TextStyle(
//                   fontSize: 48,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textColor,
//                   shadows: [
//                     Shadow(
//                       color: AppColors.accentColor,
//                       blurRadius: 15.0,
//                     ),
//                     Shadow(
//                       color: AppColors.accentColor.withOpacity(0.5),
//                       blurRadius: 30.0,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: AppConstants.spacing),
//               Text(
//                 AppConstants.appTagline,
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: AppColors.textColorSecondary,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//               SizedBox(height: AppConstants.padding * 2),
//               CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/screens/progress_screen.dart
// import 'package:flutter/material.dart' hide Badge; // Hide Badge from material.dart
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/models/badge.dart'; // Explicitly import your Badge model
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/gamification/leaderboard_list.dart';
// import 'package:gamifier/widgets/gamification/badge_display.dart';
// import 'package:gamifier/widgets/common/xp_level_display.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:gamifier/utils/app_router.dart'; // Import AppRouter

// class ProgressScreen extends StatefulWidget {
//   const ProgressScreen({super.key});

//   @override
//   State<ProgressScreen> createState() => _ProgressScreenState();
// }

// class _ProgressScreenState extends State<ProgressScreen> {
//   int _selectedIndex = 2; // Set the current index for Progress screen

//   @override
//   Widget build(BuildContext context) {
//     final firebaseService = Provider.of<FirebaseService>(context);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'My Progress',
//         leadingWidget: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(AppConstants.padding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               StreamBuilder<UserProfile?>(
//                 stream: firebaseService.streamUserProfile(currentUser.uid),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                         child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
//                   }
//                   if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
//                     return Center(
//                         child: Text('Error loading user data: ${snapshot.error}',
//                             style: const TextStyle(color: AppColors.errorColor)));
//                   }

//                   final userProfile = snapshot.data!;
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Column(
//                           children: [
//                             CircleAvatar(
//                               radius: AppConstants.avatarSize,
//                               backgroundColor: AppColors.cardColor,
//                               backgroundImage: AssetImage(userProfile.avatarAssetPath),
//                               onBackgroundImageError: (exception, stackTrace) {
//                                 debugPrint('Error loading avatar image: $exception');
//                               },
//                             ),
//                             const SizedBox(height: AppConstants.spacing),
//                             Text(
//                               userProfile.username,
//                               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                                     color: AppColors.textColor,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                             ),
//                             const SizedBox(height: AppConstants.spacing / 2),
//                             XpLevelDisplay(
//                               xp: userProfile.xp,
//                               level: userProfile.level,
//                               showLabel: true,
//                             ),
//                             const SizedBox(height: AppConstants.spacing),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: AppConstants.padding,
//                                 vertical: AppConstants.spacing / 2,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: AppColors.cardColor.withOpacity(0.7),
//                                 borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                                 border: Border.all(color: AppColors.borderColor, width: 1.0),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(Icons.local_fire_department, color: AppColors.xpColor, size: AppConstants.iconSize), // 🔥 icon
//                                   const SizedBox(width: AppConstants.spacing / 2),
//                                   Text(
//                                     'Streak: ${userProfile.currentStreak} days',
//                                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                                           color: AppColors.xpColor,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: AppConstants.padding * 2),
//                       Text(
//                         'Badges Earned',
//                         style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                               color: AppColors.textColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       if (userProfile.earnedBadges.isEmpty)
//                         Text(
//                           'No badges earned yet. Keep learning to earn badges!',
//                           style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//                         )
//                       else
//                         FutureBuilder<List<Badge>>( // Use your Badge model here
//                           future: Future.wait(userProfile.earnedBadges.map((badgeId) async {
//                             final badge = await firebaseService.getBadge(badgeId);
//                             return badge;
//                           }).where((e) => e != null).cast<Future<Badge>>()), // Cast to Future<Badge>
//                           builder: (context, badgeSnapshot) {
//                             if (badgeSnapshot.connectionState == ConnectionState.waiting) {
//                               return const Center(child: CircularProgressIndicator());
//                             }
//                             if (badgeSnapshot.hasError) {
//                               return Center(child: Text('Error loading badges: ${badgeSnapshot.error}'));
//                             }
//                             if (!badgeSnapshot.hasData || badgeSnapshot.data!.isEmpty) {
//                               return Text(
//                                 'No badges found for earned IDs.',
//                                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//                               );
//                             }
//                             return BadgeDisplay(badges: badgeSnapshot.data!);
//                           },
//                         ),
//                       const SizedBox(height: AppConstants.padding * 2),
//                       Text(
//                         'Leaderboard',
//                         style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                               color: AppColors.textColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       StreamBuilder<List<UserProfile>>(
//                         stream: firebaseService.streamLeaderboard(),
//                         builder: (context, leaderboardSnapshot) {
//                           if (leaderboardSnapshot.connectionState == ConnectionState.waiting) {
//                             return const Center(child: CircularProgressIndicator());
//                           }
//                           if (leaderboardSnapshot.hasError) {
//                             return Center(child: Text('Error loading leaderboard: ${leaderboardSnapshot.error}'));
//                           }
//                           if (!leaderboardSnapshot.hasData || leaderboardSnapshot.data!.isEmpty) {
//                             return Text(
//                               'No leaderboard data available.',
//                               style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//                             );
//                           }
//                           return LeaderboardList(users: leaderboardSnapshot.data!);
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//           // Handle navigation here based on index
//           switch (index) {
//             case 0:
//               Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//               break;
//             case 1:
//               Navigator.of(context).pushReplacementNamed(AppRouter.courseCreationRoute);
//               break;
//             case 2:
//             // Already on progress screen
//               break;
//             case 3:
//               Navigator.of(context).pushReplacementNamed(AppRouter.profileRoute);
//               break;
//             case 4:
//               Navigator.of(context).pushReplacementNamed(AppRouter.communityRoute);
//               break;
//             case 5:
//               Navigator.of(context).pushReplacementNamed(AppRouter.aiChatRoute);
//               break;
//           }
//         },
//       ),
//     );
//   }
// }
// // lib/utils/app_router.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/screens/splash_screen.dart';
// import 'package:gamifier/screens/auth_screen.dart';
// import 'package:gamifier/screens/home_screen.dart';
// import 'package:gamifier/screens/course_creation_screen.dart';
// import 'package:gamifier/screens/lesson_screen.dart';
// import 'package:gamifier/screens/progress_screen.dart';
// import 'package:gamifier/screens/profile_screen.dart';
// import 'package:gamifier/screens/avatar_customizer_screen.dart';
// import 'package:gamifier/screens/onboarding_screen.dart';
// import 'package:gamifier/screens/level_selection_screen.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/screens/level_completion_screen.dart';
// import 'package:gamifier/screens/course_completion_screen.dart';
// import 'package:gamifier/screens/community_screen.dart';
// import 'package:gamifier/screens/ai_chat_screen.dart';

// class AppRouter {
//   static const String splashRoute = '/';
//   static const String authRoute = '/auth';
//   static const String homeRoute = '/home';
//   static const String courseCreationRoute = '/create-course';
//   static const String lessonRoute = '/lesson';
//   static const String progressRoute = '/progress';
//   static const String profileRoute = '/profile';
//   static const String avatarCustomizerRoute = '/avatar-customizer';
//   static const String onboardingRoute = '/onboarding';
//   static const String levelSelectionRoute = '/level-selection';
//   static const String levelCompletionRoute = '/level-completion';
//   static const String courseCompletionRoute = '/course-completion';
//   static const String communityRoute = '/community';
//   static const String aiChatRoute = '/ai-chat';

//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case splashRoute:
//         return MaterialPageRoute(builder: (_) => const SplashScreen());
//       case authRoute:
//         return MaterialPageRoute(builder: (_) => const AuthScreen());
//       case homeRoute:
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//       case courseCreationRoute:
//         return MaterialPageRoute(builder: (_) => const CourseCreationScreen());
//       case lessonRoute:
//         final args = settings.arguments as Map<String, dynamic>;
//         return MaterialPageRoute(
//           builder: (_) => LessonScreen(
//             courseId: args['courseId'] as String,
//             levelId: args['levelId'] as String,
//             lessonId: args['lessonId'] as String,
//           ),
//         );
//       case progressRoute:
//         return MaterialPageRoute(builder: (_) => const ProgressScreen());
//       case profileRoute:
//         return MaterialPageRoute(builder: (_) => const ProfileScreen());
//       case avatarCustomizerRoute:
//         return MaterialPageRoute(builder: (_) => const AvatarCustomizerScreen());
//       case onboardingRoute:
//         return MaterialPageRoute(builder: (_) => const OnboardingScreen());
//       case levelSelectionRoute:
//         // Ensure Course object is passed directly
//         final course = settings.arguments as Course;
//         return MaterialPageRoute(builder: (_) => LevelSelectionScreen(course: course));
//       case levelCompletionRoute:
//         final args = settings.arguments as Map<String, dynamic>;
//         return MaterialPageRoute(
//           builder: (_) => LevelCompletionScreen(
//             courseId: args['courseId'] as String,
//             levelId: args['levelId'] as String,
//             totalXpEarned: args['totalXpEarned'] as int,
//             levelScore: args['levelScore'] as int,
//             lessonsCompleted: args['lessonsCompleted'] as int,
//             totalLessons: args['totalLessons'] as int,
//           ),
//         );
//       case courseCompletionRoute:
//         final args = settings.arguments as Map<String, dynamic>;
//         return MaterialPageRoute(
//           builder: (_) => CourseCompletionScreen(
//             courseTitle: args['courseTitle'] as String,
//             totalXpEarnedInCourse: args['totalXpEarnedInCourse'] as int,
//             totalLevelsCompleted: args['totalLevelsCompleted'] as int,
//             totalLevelsInCourse: args['totalLevelsInCourse'] as int,
//           ),
//         );
//       case communityRoute:
//         return MaterialPageRoute(builder: (_) => const CommunityScreen());
//       case aiChatRoute:
//         return MaterialPageRoute(builder: (_) => const AIChatScreen());
//       default:
//         return MaterialPageRoute(builder: (_) => Text('Error: Unknown route ${settings.name}'));
//     }
//   }
// }
// // lib/screens/profile_screen.dart
// import 'package:flutter/material.dart'; // Hide Badge from material.dart to avoid conflict
// import 'package:gamifier/models/badge.dart' as gamifier;
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/xp_level_display.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:gamifier/utils/app_router.dart'; // Import AppRouter
// import 'package:gamifier/widgets/gamification/badge_display.dart'; // Import BadgeDisplay
// import 'package:gamifier/models/badge.dart'; // Explicitly import your Badge model
// import 'package:gamifier/widgets/common/loading_indicator.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   int _selectedIndex = 3; // Set the current index for Profile screen
//   bool _isEditing = false;
//   final TextEditingController _usernameController = TextEditingController();
//   String? _selectedEducationLevel;
//   final TextEditingController _specialtyController = TextEditingController();

//   void _showSnackBar(String message, {bool isError = false}) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? AppColors.errorColor : AppColors.successColor,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final firebaseService = Provider.of<FirebaseService>(context);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'My Profile',
//         leadingWidget: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         trailingWidget: IconButton(
//           icon: Icon(
//             _isEditing ? Icons.save : Icons.edit,
//             color: AppColors.textColor,
//             size: AppConstants.iconSize,
//           ),
//           onPressed: () {
//             if (_isEditing) {
//               _saveProfile();
//             }
//             setState(() {
//               _isEditing = !_isEditing;
//             });
//           },
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
//         child: StreamBuilder<UserProfile?>(
//           stream: firebaseService.streamUserProfile(currentUser.uid),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                   child: LoadingIndicator(message: 'Loading profile...'));
//             }
//             if (snapshot.hasError) {
//               return Center(
//                   child: Text('Error loading profile: ${snapshot.error}',
//                       style: const TextStyle(color: AppColors.errorColor)));
//             }
//             if (!snapshot.hasData || snapshot.data == null) {
//               return Center(
//                   child: Text('User profile not found.',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColorSecondary)));
//             }

//             final userProfile = snapshot.data!;
//             if (!_isEditing) {
//               _usernameController.text = userProfile.username;
//               _selectedEducationLevel = userProfile.educationLevel;
//               _specialtyController.text = userProfile.specialty ?? '';
//             }

//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(AppConstants.padding),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             if (_isEditing) {
//                               Navigator.of(context).pushNamed(AppRouter.avatarCustomizerRoute);
//                             }
//                           },
//                           child: Stack(
//                             alignment: Alignment.bottomRight,
//                             children: [
//                               CircleAvatar(
//                                 radius: AppConstants.avatarSize,
//                                 backgroundColor: AppColors.cardColor,
//                                 backgroundImage: AssetImage(userProfile.avatarAssetPath),
//                                 onBackgroundImageError: (exception, stackTrace) {
//                                   debugPrint('Error loading avatar image: $exception');
//                                 },
//                               ),
//                               if (_isEditing)
//                                 Positioned(
//                                   right: 0,
//                                   bottom: 0,
//                                   child: Container(
//                                     padding: const EdgeInsets.all(AppConstants.spacing / 2),
//                                     decoration: BoxDecoration(
//                                       color: AppColors.accentColor,
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: Icon(Icons.edit, color: AppColors.cardColor, size: AppConstants.iconSize),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: AppConstants.padding),
//                         if (_isEditing)
//                           TextFormField(
//                             controller: _usernameController,
//                             style: const TextStyle(color: AppColors.textColor, fontSize: AppConstants.largeTextSize),
//                             decoration: InputDecoration(
//                               labelText: 'Username',
//                               labelStyle: const TextStyle(color: AppColors.textColorSecondary, fontSize: AppConstants.mediumTextSize),
//                               filled: true,
//                               fillColor: AppColors.cardColor.withOpacity(0.8),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                           )
//                         else
//                           Text(
//                             userProfile.username,
//                             style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                                   color: AppColors.textColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: AppConstants.largeTextSize + 4,
//                                 ),
//                           ),
//                         const SizedBox(height: AppConstants.spacing),
//                         XpLevelDisplay(
//                           xp: userProfile.xp,
//                           level: userProfile.level,
//                           showLabel: true,
//                         ),
//                         const SizedBox(height: AppConstants.spacing),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: AppConstants.padding,
//                             vertical: AppConstants.spacing / 2,
//                           ),
//                           decoration: BoxDecoration(
//                             color: AppColors.cardColor.withOpacity(0.7),
//                             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                             border: Border.all(color: AppColors.borderColor, width: 1.0),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.local_fire_department, color: AppColors.xpColor, size: AppConstants.iconSize), // 🔥 icon
//                               const SizedBox(width: AppConstants.spacing / 2),
//                               Text(
//                                 'Streak: ${userProfile.currentStreak} days',
//                                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                                       color: AppColors.xpColor,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: AppConstants.mediumTextSize,
//                                     ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: AppConstants.padding * 2),
//                   Text(
//                     'About Me',
//                     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                           color: AppColors.textColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: AppConstants.largeTextSize,
//                         ),
//                   ),
//                   const SizedBox(height: AppConstants.spacing),
//                   if (_isEditing)
//                     Column(
//                       children: [
//                         DropdownButtonFormField<String>(
//                           value: _selectedEducationLevel,
//                           decoration: InputDecoration(
//                             labelText: 'Education Level',
//                             labelStyle: const TextStyle(color: AppColors.textColorSecondary, fontSize: AppConstants.smallTextSize),
//                             filled: true,
//                             fillColor: AppColors.cardColor.withOpacity(0.8),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                           dropdownColor: AppColors.cardColor,
//                           style: const TextStyle(color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                           items: AppConstants.educationLevels.map((String level) {
//                             return DropdownMenuItem<String>(
//                               value: level,
//                               child: Text(level),
//                             );
//                           }).toList(),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               _selectedEducationLevel = newValue;
//                             });
//                           },
//                         ),
//                         const SizedBox(height: AppConstants.spacing),
//                         TextFormField(
//                           controller: _specialtyController,
//                           style: const TextStyle(color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                           decoration: InputDecoration(
//                             labelText: 'Specialty/Interest',
//                             labelStyle: const TextStyle(color: AppColors.textColorSecondary, fontSize: AppConstants.smallTextSize),
//                             filled: true,
//                             fillColor: AppColors.cardColor.withOpacity(0.8),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   else ...[
//                     _buildInfoRow(
//                       context,
//                       'Education Level:',
//                       userProfile.educationLevel ?? 'Not set',
//                       Icons.school,
//                     ),
//                     _buildInfoRow(
//                       context,
//                       'Specialty:',
//                       userProfile.specialty ?? 'Not set',
//                       Icons.category,
//                     ),
//                   ],
//                   const SizedBox(height: AppConstants.padding * 2),
//                   Text(
//                     'Badges Earned',
//                     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                           color: AppColors.textColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: AppConstants.largeTextSize,
//                         ),
//                   ),
//                   const SizedBox(height: AppConstants.spacing),
//                   if (userProfile.earnedBadges.isEmpty)
//                     Text(
//                       'No badges earned yet. Keep learning to earn badges!',
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary, fontSize: AppConstants.mediumTextSize),
//                     )
//                   else
//                     FutureBuilder<List<gamifier.Badge>>( // Use alias for Badge
//                       future: Future.wait(userProfile.earnedBadges.map((badgeId) async {
//                         final badge = await firebaseService.getBadge(badgeId);
//                         return badge;
//                       }).where((e) => e != null).cast<Future<gamifier.Badge>>()), // Use alias here too
//                       builder: (context, badgeSnapshot) {
//                         if (badgeSnapshot.connectionState == ConnectionState.waiting) {
//                           return const Center(child: CircularProgressIndicator());
//                         }
//                         if (badgeSnapshot.hasError) {
//                           return Center(child: Text('Error loading badges: ${badgeSnapshot.error}'));
//                         }
//                         if (!badgeSnapshot.hasData || badgeSnapshot.data!.isEmpty) {
//                           return Text(
//                             'No badges found for earned IDs.',
//                             style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary, fontSize: AppConstants.mediumTextSize),
//                           );
//                         }
//                         return BadgeDisplay(badges: badgeSnapshot.data!);
//                       },
//                     ),
//                   const SizedBox(height: AppConstants.padding),
//                   Center(
//                     child: ElevatedButton.icon(
//                       onPressed: () async {
//                         await firebaseService.signOut();
//                         if (mounted) {
//                           Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
//                         }
//                       },
//                       icon: const Icon(Icons.logout),
//                       label: const Text('Sign Out'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.errorColor,
//                         foregroundColor: AppColors.cardColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                         ),
//                         padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
//                         textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: AppConstants.mediumTextSize),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//           switch (index) {
//             case 0:
//               Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//               break;
//             case 1:
//               Navigator.of(context).pushReplacementNamed(AppRouter.courseCreationRoute);
//               break;
//             case 2:
//               Navigator.of(context).pushReplacementNamed(AppRouter.progressRoute);
//               break;
//             case 3:
//             // Already on profile screen
//               break;
//             case 4:
//               Navigator.of(context).pushReplacementNamed(AppRouter.communityRoute);
//               break;
//             case 5:
//               Navigator.of(context).pushReplacementNamed(AppRouter.aiChatRoute);
//               break;
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: AppColors.textColorSecondary, size: AppConstants.iconSize),
//           const SizedBox(width: AppConstants.spacing),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                         color: AppColors.textColorSecondary,
//                         fontSize: AppConstants.smallTextSize,
//                       ),
//                 ),
//                 Text(
//                   value,
//                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                         color: AppColors.textColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: AppConstants.mediumTextSize,
//                       ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _saveProfile() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       _showSnackBar('User not logged in.', isError: true);
//       return;
//     }

//     try {
//       await firebaseService.updateUserProfile(
//         currentUser.uid,
//         {
//           'username': _usernameController.text.trim(),
//           'educationLevel': _selectedEducationLevel,
//           'specialty': _specialtyController.text.trim(),
//         },
//       );
//       _showSnackBar('Profile updated successfully!');
//     } catch (e) {
//       _showSnackBar('Error updating profile: $e', isError: true);
//     }
//   }
// }
// // lib/screens/onboarding_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/utils/validation_utils.dart'; // Import for validation

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? _selectedEducationLevel;
//   final TextEditingController _specialtyController = TextEditingController();
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _specialtyController.dispose();
//     super.dispose();
//   }

//   void _showSnackBar(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? AppColors.errorColor : AppColors.successColor,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   Future<void> _completeOnboarding() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       _showSnackBar('User not logged in.', isError: true);
//       setState(() => _isLoading = false);
//       return;
//     }

//     try {
//       await firebaseService.updateUserProfile(
//         currentUser.uid,
//         {
//           'educationLevel': _selectedEducationLevel,
//           'specialty': _specialtyController.text.trim(),
//         },
//       );
//       _showSnackBar('Profile updated! Welcome to Gamifier!');
//       Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//     } catch (e) {
//       _showSnackBar('Error completing onboarding: $e', isError: true);
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(AppConstants.padding * 2),
//             child: Card(
//               color: AppColors.cardColor.withOpacity(0.95),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
//               ),
//               elevation: 12,
//               child: Padding(
//                 padding: const EdgeInsets.all(AppConstants.padding * 2),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'Tell us about yourself!',
//                         style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                               color: AppColors.accentColor,
//                               fontWeight: FontWeight.bold,
//                               // Replace neonTextStyle with a standard style
//                               shadows: [
//                                 Shadow(
//                                   blurRadius: 10.0,
//                                   color: AppColors.accentColor.withOpacity(0.5),
//                                   offset: const Offset(0, 0),
//                                 ),
//                               ],
//                             ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: AppConstants.padding * 1.5),
//                       Text(
//                         'This helps us personalize your learning experience and AI tutor interactions.',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: AppConstants.padding),
//                       DropdownButtonFormField<String>(
//                         value: _selectedEducationLevel,
//                         decoration: InputDecoration(
//                           labelText: 'Your Highest Education Level',
//                           labelStyle: const TextStyle(color: AppColors.textColorSecondary),
//                           filled: true,
//                           fillColor: AppColors.primaryColor.withOpacity(0.1),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         dropdownColor: AppColors.cardColor,
//                         style: const TextStyle(color: AppColors.textColor),
//                         items: AppConstants.educationLevels.map((String level) {
//                           return DropdownMenuItem<String>(
//                             value: level,
//                             child: Text(level),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _selectedEducationLevel = newValue;
//                           });
//                         },
//                         validator: (value) => ValidationUtils.validateNotEmpty(value, 'Please select your education level'),
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       TextFormField(
//                         controller: _specialtyController,
//                         style: const TextStyle(color: AppColors.textColor),
//                         decoration: InputDecoration(
//                           labelText: 'Your Specialty or Primary Interest (e.g., Computer Science, History)',
//                           labelStyle: const TextStyle(color: AppColors.textColorSecondary),
//                           filled: true,
//                           fillColor: AppColors.primaryColor.withOpacity(0.1),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         validator: (value) => ValidationUtils.validateNotEmpty(value, 'Please enter your specialty/interest'),
//                       ),
//                       const SizedBox(height: AppConstants.padding * 1.5),
//                       _isLoading
//                           ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor))
//                           : ElevatedButton(
//                               onPressed: _completeOnboarding,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColors.accentColor,
//                                 foregroundColor: AppColors.cardColor,
//                                 padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
//                                 textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                                 elevation: 8,
//                               ),
//                               child: const Text('Continue to App'),
//                             ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/screens/level_selection_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/models/level.dart';
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/utils/app_extensions.dart'; // Import for firstWhereOrNull
// import 'package:gamifier/widgets/cards/level_card.dart'; // Import new LevelCard widget

// class LevelSelectionScreen extends StatefulWidget {
//   final Course course;

//   const LevelSelectionScreen({super.key, required this.course});

//   @override
//   State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
// }

// class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
//   // We no longer need _userProgress state here, as we'll use StreamBuilder directly.

//   @override
//   Widget build(BuildContext context) {
//     final firebaseService = Provider.of<FirebaseService>(context);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: CustomAppBar(
//         title: '${widget.course.title} Levels',
//         leadingWidget: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
//         child: StreamBuilder<List<Level>>(
//           stream: firebaseService.streamLevelsForCourse(widget.course.id),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                   child: CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
//             }
//             if (snapshot.hasError) {
//               return Center(
//                   child: Text('Error loading levels: ${snapshot.error}',
//                       style: const TextStyle(color: AppColors.errorColor)));
//             }
//             if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(
//                   child: Text('No levels found for this course.',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColorSecondary)));
//             }

//             final levels = snapshot.data!;
//             // Fetch user progress here as well, so it's always up-to-date with level changes.
//             return StreamBuilder<UserProgress?>(
//               stream: firebaseService.streamUserCourseProgress(currentUser.uid, widget.course.id),
//               builder: (context, progressSnapshot) {
//                 if (progressSnapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                       child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
//                 }
//                 if (progressSnapshot.hasError) {
//                   return Center(
//                       child: Text('Error loading user progress: ${progressSnapshot.error}',
//                           style: const TextStyle(color: AppColors.errorColor)));
//                 }

//                 final userProgress = progressSnapshot.data;

//                 return ListView.builder(
//                   padding: const EdgeInsets.all(AppConstants.padding),
//                   itemCount: levels.length,
//                   itemBuilder: (context, index) {
//                     final level = levels[index];
//                     final bool isCompleted = userProgress?.levelsCompleted.contains(level.id) ?? false;
//                     final bool isCurrentOrNextPlayable = _determinePlayability(level, levels, userProgress);
//                     final bool isLocked = !isCurrentOrNextPlayable && !isCompleted;

//                     return LevelCard( // Using the new LevelCard widget
//                       level: level,
//                       isCompleted: isCompleted,
//                       isLocked: isLocked,
//                       isCurrentOrNextPlayable: isCurrentOrNextPlayable,
//                       onTap: isLocked
//                           ? null
//                           : () async {
//                               // Handle reattempt logic: deduct XP if reattempting a completed level
//                               if (isCompleted) {
//                                 final bool confirmReattempt = await showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                     title: Text('Reattempt Level?', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: AppConstants.largeTextSize)),
//                                     content: Text(
//                                       'You have completed this level. Reattempting will deduct ${AppConstants.levelXpDeductionOnReattempt} XP. Do you want to proceed?',
//                                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: AppConstants.mediumTextSize),
//                                     ),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () => Navigator.of(context).pop(false),
//                                         child: const Text('Cancel'),
//                                       ),
//                                       ElevatedButton(
//                                         onPressed: () => Navigator.of(context).pop(true),
//                                         style: ElevatedButton.styleFrom(backgroundColor: AppColors.warningColor),
//                                         child: const Text('Reattempt'),
//                                       ),
//                                     ],
//                                   ),
//                                 ) ?? false;

//                                 if (confirmReattempt) {
//                                   await firebaseService.deductXp(currentUser.uid, AppConstants.levelXpDeductionOnReattempt);
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('${AppConstants.levelXpDeductionOnReattempt} XP deducted for reattempt.'),
//                                       backgroundColor: AppColors.warningColor,
//                                     ),
//                                   );
//                                   // Proceed to lesson
//                                   Navigator.of(context).pushNamed(
//                                     AppRouter.lessonRoute,
//                                     arguments: {
//                                       'courseId': widget.course.id,
//                                       'levelId': level.id,
//                                       'lessonId': level.lessonIds.first, // Start with the first lesson of the level
//                                     },
//                                   );
//                                 }
//                               } else {
//                                 // Not completed, just proceed
//                                 Navigator.of(context).pushNamed(
//                                   AppRouter.lessonRoute,
//                                   arguments: {
//                                     'courseId': widget.course.id,
//                                     'levelId': level.id,
//                                     'lessonId': level.lessonIds.first, // Start with the first lesson of the level
//                                   },
//                                 );
//                               }
//                             },
//                     );
//                   },
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   // Logic to determine if a level is playable
//   bool _determinePlayability(Level currentLevel, List<Level> allLevels, UserProgress? userProgress) {
//     if (userProgress == null) {
//       return currentLevel.order == 1; // Only the first level is playable if no progress exists
//     }

//     // If the level is already completed, it's playable (for review/reattempt)
//     if (userProgress.levelsCompleted.contains(currentLevel.id)) {
//       return true;
//     }

//     // If it's the first level, it's always playable
//     if (currentLevel.order == 1) {
//       return true;
//     }

//     // Check if the previous level is completed
//     final previousLevelOrder = currentLevel.order - 1;
//     // Use the imported extension method for firstWhereOrNull
//     final previousLevel = allLevels.firstWhereOrNull((l) => l.order == previousLevelOrder);

//     if (previousLevel != null) {
//       return userProgress.levelsCompleted.contains(previousLevel.id);
//     }

//     return false; // Should not happen for well-ordered levels
//   }
// }

// // lib/screens/level_completion_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';

// class LevelCompletionScreen extends StatelessWidget {
//   final String courseId;
//   final String levelId; // The level that was just completed
//   final int totalXpEarned; // XP earned in this specific level
//   final int levelScore; // Score for the just completed level (e.g., in percentage)
//   final int lessonsCompleted; // Number of lessons completed in this level
//   final int totalLessons; // Total number of lessons in this level

//   const LevelCompletionScreen({
//     super.key,
//     required this.courseId,
//     required this.levelId,
//     required this.totalXpEarned,
//     required this.levelScore,
//     required this.lessonsCompleted,
//     required this.totalLessons,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Level Completed!',
//         leadingWidget: IconButton(
//           icon: const Icon(Icons.close, color: AppColors.textColor),
//           onPressed: () => Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Center(
//           child: Card(
//             color: AppColors.cardColor.withOpacity(0.95),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2)),
//             elevation: 10,
//             child: Padding(
//               padding: const EdgeInsets.all(AppConstants.padding * 2),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(
//                     Icons.celebration,
//                     color: AppColors.successColor,
//                     size: 80,
//                   ),
//                   const SizedBox(height: AppConstants.padding),
//                   Text(
//                     'Level Complete!',
//                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                           color: AppColors.successColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: AppConstants.largeTextSize + 4, // Larger for emphasis
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: AppConstants.spacing),
//                   Text(
//                     'You have successfully completed Level $levelId!', // Assuming levelId can be used for display
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor, fontSize: AppConstants.largeTextSize),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: AppConstants.padding),
//                   _buildStatRow(context, 'XP Earned:', '$totalXpEarned XP', Icons.star, AppColors.xpColor),
//                   _buildStatRow(context, 'Level Score:', '$levelScore%', Icons.score, AppColors.accentColor),
//                   _buildStatRow(context, 'Lessons Completed:', '$lessonsCompleted / $totalLessons', Icons.menu_book, AppColors.primaryColor),
//                   const SizedBox(height: AppConstants.padding * 2),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       // Navigate back to Level Selection for the same course
//                       Navigator.of(context).pushReplacementNamed(
//                         AppRouter.levelSelectionRoute,
//                         arguments: {'courseId': courseId}, // Pass courseId to LevelSelectionScreen
//                       );
//                     },
//                     icon: const Icon(Icons.navigate_next),
//                     label: const Text('Continue to Next Level'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.accentColor,
//                       foregroundColor: AppColors.cardColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                       ),
//                       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
//                       textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: AppConstants.mediumTextSize),
//                     ),
//                   ),
//                   const SizedBox(height: AppConstants.spacing),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//                     },
//                     child: Text(
//                       'Back to Home',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColorSecondary, fontSize: AppConstants.mediumTextSize),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatRow(BuildContext context, String label, String value, IconData icon, Color iconColor) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: iconColor, size: AppConstants.iconSize),
//               const SizedBox(width: AppConstants.spacing),
//               Text(
//                 label,
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColorSecondary, fontSize: AppConstants.mediumTextSize),
//               ),
//             ],
//           ),
//           Text(
//             value,
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   color: AppColors.textColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: AppConstants.mediumTextSize,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/screens/lesson_screen.dart
// import 'package:flutter/material.dart' hide ProgressBar; // Hide ProgressBar from material.dart to avoid conflict
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/gemini_api_service.dart';
// import 'package:gamifier/services/audio_service.dart';
// import 'package:gamifier/models/lesson.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/models/level.dart'; // Import Level model
// import 'package:gamifier/models/course.dart'; // Import Course model
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/loading_indicator.dart';
// import 'package:gamifier/widgets/questions/question_renderer.dart';
// import 'package:gamifier/widgets/feedback/personalized_feedback_modal.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/progress_bar.dart' as gamifier_progress_bar; // Explicitly import your ProgressBar with an alias
// import 'package:gamifier/utils/app_extensions.dart'; // Import for firstWhereOrNull
// import 'package:youtube_player_flutter/youtube_player_flutter.dart'; // Import youtube_player_flutter

// class LessonScreen extends StatefulWidget {
//   final String courseId;
//   final String levelId;
//   final String lessonId;

//   const LessonScreen({
//     super.key,
//     required this.courseId,
//     required this.levelId,
//     required this.lessonId,
//   });

//   @override
//   State<LessonScreen> createState() => _LessonScreenState();
// }

// class _LessonScreenState extends State<LessonScreen> {
//   Lesson? _currentLesson;
//   List<Question> _questions = [];
//   int _currentQuestionIndex = 0;
//   bool _isLoading = true;
//   String _loadingMessage = 'Loading lesson...';
//   UserProgress? _userProgress;
//   Level? _currentLevel; // To store the current level details
//   int _correctAnswersInLesson = 0;
//   int _xpEarnedInLesson = 0; // XP earned in the current session of this lesson
//   int _totalLessonsInLevel = 0; // To track total lessons in the current level
//   Course? _currentCourse; // To store the current course details

//   YoutubePlayerController? _youtubeController;
//   String? _youtubeVideoId; // Store the extracted YouTube video ID

//   @override
//   void initState() {
//     super.initState();
//     _loadLessonAndQuestions();
//   }

//   @override
//   void dispose() {
//     _youtubeController?.dispose(); // Dispose YouTube player
//     super.dispose();
//   }

//   void _showSnackBar(String message, {bool isError = false}) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? AppColors.errorColor : AppColors.successColor,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   // Function to extract YouTube video ID from a URL
//   String? _getYoutubeVideoId(String url) {
//     if (url.contains('youtu.be/')) {
//       return url.split('youtu.be/').last.split('?').first;
//     } else if (url.contains('youtube.com/watch?v=')) {
//       return Uri.parse(url).queryParameters['v'];
//     }
//     return null;
//   }

//   Future<void> _loadLessonAndQuestions() async {
//     setState(() {
//       _isLoading = true;
//       _loadingMessage = 'Fetching lesson content...';
//     });

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       _showSnackBar('User not logged in.', isError: true);
//       setState(() => _isLoading = false);
//       return;
//     }

//     try {
//       final lesson = await firebaseService.getLesson(widget.levelId, widget.lessonId);
//       if (lesson == null) {
//         _showSnackBar('Lesson not found.', isError: true);
//         if (mounted) Navigator.of(context).pop();
//         return;
//       }
//       final questions = await firebaseService.getLessonQuestions(widget.levelId, widget.lessonId);
//       final userProgress = await firebaseService.getUserCourseProgress(currentUser.uid, widget.courseId);
//       final level = await firebaseService.getLevel(widget.levelId); // Fetch current level
//       final course = await firebaseService.getCourse(widget.courseId); // Fetch current course

//       if (level == null) {
//         _showSnackBar('Level not found.', isError: true);
//         if (mounted) Navigator.of(context).pop();
//         return;
//       }
//       if (course == null) {
//         _showSnackBar('Course not found.', isError: true);
//         if (mounted) Navigator.of(context).pop();
//         return;
//       }


//       setState(() {
//         _currentLesson = lesson;
//         _questions = questions;
//         _userProgress = userProgress;
//         _currentLevel = level;
//         _currentCourse = course;
//         _totalLessonsInLevel = level.lessonIds.length;
//         _isLoading = false;

//         // Extract YouTube Video ID from lesson content
//         final youtubeRegex = RegExp(
//             r'(?:https?:\/\/)?(?:www\.)?(?:m\.)?(?:youtube\.com|youtu\.be)\/(?:watch\?v=|embed\/|v\/|)([\w-]{11})(?:\S+)?',
//             caseSensitive: false);
//         final match = youtubeRegex.firstMatch(lesson.content);
//         if (match != null && match.group(1) != null) {
//           _youtubeVideoId = match.group(1);
//           _youtubeController = YoutubePlayerController(
//             initialVideoId: _youtubeVideoId!,
//             flags: const YoutubePlayerFlags(
//               autoPlay: false,
//               mute: false,
//             ),
//           );
//         }

//         // Restore progress for current lesson if available
//         if (_userProgress?.lessonsProgress[widget.lessonId]?.isCompleted == true) {
//           _currentQuestionIndex = _questions.length; // Mark all questions as done
//         }
//       });
//     } catch (e) {
//       _showSnackBar('Error loading lesson: $e', isError: true);
//       debugPrint('Lesson loading error: $e');
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _handleAnswer(String userAnswer) async {
//     if (_currentLesson == null || _questions.isEmpty || _currentQuestionIndex >= _questions.length) {
//       return;
//     }

//     final currentQuestion = _questions[_currentQuestionIndex];
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final audioService = Provider.of<AudioService>(context, listen: false);
//     final geminiApiService = Provider.of<GeminiApiService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       _showSnackBar('User not logged in.', isError: true);
//       return;
//     }

//     bool isCorrect = false;
//     // Basic validation for accuracy
//     switch (currentQuestion.type) {
//       case QuestionType.mcq:
//         isCorrect = (userAnswer == currentQuestion.correctAnswer);
//         break;
//       case QuestionType.fillInBlank:
//         isCorrect = (userAnswer.trim().toLowerCase() == (currentQuestion.correctAnswer as String?)?.trim().toLowerCase());
//         break;
//       case QuestionType.shortAnswer:
//         // For short answer, check if keywords are present
//         if (currentQuestion.expectedAnswerKeywords != null) {
//           final keywords = currentQuestion.expectedAnswerKeywords!.split(',').map((e) => e.trim().toLowerCase()).toList();
//           isCorrect = keywords.every((keyword) => userAnswer.toLowerCase().contains(keyword));
//         } else {
//           isCorrect = (userAnswer.trim().toLowerCase() == (currentQuestion.correctAnswer as String?)?.trim().toLowerCase()); // Fallback
//         }
//         break;
//       case QuestionType.scenario:
//       // For scenario questions, simply checking for outcome might be too simplistic.
//       // Could use AI to evaluate the outcome or a more complex regex.
//       // For now, let's compare with expectedOutcome.
//         isCorrect = (userAnswer.trim().toLowerCase() == currentQuestion.expectedOutcome?.trim().toLowerCase());
//         break;
//       default:
//         isCorrect = false;
//     }

//     if (isCorrect) {
//       audioService.playCorrectSound();
//       _showSnackBar('Correct! You earned ${currentQuestion.xpReward} XP.');
//       _xpEarnedInLesson += currentQuestion.xpReward;
//       _correctAnswersInLesson++;
//       await firebaseService.addXp(currentUser.uid, currentQuestion.xpReward);
//       // Update total XP earned for this course
//       _userProgress = _userProgress?.copyWith(
//         totalXpEarned: (_userProgress?.totalXpEarned ?? 0) + currentQuestion.xpReward,
//       );
//     } else {
//       // AI Feedback for incorrect answers
//       setState(() {
//         _isLoading = true;
//         _loadingMessage = 'Generating personalized feedback...';
//       });

//       try {
//         final feedback = await geminiApiService.generateSocraticFeedback(
//           userAnswer: userAnswer,
//           questionText: currentQuestion.questionText,
//           correctAnswer: currentQuestion.correctAnswer?.toString() ?? currentQuestion.expectedAnswerKeywords ?? currentQuestion.expectedOutcome ?? 'N/A',
//           lessonContent: _currentLesson!.content,
//           userProgress: _userProgress,
//         );

//         if (!mounted) return; // Check if widget is still mounted after async operation

//         showDialog(
//           context: context,
//           builder: (context) => PersonalizedFeedbackModal(
//             feedbackText: feedback['feedbackText'],
//             socraticFollowUp: feedback['socraticFollowUp'],
//             adaptiveHints: feedback['adaptiveHints'],
//             encouragement: feedback['encouragement'],
//             isCorrect: false,
//           ),
//         );
//       } catch (e) {
//         _showSnackBar('Failed to get AI feedback: $e', isError: true);
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//       audioService.playIncorrectSound(); // Assuming you have an incorrect sound
//       _showSnackBar('Incorrect. Try again!', isError: true);
//     }

//     // Update user progress regardless of correctness
//     await _updateUserProgress(currentUser.uid, currentQuestion.id, isCorrect);

//     setState(() {
//       if (isCorrect || currentQuestion.type == QuestionType.scenario) { // Allow moving on for scenario after one attempt
//         _currentQuestionIndex++;
//       }
//     });
//   }

//   Future<void> _updateUserProgress(String userId, String questionId, bool isCorrect) async {
//     // Obtain services within this method's scope
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final audioService = Provider.of<AudioService>(context, listen: false);

//     _userProgress ??= UserProgress(
//       id: '${userId}_${widget.courseId}',
//       userId: userId,
//       courseId: widget.courseId,
//       currentLevelId: widget.levelId,
//       currentLessonId: widget.lessonId,
//       levelsCompleted: [],
//       lessonsProgress: {},
//       totalXpEarned: 0, // Initialize if new
//     );

//     // Update question status
//     final lessonProgress = _userProgress!.lessonsProgress[widget.lessonId] ??
//         LessonProgress(
//           lessonId: widget.lessonId,
//           completedQuestions: [],
//           attempts: {},
//           isCompleted: false,
//         );

//     final questionAttempts = lessonProgress.attempts[questionId] ?? 0;
//     lessonProgress.attempts[questionId] = questionAttempts + 1;

//     if (isCorrect && !lessonProgress.completedQuestions.contains(questionId)) {
//       lessonProgress.completedQuestions.add(questionId);
//     }

//     // Check if all questions in the current lesson are completed
//     final allQuestionsCompletedInLesson = _questions.every((q) => lessonProgress.completedQuestions.contains(q.id));
//     if (allQuestionsCompletedInLesson && !lessonProgress.isCompleted) {
//       lessonProgress.isCompleted = true;
//       _userProgress = _userProgress!.copyWith(
//         lessonsProgress: Map.from(_userProgress!.lessonsProgress)
//           ..[widget.lessonId] = lessonProgress,
//       );

//       // Check if all lessons in the current level are completed
//       final currentLevel = await firebaseService.getLevel(widget.levelId);
//       if (currentLevel != null) {
//         final allLessonsInLevelCompleted = currentLevel.lessonIds.every((lessonId) {
//           return _userProgress?.lessonsProgress[lessonId]?.isCompleted == true;
//         });

//         if (allLessonsInLevelCompleted && !_userProgress!.levelsCompleted.contains(widget.levelId)) {
//           final updatedLevelsCompleted = List<String>.from(_userProgress!.levelsCompleted)..add(widget.levelId);
//           _userProgress = _userProgress!.copyWith(levelsCompleted: updatedLevelsCompleted);

//           // Find the next level in the course
//           final course = await firebaseService.getCourse(widget.courseId);
//           if (course != null) {
//             final allCourseLevels = await Future.wait(
//                 course.levelIds.map((id) => firebaseService.getLevel(id)).where((future) => future != null).cast<Future<Level?>>());
//             final sortedLevels = allCourseLevels.whereType<Level>().toList()..sort((a, b) => a.order.compareTo(b.order));

//             final currentLevelIndex = sortedLevels.indexWhere((l) => l.id == widget.levelId);
//             if (currentLevelIndex != -1 && currentLevelIndex + 1 < sortedLevels.length) {
//               final nextLevel = sortedLevels[currentLevelIndex + 1];
//               _userProgress = _userProgress!.copyWith(
//                 currentLevelId: nextLevel.id,
//                 currentLessonId: nextLevel.lessonIds.first,
//               );
//               _showSnackBar('Level Completed! Moving to next level.', isError: false);
//               audioService.playLevelUpSound(); // Play level up sound
//             } else {
//               // All levels completed in the course, navigate to CourseCompletionScreen
//               _userProgress = _userProgress!.copyWith(
//                 currentLevelId: null,
//                 currentLessonId: null,
//               );
//               _showSnackBar('Course Completed! Congratulations!', isError: false);
//               if (mounted) {
//                 Navigator.of(context).pushReplacementNamed(
//                   AppRouter.courseCompletionRoute,
//                   arguments: {
//                     'courseTitle': _currentCourse!.title,
//                     'totalXpEarnedInCourse': _userProgress!.totalXpEarned, // Now uses actual totalXpEarned
//                     'totalLevelsCompleted': _userProgress!.levelsCompleted.length,
//                     'totalLevelsInCourse': _currentCourse!.levelIds.length,
//                   },
//                 );
//               }
//               return; // Exit function after navigating to course completion
//             }
//           }
//         }
//       }
//     }

//     await firebaseService.saveUserProgress(_userProgress!);
//   }


//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return Scaffold(
//         body: LoadingIndicator(message: _loadingMessage),
//       );
//     }

//     if (_currentLesson == null) {
//       return Scaffold(
//         appBar: CustomAppBar(
//           title: 'Lesson Error',
//           leadingWidget: IconButton(
//             icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ),
//         body: Center(
//           child: Text('Failed to load lesson content.',
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.errorColor)),
//         ),
//       );
//     }

//     final double lessonProgress = _questions.isEmpty ? 0.0 : _currentQuestionIndex / _questions.length;
//     final int currentLessonIndexInLevel = _currentLevel?.lessonIds.indexOf(widget.lessonId) ?? 0;
//     // Calculate level completion progress. If lesson is completed, it counts as 1.
//     final double levelCompletionProgress = _totalLessonsInLevel == 0 ? 0.0 : (currentLessonIndexInLevel + (
//       _userProgress?.lessonsProgress[widget.lessonId]?.isCompleted == true ? 1 : 0
//     )) / _totalLessonsInLevel;

//     // Determine button text based on next lesson/level availability
//     final int currentLessonOrder = _currentLevel?.lessonIds.indexOf(widget.lessonId) ?? -1;
//     final bool hasNextLesson = currentLessonOrder != -1 && (currentLessonOrder + 1 < (_currentLevel?.lessonIds.length ?? 0));

//     bool isLastLevelOfCourse = false;
//     if (_currentCourse != null && _currentLevel != null) {
//       final currentLevelIndexInCourse = _currentCourse!.levelIds.indexOf(_currentLevel!.id);
//       isLastLevelOfCourse = currentLevelIndexInCourse != -1 && (currentLevelIndexInCourse + 1 == _currentCourse!.levelIds.length);
//     }


//     return YoutubePlayerBuilder(
//       player: YoutubePlayer(
//         controller: _youtubeController ?? YoutubePlayerController(initialVideoId: ''),
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: AppColors.accentColor,
//         bottomActions: [
//           CurrentPosition(),
//           ProgressBar(), // Removed isDraggable as it's not a named parameter here
//           FullScreenButton(),
//           RemainingDuration(),
//         ],
//       ),
//       builder: (context, player) {
//         return Scaffold(
//           appBar: CustomAppBar(
//             title: _currentLesson!.title,
//             leadingWidget: IconButton(
//               icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             trailingWidget: gamifier_progress_bar.ProgressBar( // Explicitly use your ProgressBar via alias
//               progress: levelCompletionProgress,
//               height: 20,
//               width: 100,
//               label: 'Level Progress: ${(levelCompletionProgress * 100).toInt()}%',
//               foregroundColor: AppColors.levelColor,
//             ),
//           ),
//           body: Container(
//             decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.all(AppConstants.padding),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // YouTube Video Player
//                         if (_youtubeVideoId != null && _youtubeController != null) ...[
//                           player,
//                           const SizedBox(height: AppConstants.padding),
//                           Text(
//                             'Lesson Content (Text)',
//                             style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                               color: AppColors.textColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: AppConstants.largeTextSize,
//                             ),
//                           ),
//                           const SizedBox(height: AppConstants.spacing),
//                         ],
//                         Card(
//                           color: AppColors.cardColor.withOpacity(0.9),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                           elevation: 4,
//                           child: Padding(
//                             padding: const EdgeInsets.all(AppConstants.padding),
//                             child: MarkdownBody(
//                               data: _currentLesson!.content,
//                               styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
//                                 p: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary, fontSize: AppConstants.mediumTextSize),
//                                 h1: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.textColor, fontSize: AppConstants.largeTextSize + 4),
//                                 h2: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textColor, fontSize: AppConstants.largeTextSize),
//                                 h3: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor, fontSize: AppConstants.mediumTextSize + 2),
//                                 strong: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                                 code: TextStyle(
//                                     backgroundColor: AppColors.primaryColor.withOpacity(0.2),
//                                     color: AppColors.accentColor,
//                                     fontFamily: 'monospace',
//                                     fontSize: AppConstants.smallTextSize),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: AppConstants.padding * 2),
//                         if (_questions.isNotEmpty) ...[
//                           Text(
//                             'Test Your Knowledge',
//                             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                                   color: AppColors.textColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: AppConstants.largeTextSize,
//                                 ),
//                           ),
//                           const SizedBox(height: AppConstants.padding),
//                           if (_currentQuestionIndex < _questions.length)
//                             QuestionRenderer(
//                               question: _questions[_currentQuestionIndex],
//                               onAnswerSubmitted: _handleAnswer,
//                             )
//                           else
//                             Column(
//                               children: [
//                                 Center(
//                                   child: Text(
//                                     'Lesson Completed!',
//                                     style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.successColor),
//                                   ),
//                                 ),
//                                 const SizedBox(height: AppConstants.padding),
//                                 Text(
//                                   'You answered $_correctAnswersInLesson out of ${_questions.length} questions correctly and earned $_xpEarnedInLesson XP!',
//                                   style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 const SizedBox(height: AppConstants.padding),
//                                 ElevatedButton.icon(
//                                   onPressed: () async {
//                                     if (hasNextLesson) {
//                                       final nextLessonId = _currentLevel!.lessonIds[currentLessonOrder + 1];
//                                       if (mounted) {
//                                         Navigator.of(context).pushReplacementNamed(
//                                           AppRouter.lessonRoute,
//                                           arguments: {
//                                             'courseId': widget.courseId,
//                                             'levelId': widget.levelId,
//                                             'lessonId': nextLessonId,
//                                           },
//                                         );
//                                       }
//                                     } else {
//                                       if (isLastLevelOfCourse) {
//                                         if (mounted) {
//                                           Navigator.of(context).pushReplacementNamed(
//                                             AppRouter.courseCompletionRoute,
//                                             arguments: {
//                                               'courseTitle': _currentCourse!.title,
//                                               'totalXpEarnedInCourse': _userProgress!.totalXpEarned,
//                                               'totalLevelsCompleted': _userProgress!.levelsCompleted.length,
//                                               'totalLevelsInCourse': _currentCourse!.levelIds.length,
//                                             },
//                                           );
//                                         }
//                                       } else {
//                                         if (mounted) {
//                                           Navigator.of(context).pushReplacementNamed(
//                                             AppRouter.levelCompletionRoute,
//                                             arguments: {
//                                               'courseId': widget.courseId,
//                                               'levelId': widget.levelId,
//                                               'totalXpEarned': _xpEarnedInLesson,
//                                               'levelScore': (_questions.isEmpty ? 0 : (_correctAnswersInLesson / _questions.length * 100)).round(),
//                                               'lessonsCompleted': (_userProgress?.lessonsProgress.values.where((p) => p.isCompleted).length ?? 0),
//                                               'totalLessons': (_currentLevel?.lessonIds.length ?? 0),
//                                             },
//                                           );
//                                         }
//                                       }
//                                     }
//                                   },
//                                   icon: const Icon(Icons.navigate_next),
//                                   label: Text(hasNextLesson ? 'Continue to Next Lesson' : (isLastLevelOfCourse ? 'Complete Course' : 'Complete Level')),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: AppColors.accentColor,
//                                     foregroundColor: AppColors.cardColor,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                                     ),
//                                     padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
//                                     textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppConstants.mediumTextSize), // Smaller text
//                                   ),
//                                 ),
//                               ],
//                             )
//                         ] else
//                           Center(
//                             child: Text(
//                               'No questions for this lesson yet.',
//                               style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary, fontSize: AppConstants.mediumTextSize),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// // lib/screens/home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/lesson.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:gamifier/widgets/cards/course_card.dart';
// import 'package:gamifier/widgets/cards/current_lesson_card.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/xp_level_display.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/models/level.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final firebaseService = Provider.of<FirebaseService>(context);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Welcome Back!',
//         leadingWidget: StreamBuilder<UserProfile?>(
//           stream: firebaseService.streamUserProfile(currentUser.uid),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator(strokeWidth: 2);
//             }
//             if (snapshot.hasError) {
//               return const Icon(Icons.error, color: AppColors.errorColor);
//             }
//             final userProfile = snapshot.data;
//             if (userProfile == null) {
//               return const CircleAvatar(
//                 backgroundColor: AppColors.cardColor,
//                 child: Icon(Icons.person, color: AppColors.textColorSecondary),
//               );
//             }
//             return GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pushNamed(AppRouter.profileRoute);
//               },
//               child: CircleAvatar(
//                 radius: 24, // Smaller radius for app bar
//                 backgroundColor: AppColors.cardColor,
//                 backgroundImage: AssetImage(userProfile.avatarAssetPath),
//                 onBackgroundImageError: (exception, stackTrace) {
//                   debugPrint('Error loading avatar image: $exception');
//                 },
//               ),
//             );
//           },
//         ),
//         trailingWidget: StreamBuilder<UserProfile?>(
//           stream: firebaseService.streamUserProfile(currentUser.uid),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const SizedBox.shrink();
//             }
//             if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
//               return const SizedBox.shrink();
//             }
//             final userProfile = snapshot.data!;
//             return Row(
//               children: [
//                 // Streak Display
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: AppConstants.spacing,
//                     vertical: AppConstants.spacing / 2,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.cardColor.withOpacity(0.7),
//                     borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                     border: Border.all(color: AppColors.borderColor, width: 1.0),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.local_fire_department, color: AppColors.xpColor, size: AppConstants.iconSize * 0.8), // 🔥 icon, smaller
//                       const SizedBox(width: AppConstants.spacing / 2),
//                       Text(
//                         '${userProfile.currentStreak} 🔥',
//                         style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                               color: AppColors.xpColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: AppConstants.smallTextSize, // Smaller text
//                             ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: AppConstants.spacing),
//                 XpLevelDisplay(
//                   xp: userProfile.xp,
//                   level: userProfile.level,
//                   showLabel: false, // Don't show "XP:" and "Level:" in app bar
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: _HomeContent(
//           onItemTapped: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//             switch (index) {
//               case 0:
//                 break;
//               case 1:
//                 Navigator.of(context).pushNamed(AppRouter.courseCreationRoute);
//                 break;
//               case 2:
//                 Navigator.of(context).pushNamed(AppRouter.progressRoute);
//                 break;
//               case 3:
//                 Navigator.of(context).pushNamed(AppRouter.profileRoute);
//                 break;
//               case 4:
//                 Navigator.of(context).pushNamed(AppRouter.communityRoute);
//                 break;
//               case 5: // AI Chatbot
//                 Navigator.of(context).pushNamed(AppRouter.aiChatRoute);
//                 break;
//             }
//           },
//         ),
//       ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//           switch (index) {
//             case 0:
//               break;
//             case 1:
//               Navigator.of(context).pushNamed(AppRouter.courseCreationRoute);
//               break;
//             case 2:
//               Navigator.of(context).pushNamed(AppRouter.progressRoute);
//               break;
//             case 3:
//               Navigator.of(context).pushNamed(AppRouter.profileRoute);
//               break;
//             case 4:
//               Navigator.of(context).pushNamed(AppRouter.communityRoute);
//               break;
//             case 5: // AI Chatbot
//               Navigator.of(context).pushNamed(AppRouter.aiChatRoute);
//               break;
//           }
//         },
//       ),
//     );
//   }
// }

// class _HomeContent extends StatelessWidget {
//   final Function(int) onItemTapped;
//   const _HomeContent({required this.onItemTapped});

//   @override
//   Widget build(BuildContext context) {
//     final firebaseService = Provider.of<FirebaseService>(context);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       return const Center(child: Text('User not logged in.', style: TextStyle(color: AppColors.textColor)));
//     }

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(AppConstants.padding),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Continue Learning',
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   color: AppColors.textColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: AppConstants.largeTextSize, // Adjusted text size
//                 ),
//           ),
//           const SizedBox(height: AppConstants.spacing),
//           StreamBuilder<UserProgress?>(
//             stream: firebaseService.streamUserCourseProgress(currentUser.uid, 'placeholder_course_id'), // Placeholder course ID, actual will be determined
//             builder: (context, progressSnapshot) {
//               if (progressSnapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                     child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
//               }
//               if (progressSnapshot.hasError) {
//                 return Center(
//                     child: Text('Error loading progress: ${progressSnapshot.error}',
//                         style: const TextStyle(color: AppColors.errorColor)));
//               }

//               final userProgress = progressSnapshot.data;
//               // Attempt to find the actual current course/lesson from userProgress
//               // This is a simplified approach, ideally, currentLevelId and currentLessonId
//               // would point to a valid ongoing activity.
//               if (userProgress == null || userProgress.currentLevelId == null || userProgress.currentLessonId == null) {
//                 return Card(
//                   color: AppColors.cardColor,
//                   child: Padding(
//                     padding: const EdgeInsets.all(AppConstants.padding),
//                     child: Column(
//                       children: [
//                         Text(
//                           'No ongoing lessons. Start a new course or create your own!',
//                           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                             color: AppColors.textColorSecondary,
//                             fontSize: AppConstants.mediumTextSize, // Adjusted text size
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: AppConstants.spacing),
//                         // Removed the duplicate "Create New Course" button here
//                       ],
//                     ),
//                   ),
//                 );
//               }

//               return FutureBuilder<Lesson?>(
//                 future: firebaseService.getLesson(userProgress.currentLevelId!, userProgress.currentLessonId!),
//                 builder: (context, lessonSnapshot) {
//                   if (lessonSnapshot.connectionState == ConnectionState.waiting) {
//                     return const CurrentLessonCard(
//                       courseTitle: 'Loading...',
//                       lessonTitle: 'Loading...',
//                       progress: 0.0,
//                       onTap: null,
//                     );
//                   }
//                   if (lessonSnapshot.hasError || !lessonSnapshot.hasData || lessonSnapshot.data == null) {
//                     return CurrentLessonCard(
//                       courseTitle: 'Error/No Lesson',
//                       lessonTitle: 'Could not load current lesson.',
//                       progress: 0.0,
//                       onTap: () {},
//                     );
//                   }

//                   final currentLesson = lessonSnapshot.data!;
//                   final lessonProgressData = userProgress.lessonsProgress[currentLesson.id];
//                   final double progress = (lessonProgressData != null && lessonProgressData.isCompleted) ? 1.0 : 0.0;

//                   return CurrentLessonCard(
//                     courseTitle: 'Current Course',
//                     lessonTitle: currentLesson.title,
//                     progress: progress,
//                     onTap: () {
//                       Navigator.of(context).pushNamed(
//                         AppRouter.lessonRoute,
//                         arguments: {
//                           'courseId': userProgress.courseId,
//                           'levelId': userProgress.currentLevelId!,
//                           'lessonId': currentLesson.id,
//                         },
//                       );
//                     },
//                   );
//                 },
//               );
//             },
//           ),
//           const SizedBox(height: AppConstants.padding * 2),

//           Text(
//             'My Courses',
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   color: AppColors.textColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: AppConstants.largeTextSize, // Adjusted text size
//                 ),
//           ),
//           const SizedBox(height: AppConstants.spacing),
//           StreamBuilder<List<Course>>(
//             stream: firebaseService.streamAllCoursesForUser(currentUser.uid), // Filter by creatorId
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                     child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
//               }
//               if (snapshot.hasError) {
//                 return Center(
//                     child: Text('Error loading courses: ${snapshot.error}',
//                         style: const TextStyle(color: AppColors.errorColor)));
//               }
//               if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Column(
//                   children: [
//                     Text(
//                       'You haven\'t created any courses yet. Create one now!',
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         color: AppColors.textColorSecondary,
//                         fontSize: AppConstants.mediumTextSize, // Adjusted text size
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: AppConstants.spacing),
//                     // Removed the ElevatedButton here, as creation is via bottom nav bar now.
//                   ],
//                 );
//               }

//               final courses = snapshot.data!;
//               return ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: courses.length,
//                 itemBuilder: (context, index) {
//                   final course = courses[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//                     child: CourseCard(
//                       course: course,
//                       onTap: () {
//                         Navigator.of(context).pushNamed(
//                           AppRouter.levelSelectionRoute,
//                           arguments: course,
//                         );
//                       },
//                       onDelete: (courseId, levelIds) async {
//                         final bool confirmDelete = await showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: Text('Delete Course?', style: TextStyle(fontSize: AppConstants.largeTextSize)), // Text size
//                             content: Text('Are you sure you want to delete this course and all its data? This cannot be undone.', style: TextStyle(fontSize: AppConstants.mediumTextSize)), // Text size
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.of(context).pop(false),
//                                 child: const Text('Cancel'),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () => Navigator.of(context).pop(true),
//                                 style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorColor),
//                                 child: const Text('Delete'),
//                               ),
//                             ],
//                           ),
//                         ) ?? false;

//                         if (confirmDelete) {
//                           try {
//                             await firebaseService.deleteCourse(courseId, levelIds);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Course "${course.title}" deleted successfully!'),
//                                 backgroundColor: AppColors.successColor,
//                               ),
//                             );
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Error deleting course: $e'),
//                                 backgroundColor: AppColors.errorColor,
//                               ),
//                             );
//                           }
//                         }
//                       },
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           const SizedBox(height: AppConstants.padding * 2),
//           Text(
//             'Explore Public Courses',
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   color: AppColors.textColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: AppConstants.largeTextSize, // Adjusted text size
//                 ),
//           ),
//           const SizedBox(height: AppConstants.spacing),
//           StreamBuilder<List<Course>>(
//             stream: firebaseService.streamPublicCourses(currentUser.uid), // Stream public courses (not created by current user)
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                     child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
//               }
//               if (snapshot.hasError) {
//                 return Center(
//                     child: Text('Error loading public courses: ${snapshot.error}',
//                         style: const TextStyle(color: AppColors.errorColor)));
//               }
//               if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Text(
//                   'No public courses available yet. Be the first to create one!',
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     color: AppColors.textColorSecondary,
//                     fontSize: AppConstants.mediumTextSize, // Adjusted text size
//                   ),
//                   textAlign: TextAlign.center,
//                 );
//               }

//               final publicCourses = snapshot.data!;
//               return ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: publicCourses.length,
//                 itemBuilder: (context, index) {
//                   final course = publicCourses[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//                     child: CourseCard(
//                       course: course,
//                       onTap: () {
//                         Navigator.of(context).pushNamed(
//                           AppRouter.levelSelectionRoute,
//                           arguments: course,
//                         );
//                       },
//                       onDelete: null, // Public courses cannot be deleted by others
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/screens/course_creation_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/gemini_api_service.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/models/level.dart';
// import 'package:gamifier/models/lesson.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/loading_indicator.dart';
// import 'package:gamifier/utils/validation_utils.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/models/user_profile.dart'; // Import UserProfile
// import 'package:file_picker/file_picker.dart'; // For picking PDF files
// import 'dart:typed_data'; // For Uint8List

// class CourseCreationScreen extends StatefulWidget {
//   const CourseCreationScreen({super.key});

//   @override
//   State<CourseCreationScreen> createState() => _CourseCreationScreenState();
// }

// class _CourseCreationScreenState extends State<CourseCreationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _topicController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _sourceContentController = TextEditingController();
//   final TextEditingController _youtubeUrlController = TextEditingController();

//   String? _selectedDifficulty;
//   String? _selectedGameGenre;
//   String? _selectedEducationLevel;
//   String? _specialty; // User's specialty, for contextual generation
//   UserProfile? _userProfile; // To store user's profile for context

//   String? _pdfFileName; // To display the name of the picked PDF
//   Uint8List? _pdfFileBytes; // To store PDF bytes (if needed for direct analysis, though often sent as text)

//   bool _isLoading = false;
//   String _loadingMessage = 'Generating course...';

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserProfile(); // Fetch user profile on init
//   }

//   @override
//   void dispose() {
//     _topicController.dispose();
//     _descriptionController.dispose();
//     _sourceContentController.dispose();
//     _youtubeUrlController.dispose();
//     super.dispose();
//   }

//   void _showSnackBar(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? AppColors.errorColor : AppColors.successColor,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   Future<void> _fetchUserProfile() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;
//     if (currentUser != null) {
//       _userProfile = await firebaseService.getUserProfile(currentUser.uid);
//       setState(() {
//         _selectedEducationLevel = _userProfile?.educationLevel;
//         _specialty = _userProfile?.specialty;
//       });
//     }
//   }

//   Future<void> _pickPdfFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf'],
//       );

//       if (result != null && result.files.single.bytes != null) {
//         setState(() {
//           _pdfFileName = result.files.single.name;
//           _pdfFileBytes = result.files.single.bytes;
//         });
//         _showSnackBar('PDF file selected: $_pdfFileName');
//         // In a real scenario, you might want to extract text from PDF here
//         // using a package like pdf_text or send bytes to a backend for processing.
//         // For now, we'll simulate converting it to text.
//         _sourceContentController.text = 'Content from $_pdfFileName (PDF parsing simulated).';
//       } else {
//         _showSnackBar('No PDF file selected.', isError: true);
//       }
//     } catch (e) {
//       _showSnackBar('Error picking PDF: $e', isError: true);
//       debugPrint('PDF picking error: $e');
//     }
//   }

//   Future<void> _generateCourse() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _loadingMessage = 'Generating course structure...';
//     });

//     final geminiApiService = Provider.of<GeminiApiService>(context, listen: false);
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       _showSnackBar('User not logged in. Please log in to create a course.', isError: true);
//       setState(() => _isLoading = false);
//       return;
//     }

//     String? pdfContentAsText;
//     if (_pdfFileBytes != null) {
//       // Simulate PDF content extraction. In a real app, you'd use a PDF parsing library.
//       // For now, we'll just pass a placeholder or the content from _sourceContentController if applicable.
//       pdfContentAsText = 'Content extracted from $_pdfFileName for topic ${_topicController.text}.';
//       // If a full PDF parsing library like 'pdf_text' was used:
//       // final pdfDocument = await PdfDocument.openData(_pdfFileBytes!);
//       // pdfContentAsText = await pdfDocument.extractFullText();
//     }

//     try {
//       final aiGeneratedContent = await geminiApiService.generateCourseContent(
//         topicName: _topicController.text,
//         ageGroup: _selectedGameGenre, // Used game genre as age group for broad context for AI
//         domain: _userProfile?.specialty, // Using specialty as domain
//         difficulty: _selectedDifficulty!,
//         educationLevel: _userProfile?.educationLevel, // Pass user's education level
//         specialty: _userProfile?.specialty,       // Pass user's specialty
//         sourceContent: _sourceContentController.text.isNotEmpty ? _sourceContentController.text : null,
//         youtubeUrl: _youtubeUrlController.text.isNotEmpty ? _youtubeUrlController.text : null,
//         pdfContent: pdfContentAsText, // Pass simulated PDF content
//       );

//       setState(() {
//         _loadingMessage = 'Saving course to database...';
//       });

//       final courseId = firebaseService.generateNewDocId();
//       final List<String> levelIds = [];
//       final List<Level> courseLevels = [];

//       int levelOrder = 1; // Start level order from 1
//       for (var levelData in aiGeneratedContent['levels']) {
//         final levelId = firebaseService.generateNewDocId();
//         levelIds.add(levelId);
//         final List<Lesson> levelLessons = [];
//         final Map<String, List<Question>> questionsPerLesson = {};

//         for (var lessonData in levelData['lessons']) {
//           final lessonId = firebaseService.generateNewDocId();
//           final List<Question> lessonQuestions = [];

//           // Ensure 10-20 questions per level, distributing across lessons
//           // This is a rough enforcement; actual AI generation quality might vary.
//           int minQuestions = 10 ~/ (levelData['lessons'].length == 0 ? 1 : levelData['lessons'].length);
//           int maxQuestions = 20 ~/ (levelData['lessons'].length == 0 ? 1 : levelData['lessons'].length);

//           // Adjust min/max questions to ensure at least 1-2 questions per lesson
//           minQuestions = minQuestions < 1 ? 1 : minQuestions;
//           maxQuestions = maxQuestions < minQuestions ? minQuestions : maxQuestions;

//           for (var questionData in lessonData['questions']) {
//             final questionId = firebaseService.generateNewDocId();
//             // Ensure correct mapping for each question type
//             QuestionType type;
//             dynamic correctAnswer;
//             List<String> options = [];
//             String? expectedAnswerKeywords;
//             String? scenarioText;
//             String? expectedOutcome;

//             switch (questionData['type']) {
//               case 'MCQ':
//                 type = QuestionType.mcq;
//                 options = List<String>.from(questionData['options'] ?? []);
//                 correctAnswer = questionData['correctAnswer'];
//                 break;
//               case 'FillInBlank':
//                 type = QuestionType.fillInBlank;
//                 correctAnswer = questionData['correctAnswer'];
//                 break;
//               case 'ShortAnswer':
//                 type = QuestionType.shortAnswer;
//                 expectedAnswerKeywords = questionData['expectedAnswerKeywords'];
//                 break;
//               case 'Scenario':
//                 type = QuestionType.scenario;
//                 scenarioText = questionData['scenarioText'];
//                 expectedOutcome = questionData['expectedOutcome'];
//                 break;
//               default:
//                 type = QuestionType.shortAnswer; // Default to short answer
//                 debugPrint('Unknown question type: ${questionData['type']}. Defaulting to ShortAnswer.');
//                 correctAnswer = questionData['correctAnswer'] ?? 'N/A'; // Fallback
//                 break;
//             }

//             lessonQuestions.add(
//               Question(
//                 id: questionId,
//                 questionText: questionData['questionText'],
//                 xpReward: questionData['xpReward'] ?? AppConstants.xpPerCorrectAnswer,
//                 type: type,
//                 options: options,
//                 correctAnswer: correctAnswer,
//                 expectedAnswerKeywords: expectedAnswerKeywords,
//                 scenarioText: scenarioText,
//                 expectedOutcome: expectedOutcome,
//               ),
//             );
//             // Ensure we don't exceed maxQuestions per lesson if AI over-generates
//             if (lessonQuestions.length >= maxQuestions) {
//               break;
//             }
//           }
//           // Ensure at least minQuestions per lesson
//           while (lessonQuestions.length < minQuestions && lessonData['questions'].length > lessonQuestions.length) {
//             // This loop is a fallback; ideally, AI generates enough.
//             // For a robust app, you might generate dummy questions or flag an error.
//             // For now, we'll skip if AI hasn't given enough.
//             debugPrint('Warning: Not enough questions generated for lesson. Expected min $minQuestions, got ${lessonQuestions.length}');
//             break; // Exit to avoid infinite loop if no more questions available from AI
//           }

//           levelLessons.add(
//             Lesson(
//               id: lessonId,
//               title: lessonData['title'],
//               content: lessonData['content'],
//               questionIds: lessonQuestions.map((q) => q.id).toList(),
//             ),
//           );
//           questionsPerLesson[lessonId] = lessonQuestions;
//         }

//         courseLevels.add(
//           Level(
//             id: levelId,
//             courseId: courseId,
//             title: levelData['title'],
//             description: levelData['description'],
//             difficulty: levelData['difficulty'],
//             order: levelOrder++, // Assign and increment order
//             lessonIds: levelLessons.map((l) => l.id).toList(),
//             imageAssetPath: levelData['imageAssetPath'], // Save the generated asset path
//           ),
//         );

//         // Save each level, its lessons, and questions
//         await firebaseService.saveLevel(courseLevels.last, levelLessons, questionsPerLesson);
//       }

//       // Create the Course object with the generated level IDs
//       final newCourse = Course(
//         id: courseId,
//         creatorId: currentUser.uid, // Assign creator ID (makes it private by default)
//         title: aiGeneratedContent['courseTitle'],
//         description: _descriptionController.text, // Use user provided description
//         difficulty: aiGeneratedContent['difficulty'],
//         gameGenre: aiGeneratedContent['gameGenre'],
//         levelIds: levelIds,
//         createdAt: DateTime.now(),
//       );

//       await firebaseService.saveCourse(newCourse);

//       _showSnackBar('Course "${newCourse.title}" created successfully!');
//       Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//     } catch (e) {
//       _showSnackBar('Error creating course: $e', isError: true);
//       debugPrint('Course creation error: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Create New Course',
//         leadingWidget: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               padding: const EdgeInsets.all(AppConstants.padding),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Course Details',
//                       style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                             color: AppColors.textColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: AppConstants.largeTextSize,
//                           ),
//                     ),
//                     const SizedBox(height: AppConstants.padding),
//                     TextFormField(
//                       controller: _topicController,
//                       style: const TextStyle(color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                       decoration: InputDecoration(
//                         labelText: 'Course Topic (e.g., Quantum Physics)',
//                         labelStyle: const TextStyle(color: AppColors.textColorSecondary, fontSize: AppConstants.smallTextSize),
//                         filled: true,
//                         fillColor: AppColors.cardColor.withOpacity(0.8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (value) => ValidationUtils.validateNotEmpty(value, 'Course topic cannot be empty'),
//                     ),
//                     const SizedBox(height: AppConstants.spacing),
//                     TextFormField(
//                       controller: _descriptionController,
//                       style: const TextStyle(color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                       decoration: InputDecoration(
//                         labelText: 'Course Description',
//                         labelStyle: const TextStyle(color: AppColors.textColorSecondary, fontSize: AppConstants.smallTextSize),
//                         filled: true,
//                         fillColor: AppColors.cardColor.withOpacity(0.8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       maxLines: 3,
//                       validator: (value) => ValidationUtils.validateNotEmpty(value, 'Course description cannot be empty'),
//                     ),
//                     const SizedBox(height: AppConstants.spacing),
//                     DropdownButtonFormField<String>(
//                       value: _selectedDifficulty,
//                       decoration: InputDecoration(
//                         labelText: 'Overall Difficulty',
//                         labelStyle: const TextStyle(color: AppColors.textColorSecondary, fontSize: AppConstants.smallTextSize),
//                         filled: true,
//                         fillColor: AppColors.cardColor.withOpacity(0.8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       dropdownColor: AppColors.cardColor,
//                       style: const TextStyle(color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                       items: AppConstants.difficultyLevels.map((String level) {
//                         return DropdownMenuItem<String>(
//                           value: level,
//                           child: Text(level),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedDifficulty = newValue;
//                         });
//                       },
//                       validator: (value) => ValidationUtils.validateNotEmpty(value, 'Please select a difficulty level'),
//                     ),
//                     const SizedBox(height: AppConstants.spacing),
//                     DropdownButtonFormField<String>(
//                       value: _selectedGameGenre,
//                       decoration: InputDecoration(
//                         labelText: 'Game Genre',
//                         labelStyle: const TextStyle(color: AppColors.textColorSecondary, fontSize: AppConstants.smallTextSize),
//                         filled: true,
//                         fillColor: AppColors.cardColor.withOpacity(0.8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       dropdownColor: AppColors.cardColor,
//                       style: const TextStyle(color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                       items: AppConstants.gameThemes.map((String genre) {
//                         return DropdownMenuItem<String>(
//                           value: genre,
//                           child: Text(genre),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedGameGenre = newValue;
//                         });
//                       },
//                       validator: (value) => ValidationUtils.validateNotEmpty(value, 'Please select a game genre'),
//                     ),
//                     const SizedBox(height: AppConstants.padding * 2),
//                     Text(
//                       'Optional: Provide Source Material',
//                       style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                             color: AppColors.textColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: AppConstants.largeTextSize,
//                           ),
//                     ),
//                     const SizedBox(height: AppConstants.spacing),
//                     TextFormField(
//                       controller: _sourceContentController,
//                       style: const TextStyle(color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                       decoration: InputDecoration(
//                         labelText: 'Paste text content here (e.g., article, notes)',
//                         labelStyle: const TextStyle(color: AppColors.textColorSecondary, fontSize: AppConstants.smallTextSize),
//                         filled: true,
//                         fillColor: AppColors.cardColor.withOpacity(0.8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       maxLines: 5,
//                     ),
//                     const SizedBox(height: AppConstants.spacing),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             'OR',
//                             style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary, fontSize: AppConstants.mediumTextSize),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         const SizedBox(width: AppConstants.padding),
//                         Expanded(
//                           child: ElevatedButton.icon(
//                             onPressed: _pickPdfFile,
//                             icon: const Icon(Icons.picture_as_pdf),
//                             label: Text(_pdfFileName ?? 'Upload PDF', style: TextStyle(fontSize: AppConstants.mediumTextSize)),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.primaryColor,
//                               foregroundColor: AppColors.textColor,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                               ),
//                               padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing, vertical: AppConstants.padding),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     if (_pdfFileName != null)
//                       Padding(
//                         padding: const EdgeInsets.only(top: AppConstants.spacing),
//                         child: Text(
//                           'Selected PDF: $_pdfFileName',
//                           style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColorSecondary, fontSize: AppConstants.smallTextSize),
//                         ),
//                       ),
//                     const SizedBox(height: AppConstants.spacing),
//                     TextFormField(
//                       controller: _youtubeUrlController,
//                       style: const TextStyle(color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                       decoration: InputDecoration(
//                         labelText: 'YouTube Video URL (e.g., https://youtu.be/dQw4w9WgXcQ)',
//                         labelStyle: const TextStyle(color: AppColors.textColorSecondary, fontSize: AppConstants.smallTextSize),
//                         filled: true,
//                         fillColor: AppColors.cardColor.withOpacity(0.8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (_sourceContentController.text.isEmpty && (_pdfFileName == null || _pdfFileName!.isEmpty) && value!.isEmpty) {
//                           return null; // All three can be empty, but only if no source is provided
//                         }
//                         return ValidationUtils.validateYoutubeUrl(value);
//                       },
//                     ),
//                     const SizedBox(height: AppConstants.padding * 2),
//                     Center(
//                       child: ElevatedButton.icon(
//                         onPressed: _isLoading ? null : _generateCourse,
//                         icon: const Icon(Icons.auto_awesome),
//                         label: Text(_isLoading ? 'Generating...' : 'Generate Course'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.accentColor,
//                           foregroundColor: AppColors.cardColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                           ),
//                           padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
//                           textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: AppConstants.largeTextSize),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: AppConstants.padding),
//                   ],
//                 ),
//               ),
//             ),
//             if (_isLoading)
//               LoadingIndicator(message: _loadingMessage),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // lib/screens/course_completion_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';

// class CourseCompletionScreen extends StatelessWidget {
//   final String courseTitle;
//   final int totalXpEarnedInCourse;
//   final int totalLevelsCompleted;
//   final int totalLevelsInCourse;

//   const CourseCompletionScreen({
//     super.key,
//     required this.courseTitle,
//     required this.totalXpEarnedInCourse,
//     required this.totalLevelsCompleted,
//     required this.totalLevelsInCourse,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Course Completed!',
//         leadingWidget: IconButton(
//           icon: const Icon(Icons.close, color: AppColors.textColor),
//           onPressed: () => Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Center(
//           child: Card(
//             color: AppColors.cardColor.withOpacity(0.95),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2)),
//             elevation: 10,
//             child: Padding(
//               padding: const EdgeInsets.all(AppConstants.padding * 2),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(
//                     Icons.emoji_events,
//                     color: AppColors.xpColor,
//                     size: 80,
//                   ),
//                   const SizedBox(height: AppConstants.padding),
//                   Text(
//                     'Course Completed!',
//                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                           color: AppColors.successColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: AppConstants.spacing),
//                   Text(
//                     'You have successfully conquered the "${courseTitle}" course!',
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor, fontSize: AppConstants.largeTextSize),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: AppConstants.padding),
//                   _buildStatRow(context, 'Total XP:', '$totalXpEarnedInCourse XP', Icons.star, AppColors.xpColor),
//                   _buildStatRow(context, 'Levels Mastered:', '$totalLevelsCompleted / $totalLevelsInCourse', Icons.menu_book, AppColors.primaryColor),
//                   const SizedBox(height: AppConstants.padding * 2),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//                     },
//                     icon: const Icon(Icons.home),
//                     label: const Text('Back to Home'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.accentColor,
//                       foregroundColor: AppColors.cardColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                       ),
//                       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
//                       textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: AppConstants.mediumTextSize),
//                     ),
//                   ),
//                   const SizedBox(height: AppConstants.spacing),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.of(context).pushReplacementNamed(AppRouter.courseCreationRoute);
//                     },
//                     icon: const Icon(Icons.add_box),
//                     label: const Text('Create New Course'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.secondaryColor,
//                       foregroundColor: AppColors.textColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                       ),
//                       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
//                       textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: AppConstants.mediumTextSize),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatRow(BuildContext context, String label, String value, IconData icon, Color iconColor) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: iconColor, size: AppConstants.iconSize),
//               const SizedBox(width: AppConstants.spacing),
//               Text(
//                 label,
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColorSecondary, fontSize: AppConstants.mediumTextSize),
//               ),
//             ],
//           ),
//           Text(
//             value,
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   color: AppColors.textColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: AppConstants.mediumTextSize,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/screens/community_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/models/community_post.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:timeago/timeago.dart' as timeago; // For displaying time in a friendly format

// class CommunityScreen extends StatefulWidget {
//   const CommunityScreen({super.key});

//   @override
//   State<CommunityScreen> createState() => _CommunityScreenState();
// }

// class _CommunityScreenState extends State<CommunityScreen> {
//   final TextEditingController _postController = TextEditingController();
//   int _selectedIndex = 4; // Set the current index for Community screen

//   void _showSnackBar(String message, {bool isError = false}) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? AppColors.errorColor : AppColors.successColor,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   Future<void> _createPost() async {
//     final text = _postController.text.trim();
//     if (text.isEmpty) {
//       _showSnackBar('Post cannot be empty!', isError: true);
//       return;
//     }

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;
//     final userProfile = await firebaseService.getUserProfile(currentUser!.uid);

//     if (currentUser == null || userProfile == null) {
//       _showSnackBar('User not logged in or profile not found.', isError: true);
//       return;
//     }

//     try {
//       final postId = firebaseService.generateNewDocId();
//       final newPost = CommunityPost(
//         id: postId,
//         userId: currentUser.uid,
//         username: userProfile.username,
//         avatarAssetPath: userProfile.avatarAssetPath,
//         content: text,
//         timestamp: DateTime.now(),
//         likedBy: [],
//         comments: [],
//       );
//       await firebaseService.createCommunityPost(newPost);
//       _postController.clear();
//       _showSnackBar('Post created successfully!');
//     } catch (e) {
//       _showSnackBar('Error creating post: $e', isError: true);
//     }
//   }

//   Future<void> _toggleLike(String postId, List<String> likedBy) async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;
//     if (currentUser == null) {
//       _showSnackBar('Please log in to like posts.', isError: true);
//       return;
//     }
//     try {
//       await firebaseService.toggleLikeOnPost(postId, currentUser.uid);
//     } catch (e) {
//       _showSnackBar('Error toggling like: $e', isError: true);
//     }
//   }

//   Future<void> _addComment(String postId) async {
//     String? commentText;
//     await showDialog(
//       context: context,
//       builder: (context) {
//         final commentController = TextEditingController();
//         return AlertDialog(
//           title: const Text('Add a Comment'),
//           content: TextField(
//             controller: commentController,
//             decoration: const InputDecoration(hintText: 'Write your comment here...'),
//             maxLines: 3,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 commentText = commentController.text.trim();
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Post Comment'),
//             ),
//           ],
//         );
//       },
//     );

//     if (commentText != null && commentText!.isNotEmpty) {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       final currentUser = firebaseService.currentUser;
//       final userProfile = await firebaseService.getUserProfile(currentUser!.uid);

//       if (currentUser == null || userProfile == null) {
//         _showSnackBar('User not logged in or profile not found.', isError: true);
//         return;
//       }

//       try {
//         final newComment = Comment(
//           userId: currentUser.uid,
//           username: userProfile.username,
//           avatarAssetPath: userProfile.avatarAssetPath,
//           content: commentText!,
//           timestamp: DateTime.now(),
//         );
//         await firebaseService.addCommentToPost(postId, newComment);
//         _showSnackBar('Comment added!');
//       } catch (e) {
//         _showSnackBar('Error adding comment: $e', isError: true);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final firebaseService = Provider.of<FirebaseService>(context);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Community Feed',
//         leadingWidget: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(AppConstants.padding),
//               child: Card(
//                 color: AppColors.cardColor.withOpacity(0.9),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                 elevation: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(AppConstants.padding),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: _postController,
//                         style: const TextStyle(color: AppColors.textColor),
//                         decoration: InputDecoration(
//                           hintText: 'Share your thoughts or achievements...',
//                           hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.7)),
//                           filled: true,
//                           fillColor: AppColors.primaryColor.withOpacity(0.1),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         maxLines: 3,
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       Align(
//                         alignment: Alignment.bottomRight,
//                         child: ElevatedButton.icon(
//                           onPressed: _createPost,
//                           icon: const Icon(Icons.send),
//                           label: const Text('Post'),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.accentColor,
//                             foregroundColor: AppColors.cardColor,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: StreamBuilder<List<CommunityPost>>(
//                 stream: firebaseService.streamCommunityPosts(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                         child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
//                   }
//                   if (snapshot.hasError) {
//                     return Center(
//                         child: Text('Error loading posts: ${snapshot.error}',
//                             style: const TextStyle(color: AppColors.errorColor)));
//                   }
//                   if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(
//                         child: Text(
//                       'No posts yet. Be the first to share something!',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColorSecondary),
//                       textAlign: TextAlign.center,
//                     ));
//                   }

//                   final posts = snapshot.data!;
//                   return ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
//                     itemCount: posts.length,
//                     itemBuilder: (context, index) {
//                       final post = posts[index];
//                       final bool isLikedByMe = post.likedBy.contains(currentUser.uid);

//                       return Card(
//                         margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//                         color: AppColors.cardColor.withOpacity(0.9),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                         elevation: 4,
//                         child: Padding(
//                           padding: const EdgeInsets.all(AppConstants.padding),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 20,
//                                     backgroundImage: AssetImage(post.avatarAssetPath),
//                                     onBackgroundImageError: (exception, stackTrace) {
//                                       debugPrint('Error loading post avatar: $exception');
//                                     },
//                                   ),
//                                   const SizedBox(width: AppConstants.spacing),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           post.username,
//                                           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                                                 color: AppColors.textColor,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                         ),
//                                         Text(
//                                           timeago.format(post.timestamp),
//                                           style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                                                 color: AppColors.textColorSecondary,
//                                               ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: AppConstants.spacing),
//                               Text(
//                                 post.content,
//                                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColor),
//                               ),
//                               const SizedBox(height: AppConstants.spacing),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       IconButton(
//                                         icon: Icon(
//                                           isLikedByMe ? Icons.favorite : Icons.favorite_border,
//                                           color: isLikedByMe ? AppColors.errorColor : AppColors.textColorSecondary,
//                                         ),
//                                         onPressed: () => _toggleLike(post.id, post.likedBy),
//                                       ),
//                                       Text(
//                                         '${post.likedBy.length}',
//                                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
//                                       ),
//                                       const SizedBox(width: AppConstants.spacing),
//                                       IconButton(
//                                         icon: const Icon(Icons.comment_outlined, color: AppColors.textColorSecondary),
//                                         onPressed: () => _addComment(post.id),
//                                       ),
//                                       Text(
//                                         '${post.comments.length}',
//                                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               // Display comments
//                               if (post.comments.isNotEmpty)
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: post.comments.map((comment) {
//                                     return Padding(
//                                       padding: const EdgeInsets.only(left: AppConstants.padding, top: AppConstants.spacing / 2),
//                                       child: Row(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           CircleAvatar(
//                                             radius: 12,
//                                             backgroundImage: AssetImage(comment.avatarAssetPath),
//                                             onBackgroundImageError: (exception, stackTrace) {
//                                               debugPrint('Error loading comment avatar: $exception');
//                                             },
//                                           ),
//                                           const SizedBox(width: AppConstants.spacing / 2),
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   '${comment.username} • ${timeago.format(comment.timestamp)}',
//                                                   style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                                                         color: AppColors.textColorSecondary.withOpacity(0.8),
//                                                         fontWeight: FontWeight.bold,
//                                                       ),
//                                                 ),
//                                                 Text(
//                                                   comment.content,
//                                                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//           switch (index) {
//             case 0:
//               Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//               break;
//             case 1:
//               Navigator.of(context).pushReplacementNamed(AppRouter.courseCreationRoute);
//               break;
//             case 2:
//               Navigator.of(context).pushReplacementNamed(AppRouter.progressRoute);
//               break;
//             case 3:
//               Navigator.of(context).pushReplacementNamed(AppRouter.profileRoute);
//               break;
//             case 4:
//             // Already on community screen
//               break;
//             case 5:
//               Navigator.of(context).pushReplacementNamed(AppRouter.aiChatRoute);
//               break;
//           }
//         },
//       ),
//     );
//   }
// }
// // lib/screens/avatar_customizer_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/models/avatar_asset.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';

// class AvatarCustomizerScreen extends StatefulWidget {
//   const AvatarCustomizerScreen({super.key});

//   @override
//   State<AvatarCustomizerScreen> createState() => _AvatarCustomizerScreenState();
// }

// class _AvatarCustomizerScreenState extends State<AvatarCustomizerScreen> {
//   String? _selectedAvatarPath;
//   UserProfile? _currentUserProfile;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final user = firebaseService.currentUser;
//     if (user != null) {
//       final profile = await firebaseService.getUserProfile(user.uid);
//       if (profile != null) {
//         setState(() {
//           _currentUserProfile = profile;
//           _selectedAvatarPath = profile.avatarAssetPath;
//         });
//       }
//     }
//   }

//   Future<void> _updateAvatar() async {
//     if (_selectedAvatarPath == null || _currentUserProfile == null) return;

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final user = firebaseService.currentUser;

//     if (user != null) {
//       try {
//         await firebaseService.updateUserProfile(user.uid, {
//           'avatarAssetPath': _selectedAvatarPath,
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Avatar updated successfully!'),
//             backgroundColor: AppColors.successColor,
//           ),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error updating avatar: $e'),
//             backgroundColor: AppColors.errorColor,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Customize Avatar',
//         leadingWidget: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         trailingWidget: IconButton(
//           icon: const Icon(Icons.save, color: AppColors.textColor),
//           onPressed: _updateAvatar,
//           tooltip: 'Save Avatar',
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(AppConstants.padding),
//               child: Center(
//                 child: CircleAvatar(
//                   radius: AppConstants.avatarSize * 1.5,
//                   backgroundColor: AppColors.cardColor,
//                   backgroundImage: _selectedAvatarPath != null
//                       ? AssetImage(_selectedAvatarPath!)
//                       : (_currentUserProfile != null
//                           ? AssetImage(_currentUserProfile!.avatarAssetPath)
//                           : null),
//                   onBackgroundImageError: (exception, stackTrace) {
//                     debugPrint('Error loading selected avatar image: $exception');
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: AppConstants.padding),
//             Text(
//               'Choose your avatar:',
//               style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                     color: AppColors.textColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(height: AppConstants.padding),
//             Expanded(
//               child: GridView.builder(
//                 padding: const EdgeInsets.all(AppConstants.padding),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: AppConstants.spacing,
//                   mainAxisSpacing: AppConstants.spacing,
//                   childAspectRatio: 0.8,
//                 ),
//                 itemCount: AppConstants.defaultAvatarAssets.length,
//                 itemBuilder: (context, index) {
//                   final avatarAsset = AppConstants.defaultAvatarAssets[index];
//                   final isSelected = _selectedAvatarPath == avatarAsset.assetPath;
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _selectedAvatarPath = avatarAsset.assetPath;
//                       });
//                     },
//                     child: Card(
//                       color: isSelected ? AppColors.accentColor.withOpacity(0.8) : AppColors.cardColor.withOpacity(0.8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                         side: BorderSide(
//                           color: isSelected ? AppColors.successColor : Colors.transparent,
//                           width: 3,
//                         ),
//                       ),
//                       elevation: isSelected ? 8 : 4,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             avatarAsset.assetPath,
//                             width: AppConstants.avatarSize,
//                             height: AppConstants.avatarSize,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Icon(Icons.person, size: AppConstants.avatarSize, color: AppColors.errorColor);
//                             },
//                           ),
//                           const SizedBox(height: AppConstants.spacing / 2),
//                           Text(
//                             avatarAsset.name,
//                             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                   color: isSelected ? AppColors.cardColor : AppColors.textColor,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // lib/screens/auth_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/utils/validation_utils.dart'; // Import for validation

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();

//   bool _isLogin = true;
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _usernameController.dispose();
//     super.dispose();
//   }

//   void _showSnackBar(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? AppColors.errorColor : AppColors.successColor,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   Future<void> _submitAuthForm() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       if (_isLogin) {
//         if (!_loginFormKey.currentState!.validate()) {
//           setState(() {
//             _isLoading = false;
//           });
//           return;
//         }
//         await firebaseService.signInWithEmailAndPassword(
//           _emailController.text.trim(),
//           _passwordController.text.trim(),
//         );
//         _showSnackBar('Logged in successfully!');
//         // Check if onboarding is needed
//         final userProfile = await firebaseService.getUserProfile(firebaseService.currentUser!.uid);
//         if (userProfile == null || userProfile.educationLevel == null || userProfile.specialty == null) {
//           Navigator.of(context).pushReplacementNamed(AppRouter.onboardingRoute);
//         } else {
//           Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//         }
//       } else {
//         if (!_registerFormKey.currentState!.validate()) {
//           setState(() {
//             _isLoading = false;
//           });
//           return;
//         }
//         await firebaseService.registerWithEmailAndPassword(
//           _emailController.text.trim(),
//           _passwordController.text.trim(),
//           _usernameController.text.trim(),
//         );
//         _showSnackBar('Registered successfully! Please complete your profile.');
//         Navigator.of(context).pushReplacementNamed(AppRouter.onboardingRoute);
//       }
//     } on FirebaseAuthException catch (e) {
//       _showSnackBar(e.message ?? 'An authentication error occurred.', isError: true);
//     } catch (e) {
//       _showSnackBar('An unexpected error occurred: $e', isError: true);
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(AppConstants.padding * 2),
//             child: Card(
//               color: AppColors.cardColor.withOpacity(0.95),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
//               ),
//               elevation: 12,
//               child: Padding(
//                 padding: const EdgeInsets.all(AppConstants.padding * 2),
//                 child: Form(
//                   key: _isLogin ? _loginFormKey : _registerFormKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         _isLogin ? 'Welcome Back!' : 'Join Gamifier',
//                         style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                               color: AppColors.accentColor,
//                               fontWeight: FontWeight.bold,
//                               // Replace neonTextStyle with a standard style
//                               shadows: [
//                                 Shadow(
//                                   blurRadius: 10.0,
//                                   color: AppColors.accentColor.withOpacity(0.5),
//                                   offset: const Offset(0, 0),
//                                 ),
//                               ],
//                             ),
//                       ),
//                       const SizedBox(height: AppConstants.padding * 1.5),
//                       TextFormField(
//                         controller: _emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: const InputDecoration(
//                           labelText: 'Email',
//                           prefixIcon: Icon(Icons.email, color: AppColors.textColorSecondary),
//                         ),
//                         style: const TextStyle(color: AppColors.textColor),
//                         validator: ValidationUtils.validateEmail,
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       TextFormField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           labelText: 'Password',
//                           prefixIcon: Icon(Icons.lock, color: AppColors.textColorSecondary),
//                         ),
//                         style: const TextStyle(color: AppColors.textColor),
//                         validator: (value) => ValidationUtils.validatePassword(value, minLength: AppConstants.minPasswordLength),
//                       ),
//                       if (!_isLogin) ...[
//                         const SizedBox(height: AppConstants.spacing),
//                         TextFormField(
//                           controller: _confirmPasswordController,
//                           obscureText: true,
//                           decoration: const InputDecoration(
//                             labelText: 'Confirm Password',
//                             prefixIcon: Icon(Icons.lock_reset, color: AppColors.textColorSecondary),
//                           ),
//                           style: const TextStyle(color: AppColors.textColor),
//                           validator: (value) => ValidationUtils.validateConfirmPassword(_passwordController.text, value),
//                         ),
//                         const SizedBox(height: AppConstants.spacing),
//                         TextFormField(
//                           controller: _usernameController,
//                           decoration: const InputDecoration(
//                             labelText: 'Username',
//                             prefixIcon: Icon(Icons.person, color: AppColors.textColorSecondary),
//                           ),
//                           style: const TextStyle(color: AppColors.textColor),
//                           validator: (value) => ValidationUtils.validateNotEmpty(value, 'Username cannot be empty'),
//                         ),
//                       ],
//                       const SizedBox(height: AppConstants.padding * 1.5),
//                       _isLoading
//                           ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor))
//                           : ElevatedButton(
//                               onPressed: _submitAuthForm,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColors.accentColor,
//                                 foregroundColor: AppColors.cardColor,
//                                 padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
//                                 textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                                 elevation: 8,
//                               ),
//                               child: Text(_isLogin ? 'Sign In' : 'Register'),
//                             ),
//                       const SizedBox(height: AppConstants.padding),
//                       TextButton(
//                         onPressed: () {
//                           setState(() {
//                             _isLogin = !_isLogin;
//                             _emailController.clear();
//                             _passwordController.clear();
//                             _confirmPasswordController.clear();
//                             _usernameController.clear();
//                           });
//                         },
//                         child: Text(
//                           _isLogin ? 'Need an account? Register' : 'Already have an account? Sign In',
//                           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                                 color: AppColors.textColorSecondary,
//                               ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/navigation/bottom_nav_bar.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class BottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemTapped;

//   const BottomNavBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.cardColor,
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.cardColor.withOpacity(0.5),
//             blurRadius: 10,
//             spreadRadius: 2,
//             offset: const Offset(0, -2),
//           ),
//         ],
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.borderRadius)),
//       ),
//       child: BottomNavigationBar(
//         currentIndex: selectedIndex,
//         onTap: onItemTapped,
//         backgroundColor: Colors.transparent,
//         selectedItemColor: AppColors.accentColor,
//         unselectedItemColor: AppColors.textColorSecondary,
//         type: BottomNavigationBarType.fixed,
//         selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
//         unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
//         showUnselectedLabels: true,
//         elevation: 0,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_box),
//             label: 'Create',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.leaderboard),
//             label: 'Progress',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people), // New icon for Community
//             label: 'Community',
//           ),
//           BottomNavigationBarItem( // New AI Chatbot entry
//             icon: Icon(Icons.auto_awesome),
//             label: 'AI Tutor',
//           ),
//         ],
//       ),
//     );
//   }
// }

// // lib/screens/ai_chat_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart'; // No alias, directly import
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/gemini_api_service.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/loading_indicator.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:gamifier/utils/app_router.dart';

// class AIChatScreen extends StatefulWidget {
//   const AIChatScreen({super.key});

//   @override
//   State<AIChatScreen> createState() => _AIChatScreenState();
// }

// class _AIChatScreenState extends State<AIChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final List<Map<String, String>> _chatHistory = [];
//   bool _isLoading = false;
//   int _selectedIndex = 5; // Set the current index for AI Chat screen

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }

//   void _showSnackBar(String message, {bool isError = false}) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? AppColors.errorColor : AppColors.successColor,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   Future<void> _sendMessage() async {
//     final message = _messageController.text.trim();
//     if (message.isEmpty) {
//       _showSnackBar('Message cannot be empty!', isError: true);
//       return;
//     }

//     setState(() {
//       _chatHistory.add({'role': 'user', 'text': message});
//       _messageController.clear();
//       _isLoading = true;
//     });

//     final geminiApiService = Provider.of<GeminiApiService>(context, listen: false);

//     try {
//       final response = await geminiApiService.generateAIChatResponse(_chatHistory);
//       setState(() {
//         _chatHistory.add({'role': 'model', 'text': response});
//       });
//     } catch (e) {
//       _showSnackBar('Error generating response: $e', isError: true);
//       debugPrint('AI Chat Error: $e');
//       setState(() {
//         _chatHistory.add({'role': 'model', 'text': 'Error: Could not get a response.'});
//       });
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'AI Tutor Chat',
//         leadingWidget: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.all(AppConstants.padding),
//                 reverse: false, // Messages flow from top to bottom
//                 itemCount: _chatHistory.length,
//                 itemBuilder: (context, index) {
//                   final message = _chatHistory[index];
//                   final isUser = message['role'] == 'user';
//                   return Align(
//                     alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                     child: Container(
//                       margin: EdgeInsets.only(
//                         bottom: AppConstants.spacing,
//                         left: isUser ? AppConstants.padding * 4 : 0, // Less padding on user side for compactness
//                         right: isUser ? 0 : AppConstants.padding * 4, // Less padding on AI side for compactness
//                       ),
//                       padding: const EdgeInsets.all(AppConstants.spacing * 1.5),
//                       decoration: BoxDecoration(
//                         color: isUser ? AppColors.accentColor.withOpacity(0.9) : AppColors.cardColor.withOpacity(0.9),
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(AppConstants.borderRadius),
//                           topRight: Radius.circular(AppConstants.borderRadius),
//                           bottomLeft: Radius.circular(isUser ? AppConstants.borderRadius : 0),
//                           bottomRight: Radius.circular(isUser ? 0 : AppConstants.borderRadius),
//                         ),
//                       ),
//                       child: isUser
//                           ? Text(
//                               message['text']!,
//                               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                     color: isUser ? AppColors.cardColor : AppColors.textColor,
//                                     fontSize: AppConstants.mediumTextSize, // Small text size
//                                   ),
//                             )
//                           : MarkdownBody( // Directly use MarkdownBody
//                               data: message['text']!,
//                               styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith( // Directly use MarkdownStyleSheet
//                                 p: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                                 strong: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                                 em: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic, color: AppColors.textColorSecondary, fontSize: AppConstants.mediumTextSize),
//                                 code: TextStyle(
//                                   backgroundColor: AppColors.primaryColor.withOpacity(0.2),
//                                   color: AppColors.accentColor,
//                                   fontFamily: 'monospace',
//                                   fontSize: AppConstants.smallTextSize,
//                                 ),
//                                 codeblockDecoration: BoxDecoration(
//                                   color: AppColors.primaryColor.withOpacity(0.2),
//                                   borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
//                                   border: Border.all(color: AppColors.borderColor, width: 1),
//                                 ),
//                                 blockquoteDecoration: BoxDecoration(
//                                   color: AppColors.cardColor.withOpacity(0.5),
//                                   border: Border(left: BorderSide(color: AppColors.borderColor, width: 4)),
//                                   borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
//                                 ),
//                               ),
                              
//                               styleSheetTheme: MarkdownStyleSheetBaseTheme.material, // Directly use MarkdownStyleSheetBaseTheme
//                             ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             if (_isLoading)
//               const Padding(
//                 padding: EdgeInsets.all(AppConstants.padding),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor), strokeWidth: 2),
//                     SizedBox(width: AppConstants.spacing),
//                     Text('AI is typing...', style: TextStyle(color: AppColors.textColorSecondary, fontSize: AppConstants.smallTextSize)),
//                   ],
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.all(AppConstants.padding),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       style: const TextStyle(color: AppColors.textColor, fontSize: AppConstants.mediumTextSize),
//                       decoration: InputDecoration(
//                         hintText: 'Ask your AI tutor...',
//                         hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.7), fontSize: AppConstants.mediumTextSize),
//                         filled: true,
//                         fillColor: AppColors.cardColor.withOpacity(0.9),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
//                       ),
//                       onSubmitted: (value) => _sendMessage(),
//                     ),
//                   ),
//                   const SizedBox(width: AppConstants.spacing),
//                   FloatingActionButton(
//                     onPressed: _isLoading ? null : _sendMessage,
//                     backgroundColor: AppColors.accentColor,
//                     foregroundColor: AppColors.cardColor,
//                     mini: true,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(AppConstants.borderRadius), // Apply rounded corners
//                     ),
//                     child: _isLoading
//                         ? const SizedBox(
//                             width: AppConstants.iconSize * 0.8,
//                             height: AppConstants.iconSize * 0.8,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(AppColors.cardColor),
//                             ),
//                           )
//                         : const Icon(Icons.send),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//           switch (index) {
//             case 0:
//               Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//               break;
//             case 1:
//               Navigator.of(context).pushReplacementNamed(AppRouter.courseCreationRoute);
//               break;
//             case 2:
//               Navigator.of(context).pushReplacementNamed(AppRouter.progressRoute);
//               break;
//             case 3:
//               Navigator.of(context).pushReplacementNamed(AppRouter.profileRoute);
//               break;
//             case 4:
//               Navigator.of(context).pushReplacementNamed(AppRouter.communityRoute);
//               break;
//             case 5:
//               break;
//           }
//         },
//       ),
//     );
//   }
// }
// // lib/models/user_progress.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

// @immutable
// class LessonProgress {
//   final String lessonId;
//   final List<String> completedQuestions; // IDs of questions answered correctly
//   final Map<String, int> attempts; // <QuestionId, numAttempts>
//   bool isCompleted; // Whether all questions in this lesson are completed

//   LessonProgress({
//     required this.lessonId,
//     this.completedQuestions = const [],
//     Map<String, int>? attempts,
//     this.isCompleted = false,
//   }) : attempts = attempts ?? {};

//   factory LessonProgress.fromMap(Map<String, dynamic> map) {
//     return LessonProgress(
//       lessonId: map['lessonId'] as String,
//       completedQuestions: List<String>.from(map['completedQuestions'] ?? []),
//       attempts: Map<String, int>.from(
//           (map['attempts'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, value as int)) ?? {}),
//       isCompleted: map['isCompleted'] as bool? ?? false,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'lessonId': lessonId,
//       'completedQuestions': completedQuestions,
//       'attempts': attempts,
//       'isCompleted': isCompleted,
//     };
//   }

//   LessonProgress copyWith({
//     String? lessonId,
//     List<String>? completedQuestions,
//     Map<String, int>? attempts,
//     bool? isCompleted,
//   }) {
//     return LessonProgress(
//       lessonId: lessonId ?? this.lessonId,
//       completedQuestions: completedQuestions ?? this.completedQuestions,
//       attempts: attempts ?? this.attempts,
//       isCompleted: isCompleted ?? this.isCompleted,
//     );
//   }

//   @override
//   String toString() {
//     return 'LessonProgress(lessonId: $lessonId, completedQuestions: $completedQuestions, attempts: $attempts, isCompleted: $isCompleted)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is LessonProgress &&
//           runtimeType == other.runtimeType &&
//           lessonId == other.lessonId &&
//           listEquals(completedQuestions, other.completedQuestions) &&
//           mapEquals(attempts, other.attempts) &&
//           isCompleted == other.isCompleted;

//   @override
//   int get hashCode =>
//       lessonId.hashCode ^
//       listEquals(completedQuestions, completedQuestions).hashCode ^
//       mapEquals(attempts, attempts).hashCode ^
//       isCompleted.hashCode;
// }

// @immutable
// class UserProgress {
//   final String id; // userId_courseId
//   final String userId;
//   final String courseId;
//   String? currentLevelId; // The ID of the current level the user is on
//   String? currentLessonId; // The ID of the current lesson the user is on
//   final List<String> levelsCompleted; // IDs of levels completed in this course
//   final Map<String, LessonProgress> lessonsProgress; // <LessonId, LessonProgress>
//   final int totalXpEarned; // New: Total XP earned specifically for this course

//   UserProgress({
//     required this.id,
//     required this.userId,
//     required this.courseId,
//     this.currentLevelId,
//     this.currentLessonId,
//     this.levelsCompleted = const [],
//     Map<String, LessonProgress>? lessonsProgress,
//     this.totalXpEarned = 0, // Initialize totalXpEarned
//   }) : lessonsProgress = lessonsProgress ?? const {};

//   factory UserProgress.fromMap(Map<String, dynamic> map) {
//     return UserProgress(
//       id: map['id'] as String,
//       userId: map['userId'] as String,
//       courseId: map['courseId'] as String,
//       currentLevelId: map['currentLevelId'] as String?,
//       currentLessonId: map['currentLessonId'] as String?,
//       levelsCompleted: List<String>.from(map['levelsCompleted'] ?? []),
//       lessonsProgress: (map['lessonsProgress'] as Map<String, dynamic>?)
//               ?.map((key, value) => MapEntry(key, LessonProgress.fromMap(value as Map<String, dynamic>))) ??
//           {},
//       totalXpEarned: map['totalXpEarned'] as int? ?? 0, // Read from map
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'userId': userId,
//       'courseId': courseId,
//       'currentLevelId': currentLevelId,
//       'currentLessonId': currentLessonId,
//       'levelsCompleted': levelsCompleted,
//       'lessonsProgress': lessonsProgress.map((key, value) => MapEntry(key, value.toMap())),
//       'totalXpEarned': totalXpEarned, // Write to map
//     };
//   }

//   UserProgress copyWith({
//     String? id,
//     String? userId,
//     String? courseId,
//     String? currentLevelId,
//     String? currentLessonId,
//     List<String>? levelsCompleted,
//     Map<String, LessonProgress>? lessonsProgress,
//     int? totalXpEarned, // Add to copyWith
//   }) {
//     return UserProgress(
//       id: id ?? this.id,
//       userId: userId ?? this.userId,
//       courseId: courseId ?? this.courseId,
//       currentLevelId: currentLevelId ?? this.currentLevelId,
//       currentLessonId: currentLessonId ?? this.currentLessonId,
//       levelsCompleted: levelsCompleted ?? this.levelsCompleted,
//       lessonsProgress: lessonsProgress ?? this.lessonsProgress,
//       totalXpEarned: totalXpEarned ?? this.totalXpEarned, // Assign in copyWith
//     );
//   }

//   @override
//   String toString() {
//     return 'UserProgress(id: $id, userId: $userId, courseId: $courseId, currentLevelId: $currentLevelId, currentLessonId: $currentLessonId, levelsCompleted: $levelsCompleted, lessonsProgress: $lessonsProgress, totalXpEarned: $totalXpEarned)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is UserProgress &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           userId == other.userId &&
//           courseId == other.courseId &&
//           currentLevelId == other.currentLevelId &&
//           currentLessonId == other.currentLessonId &&
//           listEquals(levelsCompleted, other.levelsCompleted) &&
//           mapEquals(lessonsProgress, other.lessonsProgress) &&
//           totalXpEarned == other.totalXpEarned;

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       userId.hashCode ^
//       courseId.hashCode ^
//       (currentLevelId?.hashCode ?? 0) ^
//       (currentLessonId?.hashCode ?? 0) ^
//       listEquals(levelsCompleted, levelsCompleted).hashCode ^
//       mapEquals(lessonsProgress, lessonsProgress).hashCode ^
//       totalXpEarned.hashCode;
// }
// // lib/models/user_profile.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/avatar_asset.dart';

// @immutable
// class UserProfile {
//   final String uid;
//   final String username;
//   final int xp;
//   final int level;
//   final String avatarAssetPath;
//   final List<String> earnedBadges;
//   final DateTime createdAt;
//   final String? educationLevel;
//   final String? specialty;
//   final List<String> friends; // New: List of friend UIDs
//   final int currentStreak; // New: Number of consecutive days logged in/lesson completed
//   final DateTime? lastStreakUpdate; // New: Last time streak was updated

//   UserProfile({
//     required this.uid,
//     required this.username,
//     this.xp = AppConstants.initialXp,
//     this.level = 1,
//     String? avatarAssetPath,
//     this.earnedBadges = const [],
//     required this.createdAt,
//     this.educationLevel,
//     this.specialty,
//     this.friends = const [],
//     this.currentStreak = AppConstants.initialStreak, // Initialize with new constant
//     this.lastStreakUpdate,
//   }) : this.avatarAssetPath = avatarAssetPath ??
//             (AppConstants.defaultAvatarAssets.isNotEmpty
//                 ? AppConstants.defaultAvatarAssets.first.assetPath
//                 : 'assets/avatars/default.png');

//   factory UserProfile.fromMap(Map<String, dynamic> map) {
//     return UserProfile(
//       uid: map['uid'] as String,
//       username: map['username'] as String,
//       xp: (map['xp'] ?? AppConstants.initialXp) as int,
//       level: (map['level'] ?? 1) as int,
//       avatarAssetPath: (map['avatarAssetPath'] ??
//           (AppConstants.defaultAvatarAssets.isNotEmpty
//               ? AppConstants.defaultAvatarAssets.first.assetPath
//               : 'assets/avatars/default.png')) as String,
//       earnedBadges: List<String>.from(map['earnedBadges'] ?? []),
//       createdAt: (map['createdAt'] as Timestamp).toDate(),
//       educationLevel: map['educationLevel'] as String?,
//       specialty: map['specialty'] as String?,
//       friends: List<String>.from(map['friends'] ?? []),
//       currentStreak: (map['currentStreak'] ?? AppConstants.initialStreak) as int,
//       lastStreakUpdate: (map['lastStreakUpdate'] as Timestamp?)?.toDate(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'username': username,
//       'xp': xp,
//       'level': level,
//       'avatarAssetPath': avatarAssetPath,
//       'earnedBadges': earnedBadges,
//       'createdAt': Timestamp.fromDate(createdAt),
//       'educationLevel': educationLevel,
//       'specialty': specialty,
//       'friends': friends,
//       'currentStreak': currentStreak,
//       'lastStreakUpdate': lastStreakUpdate != null ? Timestamp.fromDate(lastStreakUpdate!) : null,
//     };
//   }

//   UserProfile copyWith({
//     String? uid,
//     String? username,
//     int? xp,
//     int? level,
//     String? avatarAssetPath,
//     List<String>? earnedBadges,
//     DateTime? createdAt,
//     String? educationLevel,
//     String? specialty,
//     List<String>? friends,
//     int? currentStreak,
//     DateTime? lastStreakUpdate,
//   }) {
//     return UserProfile(
//       uid: uid ?? this.uid,
//       username: username ?? this.username,
//       xp: xp ?? this.xp,
//       level: level ?? this.level,
//       avatarAssetPath: avatarAssetPath ?? this.avatarAssetPath,
//       earnedBadges: earnedBadges ?? this.earnedBadges,
//       createdAt: createdAt ?? this.createdAt,
//       educationLevel: educationLevel ?? this.educationLevel,
//       specialty: specialty ?? this.specialty,
//       friends: friends ?? this.friends,
//       currentStreak: currentStreak ?? this.currentStreak,
//       lastStreakUpdate: lastStreakUpdate ?? this.lastStreakUpdate,
//     );
//   }

//   @override
//   String toString() {
//     return 'UserProfile(uid: $uid, username: $username, xp: $xp, level: $level, avatarAssetPath: $avatarAssetPath, earnedBadges: $earnedBadges, createdAt: $createdAt, educationLevel: $educationLevel, specialty: $specialty, friends: $friends, currentStreak: $currentStreak, lastStreakUpdate: $lastStreakUpdate)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is UserProfile &&
//           runtimeType == other.runtimeType &&
//           uid == other.uid &&
//           username == other.username &&
//           xp == other.xp &&
//           level == other.level &&
//           avatarAssetPath == other.avatarAssetPath &&
//           listEquals(earnedBadges, other.earnedBadges) &&
//           createdAt == other.createdAt &&
//           educationLevel == other.educationLevel &&
//           specialty == other.specialty &&
//           listEquals(friends, other.friends) &&
//           currentStreak == other.currentStreak &&
//           lastStreakUpdate == other.lastStreakUpdate;

//   @override
//   int get hashCode =>
//       uid.hashCode ^
//       username.hashCode ^
//       xp.hashCode ^
//       level.hashCode ^
//       avatarAssetPath.hashCode ^
//       listEquals(earnedBadges, earnedBadges).hashCode ^
//       createdAt.hashCode ^
//       educationLevel.hashCode ^
//       specialty.hashCode ^
//       listEquals(friends, friends).hashCode ^
//       currentStreak.hashCode ^
//       lastStreakUpdate.hashCode;
// }
// // lib/models/question.dart
// import 'package:flutter/foundation.dart';

// enum QuestionType {
//   mcq,
//   fillInBlank,
//   shortAnswer,
//   scenario,
// }

// @immutable
// class Question {
//   final String id;
//   final String questionText;
//   final int xpReward;
//   final QuestionType type;
//   final List<String> options; // For MCQ
//   final dynamic correctAnswer; // For MCQ and FillInBlank, can be String or other types
//   final String? expectedAnswerKeywords; // For ShortAnswer, comma-separated
//   final String? scenarioText; // For Scenario
//   final String? expectedOutcome; // For Scenario

//   const Question({
//     required this.id,
//     required this.questionText,
//     required this.xpReward,
//     required this.type,
//     this.options = const [],
//     this.correctAnswer,
//     this.expectedAnswerKeywords,
//     this.scenarioText,
//     this.expectedOutcome,
//   });

//   factory Question.fromMap(Map<String, dynamic> map) {
//     return Question(
//       id: map['id'] as String,
//       questionText: map['questionText'] as String,
//       xpReward: map['xpReward'] as int,
//       type: QuestionType.values.firstWhere(
//             (e) => e.toString().split('.').last == map['type'],
//         orElse: () => QuestionType.shortAnswer, // Default or handle error
//       ),
//       options: List<String>.from(map['options'] ?? []),
//       correctAnswer: map['correctAnswer'], // Assign directly, it's dynamic
//       expectedAnswerKeywords: map['expectedAnswerKeywords'] as String?,
//       scenarioText: map['scenarioText'] as String?,
//       expectedOutcome: map['expectedOutcome'] as String?,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     final map = <String, dynamic>{ // Explicitly type the map as <String, dynamic>
//       'id': id,
//       'questionText': questionText,
//       'xpReward': xpReward,
//       'type': type.toString().split('.').last, // Convert enum to string
//     };

//     // Add type-specific fields
//     if (type == QuestionType.mcq) {
//       map['options'] = options;
//       map['correctAnswer'] = correctAnswer;
//     } else if (type == QuestionType.fillInBlank) {
//       map['correctAnswer'] = correctAnswer;
//     } else if (type == QuestionType.shortAnswer) {
//       map['expectedAnswerKeywords'] = expectedAnswerKeywords;
//     } else if (type == QuestionType.scenario) {
//       map['scenarioText'] = scenarioText;
//       map['expectedOutcome'] = expectedOutcome;
//     }
//     return map;
//   }

//   Question copyWith({
//     String? id,
//     String? questionText,
//     int? xpReward,
//     QuestionType? type,
//     List<String>? options,
//     dynamic correctAnswer,
//     String? expectedAnswerKeywords,
//     String? scenarioText,
//     String? expectedOutcome,
//   }) {
//     return Question(
//       id: id ?? this.id,
//       questionText: questionText ?? this.questionText,
//       xpReward: xpReward ?? this.xpReward,
//       type: type ?? this.type,
//       options: options ?? this.options,
//       correctAnswer: correctAnswer ?? this.correctAnswer,
//       expectedAnswerKeywords: expectedAnswerKeywords ?? this.expectedAnswerKeywords,
//       scenarioText: scenarioText ?? this.scenarioText,
//       expectedOutcome: expectedOutcome ?? this.expectedOutcome,
//     );
//   }

//   @override
//   String toString() {
//     return 'Question(id: $id, questionText: $questionText, xpReward: $xpReward, type: $type, options: $options, correctAnswer: $correctAnswer, expectedAnswerKeywords: $expectedAnswerKeywords, scenarioText: $scenarioText, expectedOutcome: $expectedOutcome)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Question &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           questionText == other.questionText &&
//           xpReward == other.xpReward &&
//           type == other.type &&
//           listEquals(options, other.options) &&
//           correctAnswer == other.correctAnswer &&
//           expectedAnswerKeywords == other.expectedAnswerKeywords &&
//           scenarioText == other.scenarioText &&
//           expectedOutcome == other.expectedOutcome;

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       questionText.hashCode ^
//       xpReward.hashCode ^
//       type.hashCode ^
//       listEquals(options, options).hashCode ^
//       (correctAnswer?.hashCode ?? 0) ^ // Handle dynamic/nullable correctAnswer
//       (expectedAnswerKeywords?.hashCode ?? 0) ^
//       (scenarioText?.hashCode ?? 0) ^
//       (expectedOutcome?.hashCode ?? 0);
// }
// // lib/models/level.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:gamifier/models/lesson.dart'; // Import Lesson if you embed it directly, otherwise not needed.

// @immutable
// class Level {
//   final String id;
//   final String courseId;
//   final String title;
//   final String description;
//   final String difficulty;
//   final int order; // To define the sequence of levels in a course
//   final List<String> lessonIds; // List of lesson IDs belonging to this level
//   final String? imageAssetPath; // Path to a local asset image for this level's icon/visual

//   const Level({
//     required this.id,
//     required this.courseId,
//     required this.title,
//     required this.description,
//     required this.difficulty,
//     required this.order,
//     this.lessonIds = const [],
//     this.imageAssetPath, // New field
//   });

//   factory Level.fromMap(Map<String, dynamic> map) {
//     return Level(
//       id: map['id'] as String,
//       courseId: map['courseId'] as String,
//       title: map['title'] as String,
//       description: map['description'] as String,
//       difficulty: map['difficulty'] as String,
//       order: map['order'] as int,
//       lessonIds: List<String>.from(map['lessonIds'] ?? []),
//       imageAssetPath: map['imageAssetPath'] as String?, // Read new field
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'courseId': courseId,
//       'title': title,
//       'description': description,
//       'difficulty': difficulty,
//       'order': order,
//       'lessonIds': lessonIds,
//       'imageAssetPath': imageAssetPath, // Write new field
//     };
//   }

//   Level copyWith({
//     String? id,
//     String? courseId,
//     String? title,
//     String? description,
//     String? difficulty,
//     int? order,
//     List<String>? lessonIds,
//     String? imageAssetPath,
//   }) {
//     return Level(
//       id: id ?? this.id,
//       courseId: courseId ?? this.courseId,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       difficulty: difficulty ?? this.difficulty,
//       order: order ?? this.order,
//       lessonIds: lessonIds ?? this.lessonIds,
//       imageAssetPath: imageAssetPath ?? this.imageAssetPath,
//     );
//   }

//   @override
//   String toString() {
//     return 'Level(id: $id, courseId: $courseId, title: $title, description: $description, difficulty: $difficulty, order: $order, lessonIds: $lessonIds, imageAssetPath: $imageAssetPath)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Level &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           courseId == other.courseId &&
//           title == other.title &&
//           description == other.description &&
//           difficulty == other.difficulty &&
//           order == other.order &&
//           listEquals(lessonIds, other.lessonIds) &&
//           imageAssetPath == other.imageAssetPath;

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       courseId.hashCode ^
//       title.hashCode ^
//       description.hashCode ^
//       difficulty.hashCode ^
//       order.hashCode ^
//       listEquals(lessonIds, lessonIds).hashCode ^
//       imageAssetPath.hashCode;
// }
// // lib/models/lesson.dart
// import 'package:flutter/foundation.dart';

// @immutable
// class Lesson {
//   final String id;
//   final String title;
//   final String content; // Markdown formatted content
//   final List<String> questionIds; // IDs of questions in this lesson

//   const Lesson({
//     required this.id,
//     required this.title,
//     required this.content,
//     this.questionIds = const [],
//   });

//   factory Lesson.fromMap(Map<String, dynamic> map) {
//     return Lesson(
//       id: map['id'] as String,
//       title: map['title'] as String,
//       content: map['content'] as String,
//       questionIds: List<String>.from(map['questionIds'] ?? []),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'content': content,
//       'questionIds': questionIds,
//     };
//   }

//   Lesson copyWith({
//     String? id,
//     String? title,
//     String? content,
//     List<String>? questionIds,
//   }) {
//     return Lesson(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       content: content ?? this.content,
//       questionIds: questionIds ?? this.questionIds,
//     );
//   }

//   @override
//   String toString() {
//     return 'Lesson(id: $id, title: $title, content: $content, questionIds: $questionIds)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Lesson &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           title == other.title &&
//           content == other.content &&
//           listEquals(questionIds, other.questionIds);

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       title.hashCode ^
//       content.hashCode ^
//       listEquals(questionIds, questionIds).hashCode;
// }
// // lib/models/course.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

// @immutable
// class Course {
//   final String id;
//   final String creatorId; // New: ID of the user who created this course
//   final String title;
//   final String description;
//   final String difficulty;
//   final String gameGenre;
//   final List<String> levelIds;
//   final DateTime createdAt;

//   const Course({
//     required this.id,
//     required this.creatorId, // Add to constructor
//     required this.title,
//     required this.description,
//     required this.difficulty,
//     required this.gameGenre,
//     this.levelIds = const [],
//     required this.createdAt,
//   });

//   factory Course.fromMap(Map<String, dynamic> map) {
//     return Course(
//       id: map['id'] as String,
//       creatorId: map['creatorId'] as String, // Read from map
//       title: map['title'] as String,
//       description: map['description'] as String,
//       difficulty: map['difficulty'] as String,
//       gameGenre: map['gameGenre'] as String,
//       levelIds: List<String>.from(map['levelIds'] ?? []),
//       createdAt: (map['createdAt'] as Timestamp).toDate(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'creatorId': creatorId, // Write to map
//       'title': title,
//       'description': description,
//       'difficulty': difficulty,
//       'gameGenre': gameGenre,
//       'levelIds': levelIds,
//       'createdAt': Timestamp.fromDate(createdAt),
//     };
//   }

//   Course copyWith({
//     String? id,
//     String? creatorId,
//     String? title,
//     String? description,
//     String? difficulty,
//     String? gameGenre,
//     List<String>? levelIds,
//     DateTime? createdAt,
//   }) {
//     return Course(
//       id: id ?? this.id,
//       creatorId: creatorId ?? this.creatorId,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       difficulty: difficulty ?? this.difficulty,
//       gameGenre: gameGenre ?? this.gameGenre,
//       levelIds: levelIds ?? this.levelIds,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }

//   @override
//   String toString() {
//     return 'Course(id: $id, creatorId: $creatorId, title: $title, description: $description, difficulty: $difficulty, gameGenre: $gameGenre, levelIds: $levelIds, createdAt: $createdAt)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Course &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           creatorId == other.creatorId &&
//           title == other.title &&
//           description == other.description &&
//           difficulty == other.difficulty &&
//           gameGenre == other.gameGenre &&
//           listEquals(levelIds, other.levelIds) &&
//           createdAt == other.createdAt;

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       creatorId.hashCode ^
//       title.hashCode ^
//       description.hashCode ^
//       difficulty.hashCode ^
//       gameGenre.hashCode ^
//       listEquals(levelIds, levelIds).hashCode ^
//       createdAt.hashCode;
// }
// // lib/models/community_post.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

// @immutable
// class Comment {
//   final String userId;
//   final String username;
//   final String avatarAssetPath;
//   final String content;
//   final DateTime timestamp;

//   const Comment({
//     required this.userId,
//     required this.username,
//     required this.avatarAssetPath,
//     required this.content,
//     required this.timestamp,
//   });

//   factory Comment.fromMap(Map<String, dynamic> map) {
//     return Comment(
//       userId: map['userId'] as String,
//       username: map['username'] as String,
//       avatarAssetPath: map['avatarAssetPath'] as String,
//       content: map['content'] as String,
//       timestamp: (map['timestamp'] as Timestamp).toDate(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'username': username,
//       'avatarAssetPath': avatarAssetPath,
//       'content': content,
//       'timestamp': Timestamp.fromDate(timestamp),
//     };
//   }

//   @override
//   String toString() {
//     return 'Comment(userId: $userId, username: $username, avatarAssetPath: $avatarAssetPath, content: $content, timestamp: $timestamp)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Comment &&
//           runtimeType == other.runtimeType &&
//           userId == other.userId &&
//           username == other.username &&
//           avatarAssetPath == other.avatarAssetPath &&
//           content == other.content &&
//           timestamp == other.timestamp;

//   @override
//   int get hashCode =>
//       userId.hashCode ^
//       username.hashCode ^
//       avatarAssetPath.hashCode ^
//       content.hashCode ^
//       timestamp.hashCode;
// }

// @immutable
// class CommunityPost {
//   final String id;
//   final String userId;
//   final String username;
//   final String avatarAssetPath;
//   final String content;
//   final DateTime timestamp;
//   final List<String> likedBy; // List of user UIDs who liked the post
//   final List<Comment> comments;

//   const CommunityPost({
//     required this.id,
//     required this.userId,
//     required this.username,
//     required this.avatarAssetPath,
//     required this.content,
//     required this.timestamp,
//     this.likedBy = const [],
//     this.comments = const [],
//   });

//   factory CommunityPost.fromMap(Map<String, dynamic> map) {
//     return CommunityPost(
//       id: map['id'] as String,
//       userId: map['userId'] as String,
//       username: map['username'] as String,
//       avatarAssetPath: map['avatarAssetPath'] as String,
//       content: map['content'] as String,
//       timestamp: (map['timestamp'] as Timestamp).toDate(),
//       likedBy: List<String>.from(map['likedBy'] ?? []),
//       comments: (map['comments'] as List<dynamic>?)
//               ?.map((e) => Comment.fromMap(e as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'userId': userId,
//       'username': username,
//       'avatarAssetPath': avatarAssetPath,
//       'content': content,
//       'timestamp': Timestamp.fromDate(timestamp),
//       'likedBy': likedBy,
//       'comments': comments.map((e) => e.toMap()).toList(),
//     };
//   }

//   CommunityPost copyWith({
//     String? id,
//     String? userId,
//     String? username,
//     String? avatarAssetPath,
//     String? content,
//     DateTime? timestamp,
//     List<String>? likedBy,
//     List<Comment>? comments,
//   }) {
//     return CommunityPost(
//       id: id ?? this.id,
//       userId: userId ?? this.userId,
//       username: username ?? this.username,
//       avatarAssetPath: avatarAssetPath ?? this.avatarAssetPath,
//       content: content ?? this.content,
//       timestamp: timestamp ?? this.timestamp,
//       likedBy: likedBy ?? this.likedBy,
//       comments: comments ?? this.comments,
//     );
//   }

//   @override
//   String toString() {
//     return 'CommunityPost(id: $id, userId: $userId, username: $username, avatarAssetPath: $avatarAssetPath, content: $content, timestamp: $timestamp, likedBy: $likedBy, comments: $comments)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is CommunityPost &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           userId == other.userId &&
//           username == other.username &&
//           avatarAssetPath == other.avatarAssetPath &&
//           content == other.content &&
//           timestamp == other.timestamp &&
//           listEquals(likedBy, other.likedBy) &&
//           listEquals(comments, other.comments);

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       userId.hashCode ^
//       username.hashCode ^
//       avatarAssetPath.hashCode ^
//       content.hashCode ^
//       timestamp.hashCode ^
//       listEquals(likedBy, likedBy).hashCode ^
//       listEquals(comments, comments).hashCode;
// }
// // lib/models/badge.dart
// import 'package:flutter/foundation.dart';

// @immutable
// class Badge {
//   final String id;
//   final String name;
//   final String description;
//   final String imageUrl; // Path to the badge image asset or URL

//   const Badge({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.imageUrl,
//   });

//   factory Badge.fromMap(Map<String, dynamic> map) {
//     return Badge(
//       id: map['id'] as String,
//       name: map['name'] as String,
//       description: map['description'] as String,
//       imageUrl: map['imageUrl'] as String,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'imageUrl': imageUrl,
//     };
//   }

//   @override
//   String toString() {
//     return 'Badge(id: $id, name: $name, description: $description, imageUrl: $imageUrl)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Badge &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           name == other.name &&
//           description == other.description &&
//           imageUrl == other.imageUrl;

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode ^ imageUrl.hashCode;
// }
// // lib/models/avatar_asset.dart
// import 'package:flutter/foundation.dart';

// @immutable
// class AvatarAsset {
//   final String id;
//   final String name;
//   final String assetPath;

//   const AvatarAsset({
//     required this.id,
//     required this.name,
//     required this.assetPath,
//   });

//   @override
//   String toString() {
//     return 'AvatarAsset(id: $id, name: $name, assetPath: $assetPath)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is AvatarAsset &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           name == other.name &&
//           assetPath == other.assetPath;

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode ^ assetPath.hashCode;
// }
// // lib/constants/app_colors.dart
// import 'package:flutter/material.dart';

// class AppColors {
//   // Core Palette
//   static const Color primaryColor = Color(0xFF1A1A2E); // Dark Blue/Purple
//   static const Color accentColor = Color(0xFFE94560); // Vibrant Pink/Red
//   static const Color secondaryColor = Color(0xFF0F3460); // Muted Blue
//   static const Color textColor = Color(0xFFFFFFFF); // White
//   static const Color textColorSecondary = Color(0xFFAAAAAA); // Light Gray

//   // Gamification Colors
//   static const Color xpColor = Color(0xFFFDCB6E); // Gold for XP
//   static const Color levelColor = Color(0xFF00B894); // Green for Level
//   static const Color streakColor = Color(0xFFEB2F96); // Pink for Streaks (can be same as accent or distinct)

//   // Status Colors
//   static const Color successColor = Color(0xFF28A745); // Green for success
//   static const Color errorColor = Color(0xFFDC3545); // Red for errors
//   static const Color warningColor = Color(0xFFFFC107); // Yellow for warnings
//   static const Color infoColor = Color(0xFF17A2B8); // Cyan for info

//   // UI Element Colors
//   static const Color cardColor = Color(0xFF2E2E4A); // Slightly lighter than primary for cards
//   static const Color borderColor = Color(0xFF3F3F60); // Border color for elements
//   static const Color transparent = Colors.transparent;

//   // Gradients
//   static LinearGradient backgroundGradient() {
//     return const LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [
//         primaryColor,
//         secondaryColor,
//       ],
//     );
//   }

//   static LinearGradient buttonGradient() {
//     return const LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [
//         accentColor,
//         Color(0xFFCE203A), // Slightly darker accent
//       ],
//     );
//   }
// }
// // lib/constants/app_constants.dart
// import 'package:gamifier/models/avatar_asset.dart';

// class AppConstants {
//   static const String geminiApiKey = 'AIzaSyDZ6yDuQgQWxzc5Qq24Dpf_BkvcOjx_SP8';

//   static const String usersCollection = 'users';
//   static const String coursesCollection = 'courses';
//   static const String lessonsCollection = 'lessons';
//   static const String userProgressCollection = 'user_progress';
//   static const String badgesCollection = 'badges';
//   static const String leaderboardsCollection = 'leaderboard';
//   static const String levelsCollection = 'levels';
//   static const String communityPostsCollection = 'community_posts';

//   static const int maxUsernameLength = 20;
//   static const int minPasswordLength = 6;
//   static const int initialXp = 0;
//   static const int xpPerLevel = 100;
//   static const int xpPerCorrectAnswer = 10;
//   static const int leaderboardLimit = 10;

//   // New constants for streaks
//   static const int initialStreak = 0;
//   static const int streakBonusXp = 5; // XP awarded for maintaining a streak
//   static const int levelXpDeductionOnReattempt = 20; // XP deducted for reattempting a level

//   static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
//   static const Duration longAnimationDuration = Duration(milliseconds: 600);
//   static const Duration shimmerAnimationDuration = Duration(milliseconds: 1500);

//   static const double borderRadius = 16.0;
//   static const double padding = 16.0;
//   static const double spacing = 8.0;
//   static const double iconSize = 24.0;
//   static const double avatarSize = 64.0;
//   static const double badgeSize = 48.0;

//   // Text sizes for consistency and smaller text
//   static const double largeTextSize = 22.0;
//   static const double mediumTextSize = 16.0;
//   static const double smallTextSize = 14.0;
//   static const double extraSmallTextSize = 12.0;


//   static const String appName = 'Gamifier';
//   static const String appTagline = 'Learn. Play. Conquer.';
//   static const String defaultFontFamily = 'Inter';

//   static const double geminiTemperature = 0.7;
//   static const int geminiMaxOutputTokens = 2000;

//   static const List<AvatarAsset> defaultAvatarAssets = [
//     AvatarAsset(id: 'avatar1', name: 'Adventurer', assetPath: 'assets/avatars/avatar1.png'),
//     AvatarAsset(id: 'avatar2', name: 'Explorer', assetPath: 'assets/avatars/avatar2.png'),
//     AvatarAsset(id: 'avatar3', name: 'Wizard', assetPath: 'assets/avatars/avatar3.png'),
//     AvatarAsset(id: 'avatar4', name: 'Knight', assetPath: 'assets/avatars/avatar4.png'),
//   ];

//   static const String correctSoundPath = 'assets/audios/correct.mp3';
//   static const String levelUpSoundPath = 'assets/audios/level_up.mp3';
//   static const String incorrectSoundPath = 'assets/audios/incorrect.mp3'; // Added for incorrect answers

//   static const List<String> gameThemes = [
//     'Fantasy',
//     'Sci-Fi',
//     'Adventure',
//     'Mystery',
//     'Cyberpunk',
//   ];

//   static const List<String> difficultyLevels = [
//     'Beginner',
//     'Novice',
//     'Intermediate',
//     'Proficient',
//     'Advanced',
//     'Expert',
//     'Master',
//     'Grandmaster',
//     'Legendary',
//     'Mythic',
//   ];

//   static const List<String> educationLevels = [
//     'High School',
//     'Associate Degree',
//     'Bachelor\'s Degree',
//     'Master\'s Degree',
//     'PhD',
//     'Other',
//   ];

//   static const List<String> defaultCourseTopics = [
//     'Introduction to Python',
//     'Fundamentals of Web Development',
//     'Basic Algebra',
//     'History of Ancient Civilizations',
//     'Understanding Climate Change',
//   ];
// }
