// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';

// import 'app.dart';
// import 'services/firebase_service.dart';
// import 'services/gemini_api_service.dart';
// import 'services/audio_service.dart';
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
//         Provider<AudioService>(
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
// import 'package:provider/provider.dart';
// import 'package:gamifier/services/audio_service.dart';

// class App extends StatefulWidget {
//   const App({super.key});

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<AudioService>(context, listen: false).loadAudioAssets();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: AppConstants.appName,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         primaryColor: AppColors.primaryColor,
//         hintColor: AppColors.accentColor,
//         scaffoldBackgroundColor: Colors.transparent,
//         cardColor: AppColors.cardColor,
//         fontFamily: AppConstants.defaultFontFamily,
//         textTheme: const TextTheme(
//           displayLarge: TextStyle(color: AppColors.textColor),
//           displayMedium: TextStyle(color: AppColors.textColor),
//           displaySmall: TextStyle(color: AppColors.textColor),
//           headlineLarge: TextStyle(color: AppColors.textColor),
//           headlineMedium: TextStyle(color: AppColors.textColor),
//           headlineSmall: TextStyle(color: AppColors.textColor),
//           titleLarge: TextStyle(color: AppColors.textColor),
//           titleMedium: TextStyle(color: AppColors.textColor),
//           titleSmall: TextStyle(color: AppColors.textColor),
//           bodyLarge: TextStyle(color: AppColors.textColor),
//           bodyMedium: TextStyle(color: AppColors.textColor),
//           bodySmall: TextStyle(color: AppColors.textColor),
//           labelLarge: TextStyle(color: AppColors.textColor),
//           labelMedium: TextStyle(color: AppColors.textColor),
//           labelSmall: TextStyle(color: AppColors.textColor),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           filled: true,
//           fillColor: AppColors.cardColor.withOpacity(0.7),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             borderSide: const BorderSide(color: AppColors.accentColor, width: 2.0),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             borderSide: const BorderSide(color: AppColors.borderColor, width: 1.0),
//           ),
//           labelStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.8)),
//           hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.5)),
//           prefixIconColor: AppColors.textColorSecondary,
//         ),
//         buttonTheme: ButtonThemeData(
//           buttonColor: AppColors.primaryColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           ),
//           textTheme: ButtonTextTheme.primary,
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.primaryColor,
//             foregroundColor: AppColors.textColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ),
//         textButtonTheme: TextButtonThemeData(
//           style: TextButton.styleFrom(
//             foregroundColor: AppColors.accentColor,
//             textStyle: const TextStyle(fontSize: 14),
//           ),
//         ),
//         cardTheme: CardTheme(
//           color: AppColors.cardColor,
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           ),
//         ),
//         tabBarTheme: TabBarTheme(
//           labelColor: AppColors.accentColor,
//           unselectedLabelColor: AppColors.textColorSecondary,
//           indicator: UnderlineTabIndicator(
//             borderSide: const BorderSide(color: AppColors.accentColor, width: 3.0),
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
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
// import 'package:gamifier/widgets/common/custom_text_field.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';

// class ShortAnswerQuestionWidget extends StatefulWidget {
//   final Question question;
//   final Function(String userResponse, String questionId) onEvaluate;
//   final bool isEnabled;
//   final bool showFeedback;
//   final bool isCorrect;
//   final String? userAnswer;

//   const ShortAnswerQuestionWidget({
//     super.key,
//     required this.question,
//     required this.onEvaluate,
//     this.isEnabled = true,
//     this.showFeedback = false,
//     this.isCorrect = false,
//     this.userAnswer,
//   });

//   @override
//   State<ShortAnswerQuestionWidget> createState() => _ShortAnswerQuestionWidgetState();
// }

// class _ShortAnswerQuestionWidgetState extends State<ShortAnswerQuestionWidget> {
//   final TextEditingController _answerController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.userAnswer != null) {
//       _answerController.text = widget.userAnswer!;
//     }
//   }

//   @override
//   void dispose() {
//     _answerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         side: BorderSide(color: widget.showFeedback ? (widget.isCorrect ? AppColors.successColor : AppColors.errorColor) : AppColors.borderColor, width: 2),
//       ),
//       elevation: 6,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.question.questionText,
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor),
//             ),
//             const SizedBox(height: AppConstants.padding),
//             CustomTextField(
//               controller: _answerController,
//               labelText: 'Your Answer',
//               hintText: 'Type your answer here...',
//               maxLines: 4,
//               isEnabled: widget.isEnabled && !widget.showFeedback, // Pass isEnabled
//             ),
//             const SizedBox(height: AppConstants.padding),
//             if (widget.showFeedback) ...[
//               if (widget.isCorrect)
//                 Text(
//                   'Correct! You earned ${widget.question.xpReward} XP.',
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.successColor),
//                 )
//               else
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Incorrect. Expected keywords were:',
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.errorColor),
//                     ),
//                     Text(
//                       widget.question.expectedAnswerKeywords ?? 'N/A',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                             color: AppColors.accentColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                   ],
//                 ),
//               const SizedBox(height: AppConstants.spacing),
//             ],
//             if (widget.isEnabled && !widget.showFeedback)
//               CustomButton(
//                 text: 'Submit Answer',
//                 onPressed: () => widget.onEvaluate(_answerController.text, widget.question.id),
//                 backgroundColor: AppColors.primaryColor,
//               ),
//           ],
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
// import 'package:gamifier/widgets/common/custom_text_field.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';

// class ScenarioQuestionWidget extends StatefulWidget {
//   final Question question;
//   final Function(String userResponse, String questionId) onEvaluate;
//   final bool isEnabled;
//   final bool showFeedback;
//   final bool isCorrect;
//   final String? userAnswer;

//   const ScenarioQuestionWidget({
//     super.key,
//     required this.question,
//     required this.onEvaluate,
//     this.isEnabled = true,
//     this.showFeedback = false,
//     this.isCorrect = false,
//     this.userAnswer,
//   });

//   @override
//   State<ScenarioQuestionWidget> createState() => _ScenarioQuestionWidgetState();
// }

// class _ScenarioQuestionWidgetState extends State<ScenarioQuestionWidget> {
//   final TextEditingController _outcomeController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.userAnswer != null) {
//       _outcomeController.text = widget.userAnswer!;
//     }
//   }

//   @override
//   void dispose() {
//     _outcomeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         side: BorderSide(color: widget.showFeedback ? (widget.isCorrect ? AppColors.successColor : AppColors.errorColor) : AppColors.borderColor, width: 2),
//       ),
//       elevation: 6,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Scenario:',
//               style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.accentColor),
//             ),
//             const SizedBox(height: AppConstants.spacing),
//             Text(
//               widget.question.scenarioText ?? 'No scenario provided.',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColor),
//             ),
//             const SizedBox(height: AppConstants.padding),
//             Text(
//               widget.question.questionText,
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor),
//             ),
//             const SizedBox(height: AppConstants.padding),
//             CustomTextField(
//               controller: _outcomeController,
//               labelText: 'Your Expected Outcome',
//               hintText: 'What do you think will happen?',
//               maxLines: 5,
//               isEnabled: widget.isEnabled && !widget.showFeedback, // Pass isEnabled
//             ),
//             const SizedBox(height: AppConstants.padding),
//             if (widget.showFeedback) ...[
//               if (widget.isCorrect)
//                 Text(
//                   'Correct! You earned ${widget.question.xpReward} XP. Your reasoning matches the expected outcome.',
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.successColor),
//                 )
//               else
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Incorrect. The expected outcome was:',
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.errorColor),
//                     ),
//                     Text(
//                       widget.question.expectedOutcome ?? 'N/A',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                             color: AppColors.accentColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                   ],
//                 ),
//               const SizedBox(height: AppConstants.spacing),
//             ],
//             if (widget.isEnabled && !widget.showFeedback)
//               CustomButton(
//                 text: 'Submit Outcome',
//                 onPressed: () => widget.onEvaluate(_outcomeController.text, widget.question.id),
//                 backgroundColor: AppColors.primaryColor,
//               ),
//           ],
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
// import 'package:gamifier/constants/app_constants.dart';

// class QuestionRenderer extends StatelessWidget {
//   final Question question;
//   final ValueChanged<String> onAnswerSubmitted; // Generic submit, can be refined
//   final bool showFeedback;
//   final bool isCorrect;
//   final String? userAnswer;
//   final Function(String userResponse, String questionId)? onEvaluate;
//   final bool isEnabled;

//   const QuestionRenderer({
//     super.key,
//     required this.question,
//     required this.onAnswerSubmitted,
//     this.showFeedback = false,
//     this.isCorrect = false,
//     this.userAnswer,
//     this.onEvaluate,
//     this.isEnabled = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (onEvaluate == null) {
//       return Card(
//         color: AppColors.errorColor.withOpacity(0.2),
//         margin: const EdgeInsets.all(AppConstants.padding),
//         child: Padding(
//           padding: const EdgeInsets.all(AppConstants.padding),
//           child: Text('Error: onEvaluate callback is required for QuestionRenderer. Question ID: ${question.id}',
//               style: const TextStyle(color: AppColors.errorColor)),
//         ),
//       );
//     }

//     switch (question.type) {
//       case 'MCQ':
//         return MCQQuestionWidget(
//           question: question,
//           onEvaluate: onEvaluate!,
//           isEnabled: isEnabled,
//           showFeedback: showFeedback,
//           isCorrect: isCorrect,
//           userAnswer: userAnswer,
//         );
//       case 'FillInBlank':
//         return FillInBlankQuestionWidget(
//           question: question,
//           onEvaluate: onEvaluate!,
//           isEnabled: isEnabled,
//           showFeedback: showFeedback,
//           isCorrect: isCorrect,
//           userAnswer: userAnswer,
//         );
//       case 'ShortAnswer':
//         return ShortAnswerQuestionWidget(
//           question: question,
//           onEvaluate: onEvaluate!,
//           isEnabled: isEnabled,
//           showFeedback: showFeedback,
//           isCorrect: isCorrect,
//           userAnswer: userAnswer,
//         );
//       case 'Scenario':
//         return ScenarioQuestionWidget(
//           question: question,
//           onEvaluate: onEvaluate!,
//           isEnabled: isEnabled,
//           showFeedback: showFeedback,
//           isCorrect: isCorrect,
//           userAnswer: userAnswer,
//         );
//       default:
//         return Card(
//           color: AppColors.errorColor.withOpacity(0.2),
//           margin: const EdgeInsets.all(AppConstants.padding),
//           child: Padding(
//             padding: const EdgeInsets.all(AppConstants.padding),
//             child: Text(
//               'Unsupported question type: ${question.type}. Question ID: ${question.id}',
//               style: const TextStyle(color: AppColors.errorColor),
//             ),
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
// import 'package:gamifier/widgets/common/custom_button.dart';

// class MCQQuestionWidget extends StatefulWidget {
//   final Question question;
//   final Function(String userResponse, String questionId) onEvaluate;
//   final bool isEnabled;
//   final bool showFeedback;
//   final bool isCorrect;
//   final String? userAnswer;

//   const MCQQuestionWidget({
//     super.key,
//     required this.question,
//     required this.onEvaluate,
//     this.isEnabled = true,
//     this.showFeedback = false,
//     this.isCorrect = false,
//     this.userAnswer,
//   });

//   @override
//   State<MCQQuestionWidget> createState() => _MCQQuestionWidgetState();
// }

// class _MCQQuestionWidgetState extends State<MCQQuestionWidget> {
//   String? _selectedOption;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.userAnswer != null) {
//       _selectedOption = widget.userAnswer;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.question.options == null || widget.question.options!.isEmpty) {
//       return Card(
//         color: AppColors.errorColor.withOpacity(0.2),
//         margin: const EdgeInsets.all(AppConstants.padding),
//         child: Padding(
//           padding: const EdgeInsets.all(AppConstants.padding),
//           child: Text('Error: MCQ question has no options. Question ID: ${widget.question.id}',
//               style: const TextStyle(color: AppColors.errorColor)),
//         ),
//       );
//     }

//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         side: BorderSide(color: widget.showFeedback ? (widget.isCorrect ? AppColors.successColor : AppColors.errorColor) : AppColors.borderColor, width: 2),
//       ),
//       elevation: 6,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.question.questionText,
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor),
//             ),
//             const SizedBox(height: AppConstants.padding),
//             ...widget.question.options!.map((option) {
//               bool isOptionSelected = _selectedOption == option;
//               Color tileColor = Colors.transparent;
//               Color textColor = AppColors.textColor;
//               Color borderColor = AppColors.borderColor;

//               if (widget.showFeedback) {
//                 if (option == widget.question.correctAnswer) {
//                   tileColor = AppColors.successColor.withOpacity(0.2);
//                   borderColor = AppColors.successColor;
//                 } else if (isOptionSelected && !widget.isCorrect) {
//                   tileColor = AppColors.errorColor.withOpacity(0.2);
//                   borderColor = AppColors.errorColor;
//                 }
//               } else if (isOptionSelected) {
//                 tileColor = AppColors.primaryColor.withOpacity(0.5);
//                 borderColor = AppColors.accentColor;
//               }

//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//                 child: GestureDetector(
//                   onTap: widget.isEnabled && !widget.showFeedback
//                       ? () {
//                           setState(() {
//                             _selectedOption = option;
//                           });
//                         }
//                       : null,
//                   child: AnimatedContainer(
//                     duration: AppConstants.defaultAnimationDuration,
//                     padding: const EdgeInsets.all(AppConstants.spacing),
//                     decoration: BoxDecoration(
//                       color: tileColor,
//                       borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
//                       border: Border.all(color: borderColor, width: 1.5),
//                     ),
//                     child: Row(
//                       children: [
//                         Radio<String>(
//                           value: option,
//                           groupValue: _selectedOption,
//                           onChanged: widget.isEnabled && !widget.showFeedback
//                               ? (value) {
//                                   setState(() {
//                                     _selectedOption = value;
//                                   });
//                                 }
//                               : null,
//                           activeColor: AppColors.accentColor,
//                           fillColor: MaterialStateProperty.resolveWith<Color>(
//                             (Set<MaterialState> states) {
//                               if (states.contains(MaterialState.disabled)) {
//                                 return AppColors.textColorSecondary.withOpacity(0.5);
//                               }
//                               return AppColors.accentColor;
//                             },
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             option,
//                             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                                   color: textColor,
//                                 ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//             const SizedBox(height: AppConstants.padding),
//             if (widget.showFeedback) ...[
//               if (widget.isCorrect)
//                 Text(
//                   'Correct! You earned ${widget.question.xpReward} XP.',
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.successColor),
//                 )
//               else
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Incorrect. The correct answer was:',
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.errorColor),
//                     ),
//                     Text(
//                       widget.question.correctAnswer ?? 'N/A',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                             color: AppColors.accentColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                   ],
//                 ),
//               const SizedBox(height: AppConstants.spacing),
//             ],
//             if (widget.isEnabled && !widget.showFeedback)
//               CustomButton(
//                 text: 'Submit Answer',
//                 onPressed: _selectedOption == null
//                     ? null
//                     : () => widget.onEvaluate(_selectedOption!, widget.question.id),
//                 backgroundColor: AppColors.primaryColor,
//               ),
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
// import 'package:gamifier/widgets/common/custom_text_field.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';

// class FillInBlankQuestionWidget extends StatefulWidget {
//   final Question question;
//   final Function(String userResponse, String questionId) onEvaluate;
//   final bool isEnabled;
//   final bool showFeedback;
//   final bool isCorrect;
//   final String? userAnswer;

//   const FillInBlankQuestionWidget({
//     super.key,
//     required this.question,
//     required this.onEvaluate,
//     this.isEnabled = true,
//     this.showFeedback = false,
//     this.isCorrect = false,
//     this.userAnswer,
//   });

//   @override
//   State<FillInBlankQuestionWidget> createState() => _FillInBlankQuestionWidgetState();
// }

// class _FillInBlankQuestionWidgetState extends State<FillInBlankQuestionWidget> {
//   final TextEditingController _answerController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.userAnswer != null) {
//       _answerController.text = widget.userAnswer!;
//     }
//   }

//   @override
//   void dispose() {
//     _answerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         side: BorderSide(color: widget.showFeedback ? (widget.isCorrect ? AppColors.successColor : AppColors.errorColor) : AppColors.borderColor, width: 2),
//       ),
//       elevation: 6,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.question.questionText,
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor),
//             ),
//             const SizedBox(height: AppConstants.padding),
//             CustomTextField(
//               controller: _answerController,
//               labelText: 'Your Answer',
//               hintText: 'Type your answer here',
//               isEnabled: widget.isEnabled && !widget.showFeedback, // Pass isEnabled
//             ),
//             const SizedBox(height: AppConstants.padding),
//             if (widget.showFeedback) ...[
//               if (widget.isCorrect)
//                 Text(
//                   'Correct! You earned ${widget.question.xpReward} XP.',
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.successColor),
//                 )
//               else
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Incorrect. The correct answer was:',
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.errorColor),
//                     ),
//                     Text(
//                       widget.question.correctAnswer ?? 'N/A',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                             color: AppColors.accentColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                   ],
//                 ),
//               const SizedBox(height: AppConstants.spacing),
//             ],
//             if (widget.isEnabled && !widget.showFeedback)
//               CustomButton(
//                 text: 'Submit Answer',
//                 onPressed: () => widget.onEvaluate(_answerController.text, widget.question.id),
//                 backgroundColor: AppColors.primaryColor,
//               ),
//           ],
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
//             icon: Icon(Icons.people),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem( // New Chat item
//             icon: Icon(Icons.chat),
//             label: 'Chat',
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/widgets/lesson/lesson_content_display.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class LessonContentDisplay extends StatelessWidget {
//   final String content;

//   const LessonContentDisplay({
//     super.key,
//     required this.content,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//       ),
//       elevation: 6,
//       margin: const EdgeInsets.all(AppConstants.padding),
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: MarkdownBody(
//           data: content,
//           selectable: true,
//           styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
//             p: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColor),
//             h1: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.accentColor),
//             h2: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.secondaryColor),
//             h3: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.infoColor),
//             strong: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor),
//             em: const TextStyle(fontStyle: FontStyle.italic, color: AppColors.textColorSecondary),
//             blockquote: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color: AppColors.textColorSecondary,
//                   fontStyle: FontStyle.italic,
//                   decorationColor: AppColors.borderColor,
//                 ),
//             code: Theme.of(context).textTheme.bodySmall?.copyWith(
//                   fontFamily: 'monospace',
//                   backgroundColor: AppColors.progressTrackColor,
//                   color: AppColors.accentColor,
//                 ),
//             codeblockDecoration: BoxDecoration(
//               color: AppColors.progressTrackColor,
//               borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
//             ),
//             listBullet: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.accentColor),
//             tableBody: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColor),
//             tableHead: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.accentColor, fontWeight: FontWeight.bold),
//           ),
//           onTapLink: (text, href, title) {
//             // Implement link handling if needed
//           },
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
// import 'package:gamifier/constants/app_constants.dart';

// class QuestionRenderer extends StatelessWidget {
//   final Question question;
//   final ValueChanged<String> onAnswerSubmitted; // Generic submit, can be refined
//   final bool showFeedback;
//   final bool isCorrect;
//   final String? userAnswer;
//   final Function(String userResponse, String questionId)? onEvaluate;
//   final bool isEnabled;

//   const QuestionRenderer({
//     super.key,
//     required this.question,
//     required this.onAnswerSubmitted,
//     this.showFeedback = false,
//     this.isCorrect = false,
//     this.userAnswer,
//     this.onEvaluate,
//     this.isEnabled = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (onEvaluate == null) {
//       return Card(
//         color: AppColors.errorColor.withOpacity(0.2),
//         margin: const EdgeInsets.all(AppConstants.padding),
//         child: Padding(
//           padding: const EdgeInsets.all(AppConstants.padding),
//           child: Text('Error: onEvaluate callback is required for QuestionRenderer. Question ID: ${question.id}',
//               style: const TextStyle(color: AppColors.errorColor)),
//         ),
//       );
//     }

//     switch (question.type) {
//       case 'MCQ':
//         return MCQQuestionWidget(
//           question: question,
//           onEvaluate: onEvaluate!,
//           isEnabled: isEnabled,
//           showFeedback: showFeedback,
//           isCorrect: isCorrect,
//           userAnswer: userAnswer,
//         );
//       case 'FillInBlank':
//         return FillInBlankQuestionWidget(
//           question: question,
//           onEvaluate: onEvaluate!,
//           isEnabled: isEnabled,
//           showFeedback: showFeedback,
//           isCorrect: isCorrect,
//           userAnswer: userAnswer,
//         );
//       case 'ShortAnswer':
//         return ShortAnswerQuestionWidget(
//           question: question,
//           onEvaluate: onEvaluate!,
//           isEnabled: isEnabled,
//           showFeedback: showFeedback,
//           isCorrect: isCorrect,
//           userAnswer: userAnswer,
//         );
//       case 'Scenario':
//         return ScenarioQuestionWidget(
//           question: question,
//           onEvaluate: onEvaluate!,
//           isEnabled: isEnabled,
//           showFeedback: showFeedback,
//           isCorrect: isCorrect,
//           userAnswer: userAnswer,
//         );
//       default:
//         return Card(
//           color: AppColors.errorColor.withOpacity(0.2),
//           margin: const EdgeInsets.all(AppConstants.padding),
//           child: Padding(
//             padding: const EdgeInsets.all(AppConstants.padding),
//             child: Text(
//               'Unsupported question type: ${question.type}. Question ID: ${question.id}',
//               style: const TextStyle(color: AppColors.errorColor),
//             ),
//           ),
//         );
//     }
//   }
// }
// // lib/widgets/gamification/avatar_customizer.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/avatar_asset.dart';

// class AvatarCustomizer extends StatelessWidget {
//   final String currentAvatarPath;
//   final List<AvatarAsset> availableAvatars;
//   final Function(String) onAvatarSelected;

//   const AvatarCustomizer({
//     super.key,
//     required this.currentAvatarPath,
//     required this.availableAvatars,
//     required this.onAvatarSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           radius: AppConstants.avatarSize * 0.8,
//           backgroundColor: AppColors.cardColor,
//           backgroundImage: AssetImage(currentAvatarPath),
//           onBackgroundImageError: (exception, stackTrace) {
//             debugPrint('Error loading current avatar: $exception');
//           },
//           child: currentAvatarPath.isEmpty
//               ? Icon(Icons.person, size: AppConstants.avatarSize * 0.8, color: AppColors.textColorSecondary)
//               : null,
//         ),
//         const SizedBox(height: AppConstants.padding),
//         Text(
//           'Choose Your Avatar',
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                 color: AppColors.textColor,
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//         const SizedBox(height: AppConstants.padding),
//         Wrap(
//           spacing: AppConstants.spacing,
//           runSpacing: AppConstants.spacing,
//           alignment: WrapAlignment.center,
//           children: availableAvatars.map((avatar) {
//             final isSelected = avatar.assetPath == currentAvatarPath;
//             return GestureDetector(
//               onTap: () => onAvatarSelected(avatar.assetPath),
//               child: AnimatedContainer(
//                 duration: AppConstants.defaultAnimationDuration,
//                 curve: Curves.easeInOut,
//                 width: AppConstants.avatarSize,
//                 height: AppConstants.avatarSize,
//                 decoration: BoxDecoration(
//                   color: AppColors.cardColor,
//                   borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                   border: Border.all(
//                     color: isSelected ? AppColors.accentColor : AppColors.borderColor,
//                     width: isSelected ? 3.0 : 1.0,
//                   ),
//                   boxShadow: isSelected
//                       ? [
//                           BoxShadow(
//                             color: AppColors.accentColor.withOpacity(0.5),
//                             blurRadius: 10,
//                             spreadRadius: 2,
//                           ),
//                         ]
//                       : [],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(AppConstants.borderRadius - 2),
//                   child: Image.asset(
//                     avatar.assetPath,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Center(child: Icon(Icons.broken_image, color: AppColors.errorColor));
//                     },
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
// // lib/widgets/gamification/badge_display.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/badge.dart' as gamifier_badge; // Alias the model Badge

// class BadgeDisplay extends StatelessWidget {
//   final gamifier_badge.Badge badge; // Use aliased Badge
//   final bool isEarned;

//   const BadgeDisplay({
//     super.key,
//     required this.badge,
//     this.isEarned = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Tooltip(
//       message: '${badge.name}: ${badge.description}',
//       child: Opacity(
//         opacity: isEarned ? 1.0 : 0.4,
//         child: Container(
//           width: AppConstants.badgeSize * 1.2,
//           height: AppConstants.badgeSize * 1.2,
//           decoration: BoxDecoration(
//             color: AppColors.cardColor,
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
//             border: Border.all(
//               color: isEarned ? AppColors.accentColor : AppColors.borderColor,
//               width: 1.0,
//             ),
//             boxShadow: isEarned
//                 ? [
//                     BoxShadow(
//                       color: AppColors.accentColor.withOpacity(0.3),
//                       blurRadius: 8,
//                       spreadRadius: 1,
//                     ),
//                   ]
//                 : [],
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 badge.icon,
//                 color: isEarned ? AppColors.xpColor : AppColors.textColorSecondary,
//                 size: AppConstants.badgeSize * 0.6,
//               ),
//               const SizedBox(height: AppConstants.spacing / 4),
//               Text(
//                 badge.name,
//                 style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                       color: isEarned ? AppColors.textColor : AppColors.textColorSecondary,
//                       fontWeight: FontWeight.bold,
//                     ),
//                 textAlign: TextAlign.center,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/gamification/leaderboard_list.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/widgets/gamification/streak_display.dart';

// class LeaderboardList extends StatelessWidget {
//   final List<UserProfile> users;
//   final String currentUserId;

//   const LeaderboardList({
//     super.key,
//     required this.users,
//     required this.currentUserId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: users.length,
//       itemBuilder: (context, index) {
//         final user = users[index];
//         final bool isCurrentUser = user.uid == currentUserId;

//         return Card(
//           color: isCurrentUser ? AppColors.primaryColor.withOpacity(0.9) : AppColors.cardColor.withOpacity(0.9),
//           margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             side: BorderSide(
//               color: isCurrentUser ? AppColors.accentColor : AppColors.borderColor,
//               width: isCurrentUser ? 2.0 : 1.0,
//             ),
//           ),
//           elevation: isCurrentUser ? 8 : 4,
//           child: Padding(
//             padding: const EdgeInsets.all(AppConstants.padding),
//             child: Row(
//               children: [
//                 Text(
//                   '#${index + 1}',
//                   style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         color: isCurrentUser ? AppColors.accentColor : AppColors.textColorSecondary,
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//                 const SizedBox(width: AppConstants.padding),
//                 CircleAvatar(
//                   radius: 24,
//                   backgroundColor: AppColors.progressTrackColor,
//                   backgroundImage: AssetImage(user.avatarAssetPath),
//                   onBackgroundImageError: (exception, stackTrace) {
//                     debugPrint('Error loading leaderboard avatar: $exception');
//                   },
//                   child: user.avatarAssetPath.isEmpty
//                       ? const Icon(Icons.person, color: AppColors.textColorSecondary, size: 24)
//                       : null,
//                 ),
//                 const SizedBox(width: AppConstants.padding),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         user.username,
//                         style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                               color: isCurrentUser ? AppColors.textColor : AppColors.textColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         'Level ${user.level}',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                               color: isCurrentUser ? AppColors.levelColor : AppColors.textColorSecondary,
//                             ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       '${user.xp} XP',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                             color: AppColors.xpColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                     StreakDisplay(currentStreak: user.currentStreak), // Display streak
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// // lib/widgets/gamification/level_node.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/level.dart';

// class LevelNode extends StatelessWidget {
//   final Level level;
//   final bool isCompleted;
//   final bool isLocked;
//   final VoidCallback? onTap;

//   const LevelNode({
//     super.key,
//     required this.level,
//     this.isCompleted = false,
//     this.isLocked = false,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: isLocked ? null : onTap,
//       child: Opacity(
//         opacity: isLocked ? 0.6 : 1.0,
//         child: Container(
//           width: double.infinity,
//           margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//           padding: const EdgeInsets.all(AppConstants.padding),
//           decoration: BoxDecoration(
//             color: isCompleted
//                 ? AppColors.successColor.withOpacity(0.2)
//                 : (isLocked ? AppColors.progressTrackColor : AppColors.cardColor),
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             border: Border.all(
//               color: isCompleted
//                   ? AppColors.successColor
//                   : (isLocked ? AppColors.borderColor : AppColors.accentColor),
//               width: isLocked ? 1.0 : 2.0,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: isCompleted
//                     ? AppColors.successColor.withOpacity(0.3)
//                     : (isLocked ? Colors.transparent : AppColors.accentColor.withOpacity(0.3)),
//                 blurRadius: isLocked ? 0 : 10,
//                 spreadRadius: isLocked ? 0 : 2,
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Level ${level.order}',
//                     style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                           color: isCompleted ? AppColors.successColor : AppColors.infoColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                   if (isCompleted)
//                     const Icon(Icons.check_circle, color: AppColors.successColor, size: AppConstants.iconSize),
//                   if (isLocked)
//                     const Icon(Icons.lock, color: AppColors.textColorSecondary, size: AppConstants.iconSize),
//                 ],
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Text(
//                 level.title,
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       color: AppColors.textColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: AppConstants.spacing / 2),
//               Text(
//                 level.description,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: AppColors.textColorSecondary,
//                     ),
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Row(
//                 children: [
//                   Icon(Icons.star, color: AppColors.xpColor, size: AppConstants.iconSize * 0.8),
//                   const SizedBox(width: AppConstants.spacing / 2),
//                   Text(
//                     'Difficulty: ${level.difficulty}',
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.xpColor),
//                   ),
//                 ],
//               ),
//               if (level.imageAssetPath != null && level.imageAssetPath!.isNotEmpty) ...[
//                 const SizedBox(height: AppConstants.spacing),
//                 Align(
//                   alignment: Alignment.center,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
//                     child: Image.asset(
//                       level.imageAssetPath!,
//                       height: 80,
//                       width: 80,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           height: 80,
//                           width: 80,
//                           color: AppColors.progressTrackColor,
//                           child: const Center(
//                             child: Icon(Icons.image_not_supported, color: AppColors.textColorSecondary, size: 40),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/gamification/level_path_painter.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';

// class LevelPathPainter extends CustomPainter {
//   final bool isPreviousLevelCompleted;

//   LevelPathPainter({required this.isPreviousLevelCompleted});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = isPreviousLevelCompleted ? AppColors.successColor : AppColors.borderColor
//       ..strokeWidth = 3.0
//       ..strokeCap = StrokeCap.round;

//     // Draw a vertical line
//     canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     if (oldDelegate is LevelPathPainter) {
//       return oldDelegate.isPreviousLevelCompleted != isPreviousLevelCompleted;
//     }
//     return false;
//   }
// }
// // lib/widgets/gamification/streak_display.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class StreakDisplay extends StatelessWidget {
//   final int currentStreak;

//   const StreakDisplay({
//     super.key,
//     required this.currentStreak,
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
//           Icon(Icons.local_fire_department, color: AppColors.streakColor, size: AppConstants.iconSize),
//           const SizedBox(width: AppConstants.spacing / 2),
//           Text(
//             '$currentStreak Day Streak!',
//             style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                   color: AppColors.streakColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/widgets/feedback/personalized_feedback_modal.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';

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
//     required this.isCorrect,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: Stack(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(AppConstants.padding * 1.5),
//             margin: const EdgeInsets.only(top: AppConstants.avatarSize / 2),
//             decoration: BoxDecoration(
//               color: AppColors.cardColor.withOpacity(0.95),
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 10.0,
//                   offset: Offset(0.0, 10.0),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 const SizedBox(height: AppConstants.avatarSize / 2), // Space for icon
//                 Text(
//                   isCorrect ? 'Great Job!' : 'Let\'s Learn More!',
//                   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                         color: isCorrect ? AppColors.successColor : AppColors.warningColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: AppConstants.spacing),
//                 Text(
//                   feedbackText,
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColor),
//                   textAlign: TextAlign.center,
//                 ),
//                 if (socraticFollowUp != null && socraticFollowUp!.isNotEmpty) ...[
//                   const Divider(color: AppColors.borderColor, height: AppConstants.padding * 1.5),
//                   Text(
//                     'Think about this:',
//                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                           color: AppColors.infoColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: AppConstants.spacing / 2),
//                   Text(
//                     socraticFollowUp!,
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: AppColors.textColorSecondary,
//                           fontStyle: FontStyle.italic,
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//                 if (adaptiveHints != null && adaptiveHints!.isNotEmpty) ...[
//                   const Divider(color: AppColors.borderColor, height: AppConstants.padding * 1.5),
//                   Text(
//                     'Hint:',
//                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                           color: AppColors.accentColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: AppConstants.spacing / 2),
//                   Text(
//                     adaptiveHints!,
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//                 const Divider(color: AppColors.borderColor, height: AppConstants.padding * 1.5),
//                 Text(
//                   encouragement,
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         color: isCorrect ? AppColors.levelColor : AppColors.infoColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: AppConstants.padding * 1.5),
//                 CustomButton(
//                   text: 'Got It!',
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   backgroundColor: AppColors.primaryColor,
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             left: AppConstants.padding,
//             right: AppConstants.padding,
//             child: CircleAvatar(
//               backgroundColor: isCorrect ? AppColors.successColor : AppColors.errorColor,
//               radius: AppConstants.avatarSize / 2,
//               child: Icon(
//                 isCorrect ? Icons.check_circle_outline : Icons.lightbulb_outline,
//                 color: Colors.white,
//                 size: AppConstants.avatarSize / 1.5,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/widgets/community/post_card.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/community_post.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/services/firebase_service.dart';

// class PostCard extends StatefulWidget {
//   final CommunityPost post;
//   final String currentUserId;
//   final Function(String postId)? onDelete; // New optional callback for deletion

//   const PostCard({
//     super.key,
//     required this.post,
//     required this.currentUserId,
//     this.onDelete, // Added to constructor
//   });

//   @override
//   State<PostCard> createState() => _PostCardState();
// }

// class _PostCardState extends State<PostCard> {
//   final TextEditingController _commentController = TextEditingController();
//   bool _showComments = false;

//   @override
//   void dispose() {
//     _commentController.dispose();
//     super.dispose();
//   }

//   String _formatTimestamp(DateTime timestamp) {
//     final now = DateTime.now();
//     final difference = now.difference(timestamp);

//     if (difference.inDays > 7) {
//       return DateFormat.yMMMd().format(timestamp);
//     } else if (difference.inDays > 0) {
//       return '${difference.inDays}d ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours}h ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes}m ago';
//     } else {
//       return 'just now';
//     }
//   }

//   Future<void> _toggleLike() async {
//     try {
//       await Provider.of<FirebaseService>(context, listen: false)
//           .toggleLikeOnPost(widget.post.id, widget.currentUserId);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error liking post: $e'),
//           backgroundColor: AppColors.errorColor,
//         ),
//       );
//     }
//   }

//   Future<void> _addComment() async {
//     if (_commentController.text.trim().isEmpty) return;

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final userProfile = await firebaseService.getUserProfile(widget.currentUserId);

//     if (userProfile == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('User profile not found. Cannot add comment.'),
//           backgroundColor: AppColors.errorColor,
//         ),
//       );
//       return;
//     }

//     final newComment = Comment(
//       id: firebaseService.generateNewDocId(),
//       userId: widget.currentUserId,
//       username: userProfile.username,
//       avatarUrl: userProfile.avatarAssetPath,
//       text: _commentController.text.trim(),
//       timestamp: DateTime.now(),
//     );

//     try {
//       await firebaseService.addCommentToPost(widget.post.id, newComment);
//       _commentController.clear();
//       if (!_showComments) {
//         setState(() {
//           _showComments = true; // Automatically show comments after adding one
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error adding comment: $e'),
//           backgroundColor: AppColors.errorColor,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isLiked = widget.post.likedBy.contains(widget.currentUserId);
//     final bool canDelete = widget.onDelete != null && widget.post.authorId == widget.currentUserId;

//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         side: const BorderSide(color: AppColors.borderColor, width: 1.0),
//       ),
//       elevation: 6,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundImage: widget.post.authorAvatarUrl.isNotEmpty
//                       ? AssetImage(widget.post.authorAvatarUrl)
//                       : null,
//                   onBackgroundImageError: (exception, stackTrace) {
//                     debugPrint('Error loading avatar for post: $exception');
//                   },
//                   child: widget.post.authorAvatarUrl.isEmpty
//                       ? const Icon(Icons.person, color: AppColors.textColorSecondary)
//                       : null,
//                 ),
//                 const SizedBox(width: AppConstants.spacing),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.post.authorUsername,
//                         style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                               color: AppColors.accentColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                       ),
//                       Text(
//                         _formatTimestamp(widget.post.timestamp),
//                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                               color: AppColors.textColorSecondary,
//                             ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (canDelete)
//                   IconButton(
//                     icon: const Icon(Icons.delete, color: AppColors.errorColor),
//                     onPressed: () => widget.onDelete!(widget.post.id),
//                   ),
//               ],
//             ),
//             const SizedBox(height: AppConstants.padding),
//             Text(
//               widget.post.content,
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     color: AppColors.textColor,
//                   ),
//             ),
//             if (widget.post.imageUrl != null && widget.post.imageUrl!.isNotEmpty) ...[
//               const SizedBox(height: AppConstants.padding),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                 child: Image.network(
//                   widget.post.imageUrl!,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Center(
//                       child: CircularProgressIndicator(
//                         value: loadingProgress.expectedTotalBytes != null
//                             ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
//                             : null,
//                       ),
//                     );
//                   },
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       height: 150,
//                       color: AppColors.progressTrackColor,
//                       child: const Center(
//                         child: Icon(Icons.image_not_supported, color: AppColors.textColorSecondary),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//             const Divider(color: AppColors.borderColor, height: AppConstants.padding * 2),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 GestureDetector(
//                   onTap: _toggleLike,
//                   child: Row(
//                     children: [
//                       Icon(
//                         isLiked ? Icons.favorite : Icons.favorite_border,
//                         color: isLiked ? AppColors.errorColor : AppColors.textColorSecondary,
//                       ),
//                       const SizedBox(width: AppConstants.spacing / 2),
//                       Text(
//                         '${widget.post.likedBy.length} Likes',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                               color: isLiked ? AppColors.errorColor : AppColors.textColorSecondary,
//                             ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _showComments = !_showComments;
//                     });
//                   },
//                   child: Row(
//                     children: [
//                       Icon(Icons.comment, color: AppColors.textColorSecondary),
//                       const SizedBox(width: AppConstants.spacing / 2),
//                       Text(
//                         '${widget.post.comments.length} Comments',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                               color: AppColors.textColorSecondary,
//                             ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             if (_showComments) ...[
//               const Divider(color: AppColors.borderColor, height: AppConstants.padding * 2),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: widget.post.comments.length,
//                 itemBuilder: (context, index) {
//                   final comment = widget.post.comments[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CircleAvatar(
//                           radius: 12,
//                           backgroundImage: comment.avatarUrl.isNotEmpty
//                               ? AssetImage(comment.avatarUrl)
//                               : null,
//                           onBackgroundImageError: (exception, stackTrace) {
//                             debugPrint('Error loading comment avatar: $exception');
//                           },
//                           child: comment.avatarUrl.isEmpty
//                               ? const Icon(Icons.person, size: 12, color: AppColors.textColorSecondary)
//                               : null,
//                         ),
//                         const SizedBox(width: AppConstants.spacing),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 comment.username,
//                                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                                       color: AppColors.accentColor,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                               ),
//                               Text(
//                                 comment.text,
//                                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                       color: AppColors.textColor,
//                                     ),
//                               ),
//                               Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: Text(
//                                   _formatTimestamp(comment.timestamp),
//                                   style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                                         color: AppColors.textColorSecondary.withOpacity(0.7),
//                                         fontSize: 10,
//                                       ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _commentController,
//                       style: const TextStyle(color: AppColors.textColor),
//                       decoration: InputDecoration(
//                         hintText: 'Add a comment...',
//                         hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.7)),
//                         filled: true,
//                         fillColor: AppColors.backgroundColor.withOpacity(0.6),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
//                       ),
//                       onSubmitted: (value) => _addComment(),
//                     ),
//                   ),
//                   const SizedBox(width: AppConstants.spacing),
//                   FloatingActionButton(
//                     onPressed: _addComment,
//                     backgroundColor: AppColors.secondaryColor,
//                     foregroundColor: AppColors.textColor,
//                     mini: true,
//                     child: const Icon(Icons.send),
//                   ),
//                 ],
//               ),
//             ],
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
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       centerTitle: true,
//       leading: Padding(
//         padding: const EdgeInsets.all(AppConstants.spacing),
//         child: leadingWidget,
//       ),
//       title: Text(
//         title,
//         style: AppColors.neonTextStyle(fontSize: 22),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.all(AppConstants.spacing),
//           child: trailingWidget,
//         ),
//       ],
//       iconTheme: const IconThemeData(color: AppColors.textColor),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
// // lib/widgets/common/custom_button.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
//   final VoidCallback? onPressed; // Changed to nullable VoidCallback
//   final Color? backgroundColor;
//   final Color? foregroundColor;
//   final IconData? icon;
//   final double width;
//   final double height;
//   final double fontSize;
//   final EdgeInsetsGeometry padding;
//   final bool isLoading;

//   const CustomButton({
//     super.key,
//     required this.text,
//     this.onPressed, // No longer required, but recommended to have a default behavior if null
//     this.backgroundColor,
//     this.foregroundColor,
//     this.icon,
//     this.width = double.infinity,
//     this.height = 50.0,
//     this.fontSize = 16.0,
//     this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//     this.isLoading = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor ?? AppColors.primaryColor,
//           foregroundColor: foregroundColor ?? AppColors.textColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//             side: BorderSide(color: backgroundColor != null ? backgroundColor! : AppColors.primaryColorDark, width: 2),
//           ),
//           padding: padding,
//           textStyle: TextStyle(
//             fontSize: fontSize,
//             fontWeight: FontWeight.bold,
//           ),
//           elevation: 8,
//           shadowColor: (backgroundColor ?? AppColors.primaryColor).withOpacity(0.5),
//         ),
//         child: isLoading
//             ? const CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
//               )
//             : Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (icon != null) ...[
//                     Icon(icon, size: fontSize * 1.2),
//                     SizedBox(width: AppConstants.spacing),
//                   ],
//                   Text(text),
//                 ],
//               ),
//       ),
//     );
//   }
// }
// // lib/widgets/common/custom_text_field.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String labelText;
//   final String hintText;
//   final bool obscureText;
//   final TextInputType keyboardType;
//   final String? Function(String?)? validator;
//   final Widget? suffixIcon;
//   final int? maxLines;
//   final bool? isEnabled; // Added isEnabled parameter

//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.labelText,
//     this.hintText = '',
//     this.obscureText = false,
//     this.keyboardType = TextInputType.text,
//     this.validator,
//     this.suffixIcon,
//     this.maxLines = 1,
//     this.isEnabled, // Added to constructor
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       style: const TextStyle(color: AppColors.textColor),
//       maxLines: maxLines,
//       enabled: isEnabled, // Used the isEnabled parameter
//       decoration: InputDecoration(
//         labelText: labelText,
//         hintText: hintText,
//         hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.5)),
//         labelStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.8)),
//         filled: true,
//         fillColor: AppColors.cardColor.withOpacity(0.7),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           borderSide: const BorderSide(color: AppColors.accentColor, width: 2.0),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           borderSide: const BorderSide(color: AppColors.borderColor, width: 1.0),
//         ),
//         suffixIcon: suffixIcon,
//         contentPadding: const EdgeInsets.symmetric(
//             horizontal: AppConstants.padding, vertical: AppConstants.spacing * 1.5),
//       ),
//       validator: validator,
//       cursorColor: AppColors.accentColor,
//     );
//   }
// }
// // lib/widgets/common/progress_bar.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class ProgressBar extends StatelessWidget {
//   final double progress;
//   final Color? backgroundColor;
//   final Color? progressColor;
//   final double height;
//   final bool showPercentage;

//   const ProgressBar({
//     super.key,
//     required this.progress,
//     this.backgroundColor,
//     this.progressColor,
//     this.height = 10.0,
//     this.showPercentage = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         LinearProgressIndicator(
//           value: progress.clamp(0.0, 1.0),
//           backgroundColor: backgroundColor ?? AppColors.progressTrackColor,
//           valueColor: AlwaysStoppedAnimation<Color>(progressColor ?? AppColors.accentColor),
//           minHeight: height,
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
//         ),
//         if (showPercentage) ...[
//           const SizedBox(height: AppConstants.spacing / 2),
//           Text(
//             '${(progress * 100).toStringAsFixed(0)}%',
//             style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColorSecondary),
//           ),
//         ],
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

//   const XpLevelDisplay({
//     super.key,
//     required this.xp,
//     required this.level,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final int xpNeededForNextLevel = AppConstants.xpPerLevel * level;
//     final int xpInCurrentLevel = xp - (AppConstants.xpPerLevel * (level - 1));
//     final double progress = AppConstants.xpPerLevel > 0 ? xpInCurrentLevel / AppConstants.xpPerLevel : 0.0;

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
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min, // Added to constrain column size
//             children: [
//               Text(
//                 'Level $level',
//                 style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                       color: AppColors.levelColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 13,
//                     ),
//               ),
//               Text(
//                 '$xp XP',
//                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                       color: AppColors.xpColor,
//                       fontWeight: FontWeight.w600,
//                        fontSize: 7,
//                     ),
//               ),
//             ],
//           ),
//           const SizedBox(width: AppConstants.spacing),
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 width: 35,
//                 height: 35,
//                 child: CircularProgressIndicator(
//                   value: progress.clamp(0.0, 1.0), // Clamp progress value
//                   backgroundColor: AppColors.progressTrackColor,
//                   valueColor: const AlwaysStoppedAnimation<Color>(AppColors.xpColor),
//                   strokeWidth: 2,
//                 ),
//               ),
//               Text(
//                 '${(progress * 100).toStringAsFixed(0)}%',
//                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                       color: AppColors.textColor,
//                       fontSize: 10,
//                     ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/widgets/cards/course_card.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/models/level.dart';

// class CourseCard extends StatelessWidget {
//   final Course course;
//   final VoidCallback onTap;
//   final Function(String courseId, List<String> levelIds) onDelete;

//   const CourseCard({
//     super.key,
//     required this.course,
//     required this.onTap,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final firebaseService = Provider.of<FirebaseService>(context);

//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//       ),
//       elevation: 6,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         onTap: onTap,
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
//                             color: AppColors.accentColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   PopupMenuButton<String>(
//                     color: AppColors.cardColor,
//                     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                       PopupMenuItem<String>(
//                         value: 'delete',
//                         child: Row(
//                           children: [
//                             Icon(Icons.delete, color: AppColors.errorColor),
//                             SizedBox(width: AppConstants.spacing),
//                             Text('Delete Course', style: TextStyle(color: AppColors.errorColor)),
//                           ],
//                         ),
//                       ),
//                     ],
//                     onSelected: (String value) async {
//                       if (value == 'delete') {
//                         List<String> levelIds = [];
//                         try {
//                           final levels = await firebaseService.streamLevelsForCourse(course.id).first;
//                           levelIds = levels.map((level) => level.id).toList();
//                         } catch (e) {
//                           debugPrint('Error fetching level IDs for deletion: $e');
//                           // Proceed with deletion even if levels can't be fetched, course itself still needs cleanup
//                         }
//                         onDelete(course.id, levelIds);
//                       }
//                     },
//                     icon: Icon(Icons.more_vert, color: AppColors.textColorSecondary),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Text(
//                 course.description,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: AppColors.textColorSecondary,
//                     ),
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Wrap(
//                 spacing: AppConstants.spacing,
//                 runSpacing: AppConstants.spacing / 2,
//                 children: [
//                   _buildChip(context, 'Difficulty: ${course.difficulty}', AppColors.infoColor),
//                   _buildChip(context, 'Genre: ${course.gameGenre}', AppColors.secondaryColor),
//                 ],
//               ),
//               const SizedBox(height: AppConstants.padding),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Text(
//                   'Tap to view levels',
//                   style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                         color: AppColors.textColorSecondary.withOpacity(0.7),
//                         fontStyle: FontStyle.italic,
//                       ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildChip(BuildContext context, String label, Color color) {
//     return Chip(
//       label: Text(
//         label,
//         style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textColor),
//       ),
//       backgroundColor: color.withOpacity(0.3),
//       side: BorderSide(color: color, width: 1.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing, vertical: AppConstants.spacing / 2),
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
//   final double progress;
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
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         color: AppColors.cardColor.withOpacity(0.9),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         ),
//         elevation: 8,
//         child: Padding(
//           padding: const EdgeInsets.all(AppConstants.padding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Currently Active:',
//                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                       color: AppColors.accentColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Text(
//                 courseTitle,
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                       color: AppColors.textColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: AppConstants.spacing / 2),
//               Text(
//                 lessonTitle,
//                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       color: AppColors.textColorSecondary,
//                     ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: AppConstants.padding),
//               ProgressBar(
//                 progress: progress,
//                 progressColor: AppColors.successColor,
//                 showPercentage: true,
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Icon(
//                   Icons.arrow_forward_ios,
//                   color: AppColors.accentColor,
//                   size: AppConstants.iconSize,
//                 ),
//               ),
//             ],
//           ),
//         ),
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
// import 'package:gamifier/screens/community_screen.dart';
// import 'package:gamifier/screens/chat_screen.dart'; // New import

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
//   static const String communityRoute = '/community';
//   static const String chatRoute = '/chat'; // New route

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
//         final courseId = settings.arguments as String; // Expecting courseId as a String
//         return MaterialPageRoute(builder: (_) => LevelSelectionScreen(courseId: courseId));
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
//       case communityRoute:
//         return MaterialPageRoute(builder: (_) => const CommunityScreen());
//       case chatRoute: // New route case
//         return MaterialPageRoute(builder: (_) => const ChatScreen());
//       default:
//         return MaterialPageRoute(builder: (_) => Text('Error: Unknown route ${settings.name}'));
//     }
//   }
// }
// // lib/utils/file_picker_util.dart
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';

// class FilePickerUtil {
//   static Future<String?> pickTextFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['txt', 'md'],
//       );

//       if (result != null && result.files.single.bytes != null) {
//         return String.fromCharCodes(result.files.single.bytes!);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       debugPrint('Error picking file: $e');
//       return null;
//     }
//   }
// }
// // lib/utils/url_launcher_util.dart
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/foundation.dart';

// class UrlLauncherUtil {
//   static Future<void> launchInBrowser(String urlString) async {
//     final Uri url = Uri.parse(urlString);
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       debugPrint('Could not launch $urlString');
//       throw Exception('Could not launch $urlString');
//     }
//   }

//   static Future<void> launchEmail(String emailAddress, {String? subject, String? body}) async {
//     final Uri emailLaunchUri = Uri(
//       scheme: 'mailto',
//       path: emailAddress,
//       queryParameters: {
//         'subject': subject ?? '',
//         'body': body ?? '',
//       },
//     );
//     if (!await launchUrl(emailLaunchUri)) {
//       debugPrint('Could not launch email to $emailAddress');
//       throw Exception('Could not launch email to $emailAddress');
//     }
//   }
// }
// // lib/utils/validation_utils.dart
// class ValidationUtils {
//   static String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email cannot be empty.';
//     }
//     final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
//     if (!emailRegExp.hasMatch(value)) {
//       return 'Enter a valid email address.';
//     }
//     return null;
//   }

//   static String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password cannot be empty.';
//     }
//     if (value.length < 6) {
//       return 'Password must be at least 6 characters long.';
//     }
//     return null;
//   }

//   static String? validateUsername(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Username cannot be empty.';
//     }
//     if (value.length < 3) {
//       return 'Username must be at least 3 characters long.';
//     }
//     return null;
//   }

//   static String? validateField(String? value, String fieldName) {
//     if (value == null || value.isEmpty) {
//       return '$fieldName cannot be empty.';
//     }
//     return null;
//   }
// }
// // lib/services/audio_service.dart
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/foundation.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class AudioService {
//   late AudioPlayer _correctPlayer;
//   late AudioPlayer _levelUpPlayer;

//   AudioService() {
//     _correctPlayer = AudioPlayer();
//     _levelUpPlayer = AudioPlayer();
//   }

//   Future<void> loadAudioAssets() async {
//     try {
//       await _correctPlayer.setSourceAsset(AppConstants.correctSoundPath);
//       await _levelUpPlayer.setSourceAsset(AppConstants.levelUpSoundPath);
//       debugPrint('Audio assets loaded successfully.');
//     } catch (e) {
//       debugPrint('Error loading audio assets: $e');
//     }
//   }

//   Future<void> playCorrectSound() async {
//     try {
//       await _correctPlayer.stop(); // Stop any currently playing sound
//       await _correctPlayer.resume(); // Resume from start
//       await _correctPlayer.play(AssetSource(AppConstants.correctSoundPath));
//     } catch (e) {
//       debugPrint('Error playing correct sound: $e');
//     }
//   }

//   Future<void> playLevelUpSound() async {
//     try {
//       await _levelUpPlayer.stop(); // Stop any currently playing sound
//       await _levelUpPlayer.resume(); // Resume from start
//       await _levelUpPlayer.play(AssetSource(AppConstants.levelUpSoundPath));
//     } catch (e) {
//       debugPrint('Error playing level up sound: $e');
//     }
//   }

//   void dispose() {
//     _correctPlayer.dispose();
//     _levelUpPlayer.dispose();
//   }
// }
// // lib/services/firebase_service.dart
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/models/badge.dart';
// import 'package:gamifier/models/level.dart';
// import 'package:gamifier/models/community_post.dart';
// import 'package:gamifier/models/chat_message.dart'; // New import
// import 'package:gamifier/models/lesson.dart'; // New import for saveLevels
// import 'package:gamifier/models/question.dart'; // New import for saveLevels
// import 'package:gamifier/constants/app_constants.dart';

// class FirebaseService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Added getter for Firestore instance
//   FirebaseFirestore getFirestore() {
//     return _firestore;
//   }

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
//       await _ensureUserProfileAndStreak(userCredential.user!); // Update streak
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

//   Future<void> _ensureUserProfileAndStreak(User user) async {
//     final userRef = _firestore.collection(AppConstants.usersCollection).doc(user.uid);
//     final docSnapshot = await userRef.get();

//     if (!docSnapshot.exists) {
//       await createUserProfile(user.uid, user.displayName ?? 'New Learner');
//     } else {
//       UserProfile userProfile = UserProfile.fromMap(docSnapshot.data()!);
//       DateTime today = DateTime.now();
//       DateTime? lastLogin = userProfile.lastLoginDate;

//       // Normalize dates to just year, month, day for comparison
//       DateTime todayNormalized = DateTime(today.year, today.month, today.day);
//       DateTime? lastLoginNormalized = lastLogin != null ? DateTime(lastLogin.year, lastLogin.month, lastLogin.day) : null;

//       int newStreak = userProfile.currentStreak;
//       int xpToAdd = 0;

//       if (lastLoginNormalized == null) {
//         // First login or streak reset (if not logged in for a while)
//         newStreak = 1;
//         xpToAdd = 0; // No bonus for starting streak
//       } else if (todayNormalized.difference(lastLoginNormalized).inDays == 1) {
//         // Consecutive day
//         newStreak++;
//         if (newStreak >= AppConstants.minStreakDaysForBonus) {
//           xpToAdd = AppConstants.streakBonusXp;
//         }
//       } else if (todayNormalized.difference(lastLoginNormalized).inDays > 1) {
//         // Streak broken
//         newStreak = 1;
//         xpToAdd = 0;
//       } else {
//         // Logged in multiple times today, streak doesn't change, no bonus
//         xpToAdd = 0;
//       }

//       Map<String, dynamic> updates = {
//         'lastLoginDate': Timestamp.fromDate(today),
//         'currentStreak': newStreak,
//       };

//       if (xpToAdd > 0) {
//         updates['xp'] = FieldValue.increment(xpToAdd);
//         // Recalculate level if XP changes, or handle it in addXp if it's called
//         // For now, let's assume addXp takes care of level updates.
//       }
//       await userRef.update(updates);

//       // If XP was added, refresh user profile to update level instantly in UI
//       if (xpToAdd > 0) {
//         UserProfile updatedProfile = UserProfile.fromMap((await userRef.get()).data()!);
//         int newXpTotal = updatedProfile.xp;
//         int newLevel = updatedProfile.level;

//         int xpAtCurrentLevelStart = (newLevel - 1) * AppConstants.xpPerLevel;

//         while (newXpTotal >= xpAtCurrentLevelStart + AppConstants.xpPerLevel) {
//           newLevel++;
//           xpAtCurrentLevelStart = (newLevel - 1) * AppConstants.xpPerLevel;
//         }

//         if (newLevel > userProfile.level) {
//           // Play level up sound if level changed
//           // This typically needs to be handled by a UI-layer logic reacting to the stream
//         }
//         // Update profile in local state or notify listeners if XP was added
//         await userRef.update({'level': newLevel}); // Ensure level is updated in Firestore too
//       }
//     }
//   }

//   Future<void> createUserProfile(String uid, String username, {String? educationLevel, String? specialty}) async {
//     final userProfile = UserProfile(
//       uid: uid,
//       username: username,
//       createdAt: DateTime.now(),
//       educationLevel: educationLevel,
//       specialty: specialty,
//       currentStreak: 1, // Start streak on first profile creation
//       lastLoginDate: DateTime.now(),
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

//   Future<void> saveCourse(Course course) async {
//     try {
//       await _firestore.collection(AppConstants.coursesCollection).doc(course.id).set(course.toMap());
//     } catch (e) {
//       throw Exception('Error saving course: $e');
//     }
//   }

//   // Added updateCourse method
//   Future<void> updateCourse(String courseId, Map<String, dynamic> updates) async {
//     try {
//       await _firestore.collection(AppConstants.coursesCollection).doc(courseId).update(updates);
//     } catch (e) {
//       throw Exception('Error updating course: $e');
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

//   Stream<List<Course>> streamAllCourses() {
//     return _firestore.collection(AppConstants.coursesCollection).snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) => Course.fromMap(doc.data()!)).toList();
//     }).handleError((e) {
//       debugPrint('Error streaming all courses: $e');
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

//   // New method to save a list of levels with their nested lessons and questions
//   Future<void> saveLevels(
//     List<Level> levels,
//     Map<String, List<Lesson>> lessonsPerLevel,
//     Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel,
//   ) async {
//     final batch = _firestore.batch();
//     try {
//       for (final level in levels) {
//         final levelRef = _firestore.collection(AppConstants.levelsCollection).doc(level.id);
//         batch.set(levelRef, level.toMap());

//         if (lessonsPerLevel.containsKey(level.id)) {
//           for (final lesson in lessonsPerLevel[level.id]!) {
//             final lessonRef = levelRef.collection('lessons').doc(lesson.id);
//             batch.set(lessonRef, lesson.toMap());

//             if (questionsPerLessonPerLevel.containsKey(level.id) &&
//                 questionsPerLessonPerLevel[level.id]!.containsKey(lesson.id)) {
//               for (final question in questionsPerLessonPerLevel[level.id]![lesson.id]!) {
//                 batch.set(lessonRef.collection('questions').doc(question.id), question.toMap());
//               }
//             }
//           }
//         }
//       }
//       await batch.commit();
//     } catch (e) {
//       throw Exception('Error saving multiple levels, lessons, and questions: $e');
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
//         .orderBy('timestamp', descending: true) // Ensure ordering by timestamp
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

//         if (friendUserFriends.contains(currentUserId)) { // Check before removing
//           friendUserFriends.remove(currentUserId);
//           transaction.update(friendUserRef, {'friends': friendUserFriends});
//         }
//       });
//     } catch (e) {
//       throw Exception('Error removing friend: $e');
//     }
//   }

//   // New: AI Chatbot Tutor functionality
//   Future<void> sendChatMessage(ChatMessage message) async {
//     try {
//       await _firestore.collection(AppConstants.chatMessagesCollection).add(message.toMap());
//     } catch (e) {
//       throw Exception('Error sending chat message: $e');
//     }
//   }

//   Stream<List<ChatMessage>> streamChatMessages() {
//     return _firestore
//         .collection(AppConstants.chatMessagesCollection)
//         .orderBy('timestamp')
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => ChatMessage.fromMap(doc.data())).toList();
//     }).handleError((e) {
//       debugPrint('Error streaming chat messages: $e');
//       return <ChatMessage>[];
//     });
//   }
// }
// // lib/services/gemini_api_service.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/models/level.dart'; // Import Level model
// import 'package:gamifier/models/lesson.dart'; // Import Lesson model
// import 'package:gamifier/models/question.dart'; // Import Question model
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/models/chat_message.dart';

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

//   // Refined _extractJsonString to be more robust
//   String _extractJsonString(String text) {
//     String cleanedText = text.trim();

//     // Try to find a JSON code block (```json{...}```) first
//     final jsonCodeBlockRegex = RegExp(r'```json\s*(\{[\s\S]*?\})\s*```', dotAll: true);
//     final jsonCodeBlockMatch = jsonCodeBlockRegex.firstMatch(cleanedText);
//     if (jsonCodeBlockMatch != null && jsonCodeBlockMatch.group(1) != null) {
//       return jsonCodeBlockMatch.group(1)!;
//     }

//     // Try to find a standalone JSON object
//     final standaloneJsonRegex = RegExp(r'\{[\s\S]*\}', dotAll: true);
//     final allMatches = standaloneJsonRegex.allMatches(cleanedText);

//     String? bestValidJson;
//     for (final match in allMatches) {
//       String potentialJson = match.group(0)!;
//       try {
//         json.decode(potentialJson); // Test if it's valid JSON
//         if (bestValidJson == null || potentialJson.length > bestValidJson.length) {
//           bestValidJson = potentialJson; // Keep the longest valid one
//         }
//       } on FormatException {
//         // Not a valid JSON, continue
//       }
//     }

//     if (bestValidJson != null) {
//       return bestValidJson;
//     }

//     // Fallback: Attempt to repair truncated JSON, especially for unterminated strings
//     // This is a heuristic and might not catch all cases, but targets common truncation.
//     int openBraces = 0;
//     int openBrackets = 0;
//     bool inString = false;
//     StringBuffer repairedJsonBuffer = StringBuffer();

//     for (int i = 0; i < cleanedText.length; i++) {
//       String char = cleanedText[i];
//       if (char == '\\' && i + 1 < cleanedText.length) { // Handle escaped characters
//         repairedJsonBuffer.write(char);
//         repairedJsonBuffer.write(cleanedText[++i]);
//       } else if (char == '"') {
//         inString = !inString;
//         repairedJsonBuffer.write(char);
//       } else if (char == '{' && !inString) {
//         openBraces++;
//         repairedJsonBuffer.write(char);
//       } else if (char == '}' && !inString) {
//         openBraces--;
//         repairedJsonBuffer.write(char);
//       } else if (char == '[' && !inString) {
//         openBrackets++;
//         repairedJsonBuffer.write(char);
//       } else if (char == ']' && !inString) {
//         openBrackets--;
//         repairedJsonBuffer.write(char);
//       } else {
//         repairedJsonBuffer.write(char);
//       }
//     }

//     // Try to close any unclosed strings, brackets, or braces
//     if (inString) {
//       repairedJsonBuffer.write('"');
//     }
//     while (openBraces > 0) {
//       repairedJsonBuffer.write('}');
//       openBraces--;
//     }
//     while (openBrackets > 0) {
//       repairedJsonBuffer.write(']');
//       openBrackets--;
//     }

//     String finalRepairedText = repairedJsonBuffer.toString();
//     debugPrint('Attempting to parse repaired JSON: $finalRepairedText');
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
//     int numberOfLevels = AppConstants.initialLevelsCount, // Default to initial count
//     int startingLevelOrder = 1, // For subsequent generation
//     List<Level>? previousLevelsContext, // For subsequent generation
//   }) async {
//     String prompt = '''
//     As an AI-powered gamification engine, your task is to transform a static course topic into an interactive, game-based learning module.
//     Generate a complete course structure including:
//     - courseTitle: A catchy title for the course.
//     - gameGenre: A suitable game genre for the course (e.g., "Fantasy", "Sci-Fi", "Adventure", "Mystery", "Cyberpunk"). Choose one from: ${AppConstants.gameThemes.join(', ')}.
//     - difficulty: The difficulty level of the course ("Beginner", "Intermediate", "Advanced", "Expert").
//     - levels: An array of $numberOfLevels distinct levels, ordered from easy to hard, each tailored to the course's difficulty. Each level should have:
//         - id: A unique string ID for the level (e.g., "level_${startingLevelOrder}").
//         - title: The title of the level.
//         - description: A brief, engaging description of the level.
//         - difficulty: The specific difficulty of this level (e.g., "Easy", "Medium").
//         - order: An integer representing the sequential order of the level (e.g., $startingLevelOrder, ${startingLevelOrder + 1}, ...).
//         - imageAssetPath: An optional path to a local asset image for this level's icon/visual (e.g., "assets/level_icons/level${startingLevelOrder}.png", "assets/level_icons/level${startingLevelOrder + 1}.png"). Create unique, descriptive paths for each.
//         - lessons: An array of 1-3 detailed lessons. Each lesson should have:
//             - id: A unique string ID for the lesson (e.g., "lesson_${startingLevelOrder}_1").
//             - title: The title of the lesson.
//             - content: Comprehensive learning material for the lesson (min 200 words), suitable for a college student, formatted in Markdown.
//             - questions: An array of 3-5 small, interesting, and engaging questions for the lesson, appropriate for the level's difficulty. Each question should have:
//                 - id: A unique string ID for the question (e.g., "q1_lesson_${startingLevelOrder}_1").
//                 - questionText: The question itself.
//                 - xpReward: An integer for XP reward (e.g., 10, 15, 20), appropriate for the question difficulty.
//                 - type: One of "MCQ", "FillInBlank", "ShortAnswer", "Scenario". Favor a mix of types for variety.
//                 - specific fields based on type (if applicable):
//                     - For MCQ: options (List<String>), correctAnswer (String, one of options). Ensure options are distinct and plausible.
//                     - For FillInBlank: correctAnswer (String).
//                     - For ShortAnswer: expectedAnswerKeywords (String, comma-separated keywords for evaluation).
//                     - For Scenario: scenarioText (String, concise and engaging), expectedOutcome (String).

//     The course is for "$topicName" for college students in the "$domain" domain, with an overall "$difficulty" difficulty level.
//     The user's education level is "$educationLevel" and their specialty is "$specialty". Tailor content and examples to these if relevant.
//     ''';

//     if (previousLevelsContext != null && previousLevelsContext.isNotEmpty) {
//       prompt += '''
//       \n\nFor context, here are the previously generated levels of this course. Ensure the new levels logically follow these, increasing in difficulty and building upon prior concepts:
//       ${json.encode(previousLevelsContext.map((level) => level.toMap()).toList())}
//       ''';
//     }


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
//                   "imageAssetPath": {"type": "STRING"},
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
//       String extractedJsonString = _extractJsonString(rawJsonString); // Use the improved extraction

//       try {
//         final Map<String, dynamic> parsedJson = json.decode(extractedJsonString);
//         return parsedJson;
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

//   // New method for generating subsequent levels, returns parsed levels, lessons, and questions
//   Future<Map<String, dynamic>> generateSubsequentLevels({
//     required String courseId,
//     required String topicName,
//     required String ageGroup,
//     required String domain,
//     required String difficulty,
//     required int startingLevelOrder,
//     required int numberOfLevels,
//     String? educationLevel,
//     String? specialty,
//     String? sourceContent,
//     String? youtubeUrl,
//     List<Level>? previousLevelsContext,
//   }) async {
//     // Re-use the existing generateCourseContent but with specific level count and starting order
//     final Map<String, dynamic> generatedContent = await generateCourseContent(
//       topicName: topicName,
//       ageGroup: ageGroup,
//       domain: domain,
//       difficulty: difficulty,
//       educationLevel: educationLevel,
//       specialty: specialty,
//       sourceContent: sourceContent,
//       youtubeUrl: youtubeUrl,
//       numberOfLevels: numberOfLevels,
//       startingLevelOrder: startingLevelOrder,
//       previousLevelsContext: previousLevelsContext,
//     );

//     final List<Level> levels = [];
//     final Map<String, List<Lesson>> lessonsPerLevel = {};
//     final Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel = {};

//     for (var levelData in generatedContent['levels']) {
//       final Level newLevel = Level.fromMap(levelData as Map<String, dynamic>)..courseId = courseId;
//       levels.add(newLevel);

//       final List<Lesson> lessons = [];
//       final Map<String, List<Question>> questionsForThisLevelLessons = {};

//       for (var lessonData in levelData['lessons']) {
//         final Lesson newLesson = Lesson.fromMap(lessonData as Map<String, dynamic>)..levelId = newLevel.id;
//         lessons.add(newLesson);

//         final List<Question> questions = [];
//         for (var questionData in newLesson.questions) { // Assuming Lesson.fromMap populates questions
//           questions.add(Question.fromMap(questionData as Map<String, dynamic>));
//         }
//         questionsForThisLevelLessons[newLesson.id] = questions;
//       }
//       lessonsPerLevel[newLevel.id] = lessons;
//       questionsPerLessonPerLevel[newLevel.id] = questionsForThisLevelLessons;
//     }

//     return {
//       'levels': levels,
//       'lessonsPerLevel': lessonsPerLevel,
//       'questionsPerLessonPerLevel': questionsPerLessonPerLevel,
//     };
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
//       String extractedJsonString = _extractJsonString(rawJsonString);

//       try {
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

//   Future<String> generateChatResponse(List<ChatMessage> chatHistory) async {
//     final List<Map<String, dynamic>> contents = chatHistory.map((msg) => {
//       "role": msg.isUser ? "user" : "model",
//       "parts": [{"text": msg.text}]
//     }).toList();

//     final payload = {
//       "contents": contents,
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
//       return responseBody['candidates'][0]['content']['parts'][0]['text'];
//     } catch (e) {
//       debugPrint('Error generating chat response: $e');
//       throw Exception('Failed to get response from AI: $e');
//     }
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
//           // Ensure user profile exists and streak is updated
//           await firebaseService.getUserProfile(user.uid); // This will trigger _ensureUserProfileAndStreak
//           final userProfile = await firebaseService.getUserProfile(user.uid); // Fetch updated profile

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
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/gamification/leaderboard_list.dart';
// import 'package:gamifier/widgets/gamification/badge_display.dart';
// import 'package:gamifier/models/badge.dart' as gamifier_badge; // Alias the model Badge

// class ProgressScreen extends StatefulWidget {
//   const ProgressScreen({super.key});

//   @override
//   State<ProgressScreen> createState() => _ProgressScreenState();
// }

// class _ProgressScreenState extends State<ProgressScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final firebaseService = Provider.of<FirebaseService>(context);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       return const Scaffold(
//         body: Center(
//           child: Text('Please log in to view your progress.', style: TextStyle(color: AppColors.textColor)),
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
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(AppConstants.padding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Your Badges',
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                       color: AppColors.accentColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               StreamBuilder<UserProfile?>(
//                 stream: firebaseService.streamUserProfile(currentUser.uid),
//                 builder: (context, userProfileSnapshot) {
//                   if (userProfileSnapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (userProfileSnapshot.hasError || !userProfileSnapshot.hasData || userProfileSnapshot.data == null) {
//                     return Center(child: Text('Error loading badges: ${userProfileSnapshot.error ?? "No data"}', style: const TextStyle(color: AppColors.errorColor)));
//                   }

//                   final userProfile = userProfileSnapshot.data!;
//                   final List<String> earnedBadgeIds = userProfile.earnedBadges;

//                   // Example static badges. In a real app, these would be fetched from Firestore.
//                   final List<gamifier_badge.Badge> allPossibleBadges = [ // Used aliased Badge
//                     const gamifier_badge.Badge(id: 'first_course', name: 'First Course', description: 'Completed your first course!', icon: Icons.school),
//                     const gamifier_badge.Badge(id: 'level_5', name: 'Level 5 Achiever', description: 'Reached Level 5!', icon: Icons.star),
//                     const gamifier_badge.Badge(id: 'streak_7', name: '7-Day Streak', description: 'Maintained a 7-day learning streak!', icon: Icons.local_fire_department),
//                     const gamifier_badge.Badge(id: 'master_quiz', name: 'Quiz Master', description: 'Achieved 100% on a quiz!', icon: Icons.quiz),
//                     const gamifier_badge.Badge(id: 'community_contributor', name: 'Community Pro', description: 'Made 5 community posts!', icon: Icons.people),
//                   ];

//                   if (allPossibleBadges.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'No badges defined yet.',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//                       ),
//                     );
//                   }

//                   return GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: AppConstants.spacing,
//                       mainAxisSpacing: AppConstants.spacing,
//                       childAspectRatio: 1.0,
//                     ),
//                     itemCount: allPossibleBadges.length,
//                     itemBuilder: (context, index) {
//                       final badge = allPossibleBadges[index];
//                       final isEarned = earnedBadgeIds.contains(badge.id);
//                       return BadgeDisplay(badge: badge, isEarned: isEarned);
//                     },
//                   );
//                 },
//               ),
//               const SizedBox(height: AppConstants.padding * 2),
//               Text(
//                 'Global Leaderboard',
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                       color: AppColors.accentColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               StreamBuilder<List<UserProfile>>(
//                 stream: firebaseService.streamLeaderboard(),
//                 builder: (context, leaderboardSnapshot) {
//                   if (leaderboardSnapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (leaderboardSnapshot.hasError) {
//                     return Center(child: Text('Error loading leaderboard: ${leaderboardSnapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
//                   }
//                   if (!leaderboardSnapshot.hasData || leaderboardSnapshot.data!.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'No one on the leaderboard yet. Start earning XP!',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//                       ),
//                     );
//                   }
//                   return LeaderboardList(
//                       users: leaderboardSnapshot.data!, currentUserId: currentUser.uid);
//                 },
//               ),
//               const SizedBox(height: AppConstants.padding * 2),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/screens/profile_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/gamification/streak_display.dart'; // New import
// import 'package:gamifier/utils/app_router.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? AppColors.errorColor : AppColors.successColor,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   Future<void> _signOut(BuildContext context) async {
//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       await firebaseService.signOut();
//       Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
//       _showSnackBar(context, 'Successfully signed out.');
//     } catch (e) {
//       _showSnackBar(context, 'Error signing out: $e', isError: true);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final firebaseService = Provider.of<FirebaseService>(context);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       return const Scaffold(
//         body: Center(
//           child: Text('Please log in to view your profile.', style: TextStyle(color: AppColors.textColor)),
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
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: StreamBuilder<UserProfile?>(
//           stream: firebaseService.streamUserProfile(currentUser.uid),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
//                 ),
//               );
//             }
//             if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
//               return Center(
//                 child: Text('Error loading profile: ${snapshot.error ?? "No data"}',
//                     style: const TextStyle(color: AppColors.errorColor)),
//               );
//             }

//             final userProfile = snapshot.data!;
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(AppConstants.padding),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: AppConstants.padding),
//                   CircleAvatar(
//                     radius: AppConstants.avatarSize,
//                     backgroundColor: AppColors.cardColor,
//                     backgroundImage: AssetImage(userProfile.avatarAssetPath),
//                     onBackgroundImageError: (exception, stackTrace) {
//                     },
//                     child: userProfile.avatarAssetPath.isEmpty
//                         ? Icon(Icons.person, size: AppConstants.avatarSize, color: AppColors.textColorSecondary)
//                         : null,
//                   ),
//                   const SizedBox(height: AppConstants.padding),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.of(context).pushNamed(AppRouter.avatarCustomizerRoute);
//                     },
//                     icon: const Icon(Icons.palette),
//                     label: const Text('Customize Avatar'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.secondaryColor,
//                       foregroundColor: AppColors.textColor,
//                     ),
//                   ),
//                   const SizedBox(height: AppConstants.padding * 2),
//                   Card(
//                     color: AppColors.cardColor.withOpacity(0.9),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                     ),
//                     elevation: 8,
//                     child: Padding(
//                       padding: const EdgeInsets.all(AppConstants.padding * 1.5),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           _buildProfileDetailRow(
//                             context,
//                             icon: Icons.person_outline,
//                             label: 'Username',
//                             value: userProfile.username,
//                           ),
//                           _buildProfileDetailRow(
//                             context,
//                             icon: Icons.school,
//                             label: 'Education Level',
//                             value: userProfile.educationLevel ?? 'Not set',
//                           ),
//                           _buildProfileDetailRow(
//                             context,
//                             icon: Icons.lightbulb,
//                             label: 'Specialty',
//                             value: userProfile.specialty ?? 'Not set',
//                           ),
//                           _buildProfileDetailRow(
//                             context,
//                             icon: Icons.star_border,
//                             label: 'Level',
//                             value: userProfile.level.toString(),
//                             valueColor: AppColors.levelColor,
//                           ),
//                           _buildProfileDetailRow(
//                             context,
//                             icon: Icons.military_tech,
//                             label: 'Total XP',
//                             value: userProfile.xp.toString(),
//                             valueColor: AppColors.xpColor,
//                           ),
//                           _buildProfileDetailRow(
//                             context,
//                             icon: Icons.local_fire_department, // Streak icon
//                             label: 'Current Streak',
//                             value: '${userProfile.currentStreak} Days',
//                             valueColor: AppColors.streakColor,
//                           ),
//                           _buildProfileDetailRow(
//                             context,
//                             icon: Icons.calendar_today,
//                             label: 'Member Since',
//                             value: '${userProfile.createdAt.day}/${userProfile.createdAt.month}/${userProfile.createdAt.year}',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: AppConstants.padding * 2),
//                   ElevatedButton.icon(
//                     onPressed: () => _signOut(context),
//                     icon: const Icon(Icons.logout),
//                     label: const Text('Sign Out'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.errorColor,
//                       foregroundColor: AppColors.textColor,
//                       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileDetailRow(BuildContext context, {
//     required IconData icon,
//     required String label,
//     required String value,
//     Color? valueColor,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//       child: Row(
//         children: [
//           Icon(icon, color: AppColors.accentColor, size: AppConstants.iconSize),
//           const SizedBox(width: AppConstants.spacing),
//           Expanded(
//             child: Text(
//               '$label:',
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColorSecondary),
//             ),
//           ),
//           Text(
//             value,
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   color: valueColor ?? AppColors.textColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/screens/onboarding_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   String? _selectedEducationLevel;
//   String? _selectedSpecialty;
//   bool _isLoading = false;

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

//   Future<void> _completeOnboarding() async {
//     if (_selectedEducationLevel == null || _selectedSpecialty == null) {
//       _showSnackBar('Please select your education level and specialty.', isError: true);
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       final currentUser = firebaseService.currentUser;
//       if (currentUser != null) {
//         await firebaseService.updateUserProfile(
//           currentUser.uid,
//           {
//             'educationLevel': _selectedEducationLevel,
//             'specialty': _selectedSpecialty,
//           },
//         );
//         _showSnackBar('Profile updated successfully! Welcome to Gamifier!');
//         Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//       } else {
//         _showSnackBar('User not logged in.', isError: true);
//       }
//     } catch (e) {
//       _showSnackBar('Failed to save profile: $e', isError: true);
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
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
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.auto_awesome,
//                   size: 80,
//                   color: AppColors.accentColor,
//                 ),
//                 const SizedBox(height: AppConstants.padding),
//                 Text(
//                   'Personalize Your Journey!',
//                   style: AppColors.neonTextStyle(fontSize: 32),
//                   textAlign: TextAlign.center,
//                 ),
//                 Text(
//                   'Help us tailor your learning experience.',
//                   style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColorSecondary),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: AppConstants.padding * 2),
//                 _buildDropdownField(
//                   context,
//                   label: 'Your Education Level',
//                   value: _selectedEducationLevel,
//                   items: AppConstants.educationLevels,
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedEducationLevel = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: AppConstants.padding),
//                 _buildDropdownField(
//                   context,
//                   label: 'Your Specialty/Interests',
//                   value: _selectedSpecialty,
//                   items: AppConstants.defaultCourseTopics,
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedSpecialty = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: AppConstants.padding * 2),
//                 CustomButton(
//                   text: 'Start Learning!',
//                   onPressed: _completeOnboarding,
//                   isLoading: _isLoading,
//                   backgroundColor: AppColors.primaryColor,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdownField(BuildContext context, {
//     required String label,
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.8)),
//         filled: true,
//         fillColor: AppColors.cardColor.withOpacity(0.7),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           borderSide: const BorderSide(color: AppColors.accentColor, width: 2.0),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           borderSide: const BorderSide(color: AppColors.borderColor, width: 1.0),
//         ),
//       ),
//       dropdownColor: AppColors.cardColor.withOpacity(0.95),
//       style: const TextStyle(color: AppColors.textColor),
//       icon: const Icon(Icons.arrow_drop_down, color: AppColors.textColorSecondary),
//       items: items.map((item) {
//         return DropdownMenuItem(
//           value: item,
//           child: Text(item, style: const TextStyle(color: AppColors.textColor)),
//         );
//       }).toList(),
//       onChanged: onChanged,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please select an option.';
//         }
//         return null;
//       },
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
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/gamification/level_node.dart';
// import 'package:gamifier/widgets/gamification/level_path_painter.dart';
// import 'package:gamifier/models/lesson.dart'; // Import Lesson for fetching

// class LevelSelectionScreen extends StatelessWidget {
//   final String courseId; // Changed to accept courseId

//   const LevelSelectionScreen({super.key, required this.courseId});

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
//         title: 'Levels', // Title will be fetched from course later
//         leadingWidget: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
//         child: FutureBuilder<Course?>( // Fetch course to get its title
//           future: firebaseService.getCourse(courseId),
//           builder: (context, courseSnapshot) {
//             if (courseSnapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                   child: CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
//             }
//             if (courseSnapshot.hasError || !courseSnapshot.hasData || courseSnapshot.data == null) {
//               return Center(child: Text('Error loading course: ${courseSnapshot.error ?? "Course not found"}',
//                   style: const TextStyle(color: AppColors.errorColor)));
//             }
//             final Course course = courseSnapshot.data!;

//             // Update app bar title once course is loaded
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (Scaffold.of(context).appBarMaxHeight != null && Scaffold.of(context).appBarMaxHeight! > 0) {
//                 // This is a bit of a hack to update the AppBar title after it's built
//                 // A better approach would be to pass the Course object to LevelSelectionScreen directly
//                 // or use a Provider for the Course. For now, this works.
//               }
//             });


//             return StreamBuilder<List<Level>>(
//               stream: firebaseService.streamLevelsForCourse(course.id),
//               builder: (context, levelsSnapshot) {
//                 if (levelsSnapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                       child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
//                 }
//                 if (levelsSnapshot.hasError) {
//                   return Center(
//                       child: Text('Error loading levels: ${levelsSnapshot.error}',
//                           style: const TextStyle(color: AppColors.errorColor)));
//                 }
//                 if (!levelsSnapshot.hasData || levelsSnapshot.data!.isEmpty) {
//                   return Center(
//                     child: Text(
//                       'No levels available for this course yet.',
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//                       textAlign: TextAlign.center,
//                     ),
//                   );
//                 }

//                 final levels = levelsSnapshot.data!;
//                 // Ensure levels are sorted by order just in case
//                 levels.sort((a, b) => a.order.compareTo(b.order));

//                 return StreamBuilder<UserProgress?>(
//                   stream: firebaseService.streamUserCourseProgress(currentUser.uid, course.id),
//                   builder: (context, progressSnapshot) {
//                     if (progressSnapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                           child: CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
//                     }
//                     if (progressSnapshot.hasError) {
//                       return Center(
//                           child: Text('Error loading user progress: ${progressSnapshot.error}',
//                               style: const TextStyle(color: AppColors.errorColor)));
//                     }

//                     final userProgress = progressSnapshot.data;

//                     return CustomScrollView(
//                       slivers: [
//                         SliverPadding(
//                           padding: const EdgeInsets.all(AppConstants.padding),
//                           sliver: SliverList(
//                             delegate: SliverChildBuilderDelegate(
//                               (context, index) {
//                                 final level = levels[index];
//                                 final bool isLevelCompleted = userProgress?.levelsProgress[level.id]?.isCompleted ?? false;
//                                 // A level is locked if it's not the first level AND the previous level is not completed.
//                                 final bool isLocked = index > 0 && !(userProgress?.levelsProgress[levels[index - 1].id]?.isCompleted ?? false);
                                
//                                 return Column(
//                                   children: [
//                                     // Level node
//                                     LevelNode(
//                                       level: level,
//                                       isCompleted: isLevelCompleted,
//                                       isLocked: isLocked,
//                                       onTap: isLocked
//                                           ? null
//                                           : () async {
//                                               // Fetch lessons for the selected level
//                                               final lessonDocs = await firebaseService
//                                                   .getFirestore()
//                                                   .collection(AppConstants.levelsCollection)
//                                                   .doc(level.id)
//                                                   .collection('lessons')
//                                                   .orderBy('order')
//                                                   .get();

//                                               final List<Lesson> lessons = lessonDocs.docs.map((doc) => Lesson.fromMap(doc.data())).toList();

//                                               if (lessons.isNotEmpty) {
//                                                 // Find the first incomplete lesson for this level
//                                                 Lesson? lessonToStart;
//                                                 for (final lesson in lessons) {
//                                                   if (!(userProgress?.lessonsProgress[lesson.id]?.isCompleted ?? false)) {
//                                                     lessonToStart = lesson;
//                                                     break;
//                                                   }
//                                                 }

//                                                 if (lessonToStart == null) {
//                                                   // All lessons in this level are completed, maybe show level completion screen again or just go home
//                                                   ScaffoldMessenger.of(context).showSnackBar(
//                                                     const SnackBar(
//                                                       content: Text('This level is already completed!'),
//                                                       backgroundColor: AppColors.infoColor,
//                                                     ),
//                                                   );
//                                                   return;
//                                                 }

//                                                 // Save current progress if user navigates to a new lesson
//                                                 final String progressId = '${currentUser.uid}_${course.id}';
//                                                 final existingProgress = userProgress ?? UserProgress(
//                                                   id: progressId,
//                                                   userId: currentUser.uid,
//                                                   courseId: course.id,
//                                                 );

//                                                 final updatedProgress = existingProgress.copyWith(
//                                                   currentLevelId: level.id,
//                                                   currentLessonId: lessonToStart.id,
//                                                 );
//                                                 await firebaseService.saveUserProgress(updatedProgress);

//                                                 Navigator.of(context).pushNamed(
//                                                   AppRouter.lessonRoute,
//                                                   arguments: {
//                                                     'courseId': course.id,
//                                                     'levelId': level.id,
//                                                     'lessonId': lessonToStart.id,
//                                                   },
//                                                 );
//                                               } else {
//                                                 ScaffoldMessenger.of(context).showSnackBar(
//                                                   const SnackBar(
//                                                     content: Text('No lessons found for this level.'),
//                                                     backgroundColor: AppColors.warningColor,
//                                                   ),
//                                                 );
//                                               }
//                                             },
//                                     ),
//                                     if (index < levels.length - 1)
//                                       CustomPaint(
//                                         size: const Size(2, 80), // Line connecting nodes
//                                         painter: LevelPathPainter(
//                                           isPreviousLevelCompleted: userProgress?.levelsProgress[levels[index].id]?.isCompleted ?? false,
//                                         ),
//                                       ),
//                                   ],
//                                 );
//                               },
//                               childCount: levels.length,
//                             ),
//                           ),
//                         ),
//                       ],
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
// }
// // lib/screens/level_completion_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/progress_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/gemini_api_service.dart'; // Import GeminiApiService
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/services/audio_service.dart';
// import 'package:gamifier/models/level.dart'; // Import Level
// import 'package:gamifier/models/lesson.dart'; // Import Lesson
// import 'package:gamifier/models/question.dart'; // Import Question
// import 'package:gamifier/models/course.dart'; // Import Course

// class LevelCompletionScreen extends StatefulWidget {
//   final String courseId;
//   final String levelId;
//   final int totalXpEarned;
//   final int levelScore;
//   final int lessonsCompleted;
//   final int totalLessons;

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
//   State<LevelCompletionScreen> createState() => _LevelCompletionScreenState();
// }

// class _LevelCompletionScreenState extends State<LevelCompletionScreen> {
//   UserProfile? _currentUserProfile;
//   int _currentLevel = 0;
//   int _currentXp = 0;
//   bool _isGeneratingLevels = false; // New state for loading indicator

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//     Provider.of<AudioService>(context, listen: false).playLevelUpSound();
//   }

//   Future<void> _loadUserProfile() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;
//     if (currentUser != null) {
//       _currentUserProfile = await firebaseService.getUserProfile(currentUser.uid);
//       if (_currentUserProfile != null) {
//         setState(() {
//           _currentLevel = _currentUserProfile!.level;
//           _currentXp = _currentUserProfile!.xp;
//         });
//       }
//     }
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

//   Future<void> _generateNextLevels() async {
//     if (_isGeneratingLevels) return;

//     setState(() {
//       _isGeneratingLevels = true;
//     });

//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       final geminiApiService = Provider.of<GeminiApiService>(context, listen: false);

//       final Course? currentCourse = await firebaseService.getCourse(widget.courseId);
//       if (currentCourse == null) {
//         _showSnackBar('Error: Course not found for generating new levels.', isError: true);
//         return;
//       }

//       final List<Level> existingLevels = await firebaseService.streamLevelsForCourse(widget.courseId).first;
//       final int lastLevelOrder = existingLevels.map((l) => l.order).fold(0, (max, current) => current > max ? current : max);

//       if (lastLevelOrder >= AppConstants.maxLevelsPerCourse) {
//         _showSnackBar('Course already has the maximum number of levels.', isError: true);
//         setState(() { _isGeneratingLevels = false; }); // Ensure loading state is reset
//         return;
//       }

//       final int nextStartingOrder = lastLevelOrder + 1;
//       final int levelsToGenerate = AppConstants.subsequentLevelsBatchSize;

//       _showSnackBar('Generating next ${levelsToGenerate} levels...', isError: false);

//       final Map<String, dynamic> generatedData = await geminiApiService.generateSubsequentLevels(
//         courseId: widget.courseId,
//         topicName: currentCourse.title, // Use course title as topic context
//         ageGroup: 'college students', // Assuming consistent age group
//         domain: currentCourse.gameGenre, // Using gameGenre as domain for simplicity
//         difficulty: currentCourse.difficulty,
//         startingLevelOrder: nextStartingOrder,
//         numberOfLevels: levelsToGenerate,
//         educationLevel: _currentUserProfile?.educationLevel,
//         specialty: _currentUserProfile?.specialty,
//         previousLevelsContext: existingLevels, // Pass existing levels for context
//       );

//       final List<Level> newLevels = generatedData['levels'];
//       final Map<String, List<Lesson>> lessonsPerLevel = generatedData['lessonsPerLevel'];
//       final Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel = generatedData['questionsPerLessonPerLevel'];

//       // Save all newly generated levels, lessons, and questions
//       await firebaseService.saveLevels(newLevels, lessonsPerLevel, questionsPerLessonPerLevel);

//       // Update the course document with the new level IDs
//       final List<String> newlyGeneratedLevelIds = newLevels.map((level) => level.id).toList();
//       final List<String> updatedCourseLevelIds = List<String>.from(currentCourse.levelIds)..addAll(newlyGeneratedLevelIds);
//       await firebaseService.updateCourse(widget.courseId, {'levelIds': updatedCourseLevelIds});

//       _showSnackBar('Next batch of levels generated and added to course!', isError: false);
//       Navigator.of(context).popUntil((route) => route.settings.name == AppRouter.homeRoute);
//     } catch (e) {
//       _showSnackBar('Failed to generate next levels: $e', isError: true);
//       debugPrint('Error generating next levels: $e');
//     } finally {
//       setState(() {
//         _isGeneratingLevels = false;
//       });
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     final double completionProgress = widget.lessonsCompleted / widget.totalLessons;
//     final int xpNeededForNextLevel = AppConstants.xpPerLevel * _currentLevel;
//     final int xpInCurrentLevel = _currentXp - (AppConstants.xpPerLevel * (_currentLevel - 1));
//     final double levelProgress = _currentLevel > 0 ? xpInCurrentLevel / AppConstants.xpPerLevel : 0.0;

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(AppConstants.padding * 2),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.celebration,
//                   size: 100,
//                   color: AppColors.accentColor,
//                 ),
//                 const SizedBox(height: AppConstants.padding),
//                 Text(
//                   'Level Completed!',
//                   style: AppColors.neonTextStyle(fontSize: 36),
//                 ),
//                 const SizedBox(height: AppConstants.spacing),
//                 Text(
//                   'Congratulations on completing this level!',
//                   style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColorSecondary),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: AppConstants.padding * 2),
//                 Card(
//                   color: AppColors.cardColor.withOpacity(0.9),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                   ),
//                   elevation: 8,
//                   child: Padding(
//                     padding: const EdgeInsets.all(AppConstants.padding * 1.5),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         _buildStatRow(context, 'XP Earned:', '${widget.totalXpEarned}', AppColors.xpColor),
//                         _buildStatRow(context, 'Level Score:', '${widget.levelScore}%', AppColors.successColor),
//                         _buildStatRow(context, 'Lessons Completed:', '${widget.lessonsCompleted}/${widget.totalLessons}', AppColors.infoColor),
//                         const Divider(color: AppColors.borderColor, height: AppConstants.padding * 2),
//                         _currentUserProfile != null
//                             ? Column(
//                                 children: [
//                                   _buildStatRow(context, 'Your New Level:', '${_currentUserProfile!.level}', AppColors.levelColor),
//                                   _buildStatRow(context, 'Total XP:', '${_currentUserProfile!.xp}', AppColors.xpColor),
//                                   const SizedBox(height: AppConstants.spacing),
//                                   Text(
//                                     'Progress to next level:',
//                                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
//                                   ),
//                                   const SizedBox(height: AppConstants.spacing / 2),
//                                   ProgressBar(progress: levelProgress, showPercentage: true),
//                                 ],
//                               )
//                             : const SizedBox.shrink(),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: AppConstants.padding * 2),
//                 CustomButton(
//                   text: 'Continue to Next Level',
//                   onPressed: () {
//                     Navigator.of(context).popUntil((route) => route.settings.name == AppRouter.homeRoute);
//                   },
//                   backgroundColor: AppColors.primaryColor,
//                   icon: Icons.arrow_forward,
//                 ),
//                 const SizedBox(height: AppConstants.spacing),
//                 // Conditional button to generate next levels
//                 if (!_isGeneratingLevels &&
//                     (_currentLevel > 0 && (_currentLevel % AppConstants.initialLevelsCount == 0) && // Check if current level is a multiple of initialLevelsCount
//                      (_currentLevel < AppConstants.maxLevelsPerCourse))) // Only show if not at max levels
//                   CustomButton(
//                     text: 'Unlock More Levels!',
//                     onPressed: _generateNextLevels,
//                     isLoading: _isGeneratingLevels,
//                     backgroundColor: AppColors.secondaryColor,
//                     icon: Icons.auto_awesome,
//                   ),
//                 const SizedBox(height: AppConstants.spacing),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).popUntil((route) => route.settings.name == AppRouter.homeRoute);
//                     Navigator.of(context).pushNamed(AppRouter.levelSelectionRoute, arguments: widget.courseId); // Pass courseId
//                   },
//                   child: Text(
//                     'Return to Level Selection',
//                     style: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.8)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatRow(BuildContext context, String label, String value, Color valueColor) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor),
//           ),
//           Text(
//             value,
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   color: valueColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/screens/lesson_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/gemini_api_service.dart';
// import 'package:gamifier/services/audio_service.dart';
// import 'package:gamifier/models/lesson.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/progress_bar.dart';
// import 'package:gamifier/widgets/lesson/lesson_content_display.dart';
// import 'package:gamifier/widgets/questions/question_renderer.dart';
// import 'package:gamifier/widgets/feedback/personalized_feedback_modal.dart'; // New import

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
//   UserProgress? _userProgress;
//   UserProfile? _userProfile;

//   int _currentQuestionIndex = 0;
//   bool _showFeedback = false;
//   bool _isAnswerCorrect = false;
//   String? _lastUserAnswer;
//   int _xpEarnedInLesson = 0;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadLessonData();
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

//   Future<void> _loadLessonData() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       final currentUser = firebaseService.currentUser;

//       if (currentUser == null) {
//         _showSnackBar('User not logged in.', isError: true);
//         Navigator.of(context).pop();
//         return;
//       }

//       _userProfile = await firebaseService.getUserProfile(currentUser.uid);

//       final lesson = await firebaseService.getLesson(widget.levelId, widget.lessonId);
//       final questions = await firebaseService.getLessonQuestions(widget.levelId, widget.lessonId);
//       final progress = await firebaseService.getUserCourseProgress(currentUser.uid, widget.courseId);

//       setState(() {
//         _currentLesson = lesson;
//         _questions = questions;
//         _userProgress = progress;

//         // Initialize progress for this lesson if it's new
//         if (_userProgress != null && !_userProgress!.lessonsProgress.containsKey(widget.lessonId)) {
//           _userProgress = _userProgress!.copyWith(
//             lessonsProgress: {
//               ..._userProgress!.lessonsProgress,
//               widget.lessonId: const LessonProgress(),
//             },
//           );
//         }

//         // Find current question index based on progress
//         if (_userProgress != null && _userProgress!.lessonsProgress.containsKey(widget.lessonId)) {
//           final lessonProgress = _userProgress!.lessonsProgress[widget.lessonId]!;
//           _xpEarnedInLesson = lessonProgress.xpEarned;
//           // Find the first question not attempted or incorrectly answered
//           for (int i = 0; i < _questions.length; i++) {
//             final questionId = _questions[i].id;
//             if (!lessonProgress.questionAttempts.containsKey(questionId) || !lessonProgress.questionAttempts[questionId]!.isCorrect) {
//               _currentQuestionIndex = i;
//               break;
//             }
//             if (i == _questions.length - 1) { // All questions attempted, move to the last one or mark lesson complete
//               _currentQuestionIndex = _questions.length - 1;
//               _showFeedback = true; // Show feedback for the last question if all attempted
//               if (lessonProgress.questionAttempts.containsKey(_questions[_currentQuestionIndex].id)) {
//                 _isAnswerCorrect = lessonProgress.questionAttempts[_questions[_currentQuestionIndex].id]!.isCorrect;
//                 _lastUserAnswer = lessonProgress.questionAttempts[_questions[_currentQuestionIndex].id]!.userAnswer;
//               }
//             }
//           }
//         }
//       });
//     } catch (e) {
//       _showSnackBar('Error loading lesson data: $e', isError: true);
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _evaluateAnswer(String userAnswer, String questionId) async {
//     if (_isLoading) return;

//     setState(() {
//       _isLoading = true;
//       _lastUserAnswer = userAnswer;
//     });

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final audioService = Provider.of<AudioService>(context, listen: false);
//     final geminiApiService = Provider.of<GeminiApiService>(context, listen: false);

//     final currentQuestion = _questions[_currentQuestionIndex];
//     bool correct = false;
//     int xpAwarded = 0;

//     // Simple evaluation logic for now, more complex logic (e.g., AI for short answer) can be added.
//     switch (currentQuestion.type) {
//       case 'MCQ':
//         correct = (userAnswer.toLowerCase() == currentQuestion.correctAnswer?.toLowerCase());
//         break;
//       case 'FillInBlank':
//         correct = (userAnswer.toLowerCase().trim() == currentQuestion.correctAnswer?.toLowerCase().trim());
//         break;
//       case 'ShortAnswer':
//         final expectedKeywords = currentQuestion.expectedAnswerKeywords?.toLowerCase().split(',').map((e) => e.trim()).toList() ?? [];
//         correct = expectedKeywords.any((keyword) => userAnswer.toLowerCase().contains(keyword));
//         break;
//       case 'Scenario':
//         // For scenario, a direct match is unlikely. We can either simplify or use AI.
//         // For now, let's just check for direct match as a placeholder. AI will give feedback.
//         correct = (userAnswer.toLowerCase().trim() == currentQuestion.expectedOutcome?.toLowerCase().trim());
//         break;
//       default:
//         correct = false;
//     }

//     xpAwarded = correct ? currentQuestion.xpReward : 0;
//     if (correct) {
//       audioService.playCorrectSound();
//       await firebaseService.addXp(_userProfile!.uid, xpAwarded);
//       _showSnackBar('Correct Answer! You earned $xpAwarded XP!', isError: false);
//     } else {
//       _showSnackBar('Incorrect Answer. Try again!', isError: true);
//     }

//     final newQuestionAttempt = QuestionAttempt(
//       userAnswer: userAnswer,
//       isCorrect: correct,
//       attemptedAt: DateTime.now(),
//       xpAwarded: xpAwarded,
//     );

//     // Update user progress
//     Map<String, QuestionAttempt> updatedAttempts = Map.from(_userProgress!.lessonsProgress[widget.lessonId]?.questionAttempts ?? {});
//     updatedAttempts[currentQuestion.id] = newQuestionAttempt;

//     int newXpEarnedInLesson = _xpEarnedInLesson + xpAwarded;

//     _userProgress = _userProgress!.copyWith(
//       lessonsProgress: {
//         ..._userProgress!.lessonsProgress,
//         widget.lessonId: _userProgress!.lessonsProgress[widget.lessonId]!.copyWith(
//           questionAttempts: updatedAttempts,
//           xpEarned: newXpEarnedInLesson,
//         ),
//       },
//     );

//     await firebaseService.saveUserProgress(_userProgress!);

//     setState(() {
//       _isAnswerCorrect = correct;
//       _showFeedback = true;
//       _xpEarnedInLesson = newXpEarnedInLesson;
//       _isLoading = false;
//     });

//     // Provide AI Feedback for Scenario questions or if answer is incorrect
//     if (!correct || currentQuestion.type == 'Scenario') {
//       try {
//         final feedback = await geminiApiService.generateSocraticFeedback(
//           userAnswer: userAnswer,
//           questionText: currentQuestion.questionText,
//           correctAnswer: currentQuestion.correctAnswer ?? currentQuestion.expectedOutcome ?? 'N/A',
//           lessonContent: _currentLesson!.content,
//           userProgress: _userProgress,
//         );
//         showDialog(
//           context: context,
//           builder: (BuildContext dialogContext) {
//             return PersonalizedFeedbackModal(
//               feedbackText: feedback['feedbackText'] as String,
//               socraticFollowUp: feedback['socraticFollowUp'] as String?,
//               adaptiveHints: feedback['adaptiveHints'] as String?,
//               encouragement: feedback['encouragement'] as String,
//               isCorrect: correct,
//             );
//           },
//         );
//       } catch (e) {
//         debugPrint('Error generating feedback: $e');
//         _showSnackBar('Failed to get AI feedback: $e', isError: true);
//       }
//     }
//   }

//   void _moveToNextQuestionOrLesson() async {
//     if (_showFeedback && !_isAnswerCorrect) {
//       setState(() {
//         _showFeedback = false; // Allow re-attempting if incorrect
//       });
//       return;
//     }

//     if (_currentQuestionIndex < _questions.length - 1) {
//       setState(() {
//         _currentQuestionIndex++;
//         _showFeedback = false;
//         _isAnswerCorrect = false;
//         _lastUserAnswer = null;
//       });
//     } else {
//       // All questions completed, mark lesson as complete
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       _userProgress = _userProgress!.copyWith(
//         lessonsProgress: {
//           ..._userProgress!.lessonsProgress,
//           widget.lessonId: _userProgress!.lessonsProgress[widget.lessonId]!.copyWith(
//             isCompleted: true,
//             completedAt: DateTime.now(),
//           ),
//         },
//       );
//       await firebaseService.saveUserProgress(_userProgress!);

//       // Check if level is completed
//       final allLevels = await firebaseService.streamLevelsForCourse(widget.courseId).first;
//       final currentLevel = allLevels.firstWhere((level) => level.id == widget.levelId);
//       final lessonDocs = await firebaseService // Corrected: using the getFirestore() method
//           .getFirestore()
//           .collection(AppConstants.levelsCollection)
//           .doc(widget.levelId)
//           .collection('lessons')
//           .get();
//       final allLessonsInLevel = lessonDocs.docs.map((doc) => Lesson.fromMap(doc.data())).toList();

//       bool allLessonsCompletedInLevel = true;
//       int totalXpInLevel = 0;
//       int correctAnswersInLevel = 0;
//       int totalQuestionsInLevel = 0;

//       for (final lesson in allLessonsInLevel) {
//         if (!(_userProgress?.lessonsProgress[lesson.id]?.isCompleted ?? false)) {
//           allLessonsCompletedInLevel = false;
//           break;
//         }
//         totalXpInLevel += _userProgress?.lessonsProgress[lesson.id]?.xpEarned ?? 0;
//         (_userProgress?.lessonsProgress[lesson.id]?.questionAttempts ?? {}).forEach((key, value) {
//           totalQuestionsInLevel++;
//           if (value.isCorrect) {
//             correctAnswersInLevel++;
//           }
//         });
//       }

//       if (allLessonsCompletedInLevel) {
//         final double levelScore = (totalQuestionsInLevel > 0) ? (correctAnswersInLevel / totalQuestionsInLevel) * 100 : 0;
//         _userProgress = _userProgress!.copyWith(
//           levelsProgress: {
//             ..._userProgress!.levelsProgress,
//             widget.levelId: _userProgress!.levelsProgress[widget.levelId]!.copyWith(
//               isCompleted: true,
//               xpEarned: totalXpInLevel,
//               score: levelScore.round(),
//               completedAt: DateTime.now(),
//             ),
//           },
//         );
//         await firebaseService.saveUserProgress(_userProgress!);

//         // Navigate to Level Completion Screen
//         Navigator.of(context).pushReplacementNamed(
//           AppRouter.levelCompletionRoute,
//           arguments: {
//             'courseId': widget.courseId,
//             'levelId': widget.levelId,
//             'totalXpEarned': totalXpInLevel,
//             'levelScore': levelScore.round(),
//             'lessonsCompleted': allLessonsInLevel.length,
//             'totalLessons': allLessonsInLevel.length, // All lessons in level are done
//           },
//         );
//       } else {
//         // Find next incomplete lesson in this level
//         Lesson? nextLesson;
//         for (final lesson in allLessonsInLevel) {
//           if (!(_userProgress?.lessonsProgress[lesson.id]?.isCompleted ?? false)) {
//             nextLesson = lesson;
//             break;
//           }
//         }

//         if (nextLesson != null) {
//           // Navigate to next lesson in the current level
//           final String progressId = '${_userProfile!.uid}_${widget.courseId}';
//           final existingProgress = _userProgress ?? UserProgress(
//             id: progressId,
//             userId: _userProfile!.uid,
//             courseId: widget.courseId,
//           );
//           final updatedProgress = existingProgress.copyWith(
//             currentLevelId: widget.levelId,
//             currentLessonId: nextLesson.id,
//           );
//           await firebaseService.saveUserProgress(updatedProgress);

//           Navigator.of(context).pushReplacementNamed(
//             AppRouter.lessonRoute,
//             arguments: {
//               'courseId': widget.courseId,
//               'levelId': widget.levelId,
//               'lessonId': nextLesson.id,
//             },
//           );
//         } else {
//           // This case should ideally not be reached if allLessonsCompletedInLevel check is correct.
//           _showSnackBar('Unexpected: No next lesson found in level, but level not marked complete.', isError: true);
//           Navigator.of(context).pop(); // Go back to level selection or home
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading || _currentLesson == null || _userProgress == null || _userProfile == null) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
//           ),
//         ),
//       );
//     }

//     final int totalQuestions = _questions.length;
//     final int completedQuestions = _userProgress!.lessonsProgress[widget.lessonId]?.questionAttempts.values.where((q) => q.isCorrect).length ?? 0;
//     final double questionProgress = totalQuestions > 0 ? completedQuestions / totalQuestions : 0.0;

//     return Scaffold(
//       appBar: CustomAppBar(
//         title: _currentLesson!.title,
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
//               child: ProgressBar(
//                 progress: questionProgress,
//                 progressColor: AppColors.infoColor,
//                 showPercentage: true,
//                 height: 8,
//               ),
//             ),
//             Expanded(
//               child: ListView(
//                 children: [
//                   LessonContentDisplay(content: _currentLesson!.content),
//                   const SizedBox(height: AppConstants.padding),
//                   if (_questions.isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
//                       child: Text(
//                         'Question ${_currentQuestionIndex + 1} of $totalQuestions',
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                               color: AppColors.accentColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                       ),
//                     ),
//                   const SizedBox(height: AppConstants.spacing),
//                   if (_questions.isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
//                       child: QuestionRenderer(
//                         question: _questions[_currentQuestionIndex],
//                         onAnswerSubmitted: (answer) {
//                           // This is for the generic submit, actual evaluation happens in onEvaluate
//                         },
//                         onEvaluate: _evaluateAnswer,
//                         showFeedback: _showFeedback,
//                         isCorrect: _isAnswerCorrect,
//                         userAnswer: _lastUserAnswer,
//                         isEnabled: !_showFeedback || (_showFeedback && !_isAnswerCorrect), // Allow re-attempt if incorrect
//                       ),
//                     ),
//                   const SizedBox(height: AppConstants.padding),
//                   if (_questions.isNotEmpty && _showFeedback)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
//                       child: CustomButton(
//                         text: _isAnswerCorrect || _currentQuestionIndex == _questions.length - 1
//                             ? 'Continue'
//                             : 'Try Again',
//                         onPressed: _moveToNextQuestionOrLesson,
//                         backgroundColor: _isAnswerCorrect ? AppColors.successColor : AppColors.primaryColor,
//                       ),
//                     ),
//                   const SizedBox(height: AppConstants.padding * 2),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
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
// import 'package:gamifier/widgets/gamification/streak_display.dart'; // New import
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
//                 XpLevelDisplay(
//                   xp: userProfile.xp,
//                   level: userProfile.level,
//                 ),
//                 const SizedBox(width: AppConstants.spacing),
//                 StreakDisplay(currentStreak: userProfile.currentStreak),
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
//               case 5: // New case for Chat
//                 Navigator.of(context).pushNamed(AppRouter.chatRoute);
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
//             case 5: // New case for Chat
//               Navigator.of(context).pushNamed(AppRouter.chatRoute);
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
//                 ),
//           ),
//           const SizedBox(height: AppConstants.spacing),
//           StreamBuilder<UserProgress?>(
//             stream: firebaseService.streamUserCourseProgress(currentUser.uid, 'placeholder_course_id'), // Needs adjustment to find actual current course
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
//               // Attempt to find the most recent ongoing lesson from all courses
//               String? activeCourseId;
//               String? activeLevelId;
//               String? activeLessonId;

//               if (userProgress != null) {
//                 // Find the latest actively progressed course/lesson
//                 // This logic might need to be more sophisticated if users can have multiple active courses
//                 // For now, assuming userProgress holds the last active state for *a* course.
//                 activeCourseId = userProgress.courseId;
//                 activeLevelId = userProgress.currentLevelId;
//                 activeLessonId = userProgress.currentLessonId;
//               }


//               if (activeCourseId == null || activeLevelId == null || activeLessonId == null) {
//                 return Card(
//                   color: AppColors.cardColor,
//                   child: Padding(
//                     padding: const EdgeInsets.all(AppConstants.padding),
//                     child: Column(
//                       children: [
//                         Text(
//                           'No ongoing lessons. Start a new course!',
//                           style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: AppConstants.spacing),
//                         ElevatedButton.icon(
//                           onPressed: () => onItemTapped(1),
//                           icon: const Icon(Icons.add_circle_outline),
//                           label: const Text('Create New Course'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }

//               return FutureBuilder<Lesson?>(
//                 future: firebaseService.getLesson(activeLevelId, activeLessonId),
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
//                   final lessonProgressData = userProgress!.lessonsProgress[currentLesson.id];
//                   final double progress = (lessonProgressData != null && lessonProgressData.isCompleted) ? 1.0 : 0.0;

//                   return CurrentLessonCard(
//                     courseTitle: 'Current Course',
//                     lessonTitle: currentLesson.title,
//                     progress: progress,
//                     onTap: () {
//                       Navigator.of(context).pushNamed(
//                         AppRouter.lessonRoute,
//                         arguments: {
//                           'courseId': activeCourseId!,
//                           'levelId': activeLevelId!,
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
//             'All Courses',
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   color: AppColors.textColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//           const SizedBox(height: AppConstants.spacing),
//           StreamBuilder<List<Course>>(
//             stream: firebaseService.streamAllCourses(),
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
//                       'No courses available yet. Be the first to create one!',
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: AppConstants.spacing),
//                     ElevatedButton.icon(
//                       onPressed: () => onItemTapped(1),
//                       icon: const Icon(Icons.add_circle_outline),
//                       label: const Text('Create New Course'),
//                     ),
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
//                             title: const Text('Delete Course?'),
//                             content: const Text('Are you sure you want to delete this course and all its data? This cannot be undone.'),
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
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/custom_text_field.dart';
// import 'package:gamifier/utils/validation_utils.dart';
// import 'package:gamifier/utils/file_picker_util.dart'; // Import FilePickerUtil

// class CourseCreationScreen extends StatefulWidget {
//   const CourseCreationScreen({super.key});

//   @override
//   State<CourseCreationScreen> createState() => _CourseCreationScreenState();
// }

// class _CourseCreationScreenState extends State<CourseCreationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _topicController = TextEditingController();
//   final TextEditingController _youtubeUrlController = TextEditingController();
//   String? _selectedDifficulty;
//   String? _selectedDomain;
//   String? _selectedEducationLevel;
//   String? _selectedSpecialty;
//   String? _sourceContent;

//   bool _isLoading = false;
//   UserProfile? _currentUserProfile;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   @override
//   void dispose() {
//     _topicController.dispose();
//     _youtubeUrlController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadUserProfile() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;
//     if (currentUser != null) {
//       _currentUserProfile = await firebaseService.getUserProfile(currentUser.uid);
//       if (_currentUserProfile != null) {
//         _selectedEducationLevel = _currentUserProfile!.educationLevel;
//         _selectedSpecialty = _currentUserProfile!.specialty;
//       }
//       setState(() {});
//     }
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

//   Future<void> _pickFile() async {
//     setState(() {
//       _isLoading = true;
//     });
//     String? content = await FilePickerUtil.pickTextFile();
//     setState(() {
//       _sourceContent = content;
//       _isLoading = false;
//       if (content != null) {
//         _showSnackBar('File loaded successfully!');
//       } else {
//         _showSnackBar('No file selected or failed to load.', isError: true);
//       }
//     });
//   }

//   Future<void> _generateCourse() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     if (_selectedDifficulty == null || _selectedDomain == null) {
//       _showSnackBar('Please select difficulty and domain.', isError: true);
//       return;
//     }
//     if (_currentUserProfile == null) {
//       _showSnackBar('User profile not loaded. Please try again.', isError: true);
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final geminiApiService = Provider.of<GeminiApiService>(context, listen: false);
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);

//       // Generate only the initial set of levels (e.g., 5 levels)
//       final Map<String, dynamic> generatedContent =
//           await geminiApiService.generateCourseContent(
//         topicName: _topicController.text.trim(),
//         ageGroup: 'college students',
//         domain: _selectedDomain!,
//         difficulty: _selectedDifficulty!,
//         educationLevel: _selectedEducationLevel,
//         specialty: _selectedSpecialty,
//         sourceContent: _sourceContent,
//         youtubeUrl: _youtubeUrlController.text.trim().isNotEmpty ? _youtubeUrlController.text.trim() : null,
//         numberOfLevels: AppConstants.initialLevelsCount, // Request initial levels only
//         startingLevelOrder: 1,
//       );

//       final String courseId = firebaseService.generateNewDocId();
//       final List<String> levelIds = [];
//       final Map<String, List<Lesson>> lessonsPerLevel = {};
//       final Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel = {};


//       final Course newCourse = Course(
//         id: courseId,
//         title: generatedContent['courseTitle'] as String,
//         description: generatedContent['levels']![0]['description'] as String, // Using first level's description for course overview
//         gameGenre: generatedContent['gameGenre'] as String,
//         difficulty: generatedContent['difficulty'] as String,
//         creatorId: _currentUserProfile!.uid,
//         createdAt: DateTime.now(),
//       );

//       // Populate levelIds, lessonsPerLevel, questionsPerLessonPerLevel for saving
//       for (var levelData in generatedContent['levels']) {
//         // Ensure to use new unique IDs for levels generated from AI response,
//         // as the AI might generate generic IDs like "level_1" that conflict.
//         final String newLevelId = firebaseService.generateNewDocId();
//         levelIds.add(newLevelId);

//         final Level newLevel = Level(
//           id: newLevelId, // Use the newly generated ID
//           title: levelData['title'] as String,
//           description: levelData['description'] as String,
//           courseId: courseId, // Link to the newly created course
//           difficulty: levelData['difficulty'] as String,
//           order: levelData['order'] as int,
//           imageAssetPath: levelData['imageAssetPath'] as String?,
//         );
//         // Add newLevel to a list for batch saving if necessary, or save individually
//         // For now, let's collect all levels to pass to saveLevels
//         // This is important: The `saveLevels` method expects `List<Level>`
//         // and maps for their children. So, we need to adapt the structure from Gemini.


//         final List<Lesson> lessons = [];
//         final Map<String, List<Question>> questionsForThisLevelLessons = {};

//         for (var lessonData in levelData['lessons']) {
//           final String newLessonId = firebaseService.generateNewDocId();
//           final Lesson newLesson = Lesson(
//             id: newLessonId, // Use the newly generated ID
//             title: lessonData['title'] as String,
//             content: lessonData['content'] as String,
//             levelId: newLevelId, // Link to the new level ID
//             order: lessons.length + 1,
//           );
//           lessons.add(newLesson);

//           final List<Question> questions = [];
//           for (var questionData in lessonData['questions']) {
//             questions.add(Question.fromMap({
//               ...questionData as Map<String, dynamic>,
//               'id': firebaseService.generateNewDocId(), // Generate new ID for questions
//             }));
//           }
//           questionsForThisLevelLessons[newLessonId] = questions;
//         }
//         lessonsPerLevel[newLevelId] = lessons;
//         questionsPerLessonPerLevel[newLevelId] = questionsForThisLevelLessons;
//       }
      
//       // Save the initial course first
//       await firebaseService.saveCourse(newCourse);
      
//       // Then save all generated levels, lessons, and questions in a single batch
//       // Re-map the generatedContent['levels'] into a List<Level> using the new IDs
//       final List<Level> initialLevelsToSave = [];
//       for (var levelData in generatedContent['levels']) {
//         // Find the newId that was generated for this level in the levelIds list
//         // This assumes levelData['id'] from Gemini matches the order for simplicity
//         // A more robust way would be to create `Level` objects in the loop above
//         // and then pass that list. Let's do that.
//         final String originalLevelIdFromGemini = levelData['id'] as String;
//         // Find the corresponding newly generated ID for this level.
//         // This mapping needs to be more explicit if Gemini's IDs are not sequential.
//         // For now, assuming direct order correlation to simplify.
//         // A better approach is to build the `Level` objects directly where `newLevelId` is generated.
//       }

//       // Rebuilding the levels list with the new IDs as Level objects
//       // This is a more robust way to handle the level IDs and data.
//       final List<Level> levelsToSave = [];
//       for (var levelData in generatedContent['levels']) {
//         final String newLevelId = firebaseService.generateNewDocId(); // Generate a truly new ID here
//         final Level level = Level(
//           id: newLevelId,
//           title: levelData['title'] as String,
//           description: levelData['description'] as String,
//           courseId: courseId,
//           difficulty: levelData['difficulty'] as String,
//           order: levelData['order'] as int,
//           imageAssetPath: levelData['imageAssetPath'] as String?,
//         );
//         levelsToSave.add(level);

//         // Update the maps to use the newLevelId
//         lessonsPerLevel[newLevelId] = (levelData['lessons'] as List)
//             .map((lessonData) => Lesson(
//                   id: firebaseService.generateNewDocId(),
//                   title: lessonData['title'] as String,
//                   content: lessonData['content'] as String,
//                   levelId: newLevelId,
//                   order: (lessonData['order'] as int?) ?? 1, // Default to 1 if order is missing
//                 ))
//             .toList();

//         questionsPerLessonPerLevel[newLevelId] = {};
//         for (var lessonData in levelData['lessons']) {
//           final String lessonId = lessonsPerLevel[newLevelId]!
//               .firstWhere((element) => element.title == lessonData['title'])
//               .id; // Find the newly created lesson ID
//           questionsPerLessonPerLevel[newLevelId]![lessonId] = (lessonData['questions'] as List)
//               .map((questionData) => Question.fromMap({
//                     ...questionData as Map<String, dynamic>,
//                     'id': firebaseService.generateNewDocId(),
//                   }))
//               .toList();
//         }
//       }

//       // Update the course with the list of newly generated level IDs
//       final List<String> finalLevelIds = levelsToSave.map((level) => level.id).toList();
//       await firebaseService.updateCourse(courseId, {'levelIds': finalLevelIds});
      
//       // Save all levels, lessons, and questions
//       await firebaseService.saveLevels(levelsToSave, lessonsPerLevel, questionsPerLessonPerLevel);


//       _showSnackBar('Course "${newCourse.title}" generated and saved successfully with initial levels!');
//       Navigator.of(context).pop();
//     } catch (e) {
//       _showSnackBar('Failed to generate course: $e', isError: true);
//       debugPrint('Course generation error: $e');
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
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(AppConstants.padding * 2),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 CustomTextField(
//                   controller: _topicController,
//                   labelText: 'Course Topic',
//                   hintText: 'e.g., Introduction to Quantum Physics',
//                   validator: (value) => ValidationUtils.validateField(value, 'Course Topic'),
//                 ),
//                 const SizedBox(height: AppConstants.padding),
//                 CustomTextField(
//                   controller: _youtubeUrlController,
//                   labelText: 'YouTube Video URL (Optional)',
//                   hintText: 'e.g., https://www.youtube.com/watch?v=dQw4w9WgXcQ',
//                 ),
//                 const SizedBox(height: AppConstants.padding),
//                 CustomButton(
//                   text: _sourceContent == null ? 'Upload Text File (Optional)' : 'File Loaded: ${_sourceContent!.length} chars',
//                   onPressed: _pickFile,
//                   backgroundColor: _sourceContent == null ? AppColors.infoColor : AppColors.successColor.withOpacity(0.8),
//                   foregroundColor: AppColors.textColor,
//                   icon: _sourceContent == null ? Icons.upload_file : Icons.check_circle_outline,
//                   isLoading: _isLoading,
//                 ),
//                 if (_sourceContent != null)
//                   Padding(
//                     padding: const EdgeInsets.only(top: AppConstants.spacing),
//                     child: Text(
//                       'Content will be generated from the uploaded file.',
//                       style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColorSecondary),
//                     ),
//                   ),
//                 const SizedBox(height: AppConstants.padding),
//                 _buildDropdownField(
//                   context,
//                   label: 'Domain',
//                   value: _selectedDomain,
//                   items: ['Science', 'Technology', 'Engineering', 'Math', 'Arts', 'Humanities', 'Business', 'Other'],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedDomain = value;
//                     });
//                   },
//                   validator: (value) => ValidationUtils.validateField(value, 'Domain'),
//                 ),
//                 const SizedBox(height: AppConstants.padding),
//                 _buildDropdownField(
//                   context,
//                   label: 'Difficulty',
//                   value: _selectedDifficulty,
//                   items: AppConstants.difficultyLevels,
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedDifficulty = value;
//                     });
//                   },
//                   validator: (value) => ValidationUtils.validateField(value, 'Difficulty'),
//                 ),
//                 const SizedBox(height: AppConstants.padding * 2),
//                 CustomButton(
//                   text: 'Generate Course',
//                   onPressed: _generateCourse,
//                   isLoading: _isLoading,
//                   icon: Icons.auto_awesome,
//                   backgroundColor: AppColors.primaryColor,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdownField(BuildContext context, {
//     required String label,
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//     String? Function(String?)? validator,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.8)),
//         filled: true,
//         fillColor: AppColors.cardColor.withOpacity(0.7),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           borderSide: const BorderSide(color: AppColors.accentColor, width: 2.0),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           borderSide: const BorderSide(color: AppColors.borderColor, width: 1.0),
//         ),
//       ),
//       dropdownColor: AppColors.cardColor.withOpacity(0.95),
//       style: const TextStyle(color: AppColors.textColor),
//       icon: const Icon(Icons.arrow_drop_down, color: AppColors.textColorSecondary),
//       items: items.map((item) {
//         return DropdownMenuItem(
//           value: item,
//           child: Text(item, style: const TextStyle(color: AppColors.textColor)),
//         );
//       }).toList(),
//       onChanged: onChanged,
//       validator: validator,
//     );
//   }
// }
// // lib/screens/community_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/models/community_post.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/custom_text_field.dart';
// import 'package:gamifier/widgets/community/post_card.dart';

// class CommunityScreen extends StatefulWidget {
//   const CommunityScreen({super.key});

//   @override
//   State<CommunityScreen> createState() => _CommunityScreenState();
// }

// class _CommunityScreenState extends State<CommunityScreen> {
//   final TextEditingController _postController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   UserProfile? _currentUserProfile;
//   bool _isPosting = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserProfile();
//   }

//   @override
//   void dispose() {
//     _postController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchUserProfile() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;
//     if (currentUser != null) {
//       _currentUserProfile = await firebaseService.getUserProfile(currentUser.uid);
//       setState(() {});
//     }
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

//   Future<void> _createPost() async {
//     if (!_formKey.currentState!.validate() || _currentUserProfile == null || _isPosting) {
//       return;
//     }

//     setState(() {
//       _isPosting = true;
//     });

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final newPost = CommunityPost(
//       id: firebaseService.generateNewDocId(),
//       authorId: _currentUserProfile!.uid,
//       authorUsername: _currentUserProfile!.username,
//       authorAvatarUrl: _currentUserProfile!.avatarAssetPath,
//       content: _postController.text.trim(),
//       timestamp: DateTime.now(),
//       likedBy: [],
//       comments: [],
//     );

//     try {
//       await firebaseService.createCommunityPost(newPost);
//       _postController.clear();
//       _showSnackBar('Post created successfully!');
//     } catch (e) {
//       _showSnackBar('Error creating post: $e', isError: true);
//     } finally {
//       setState(() {
//         _isPosting = false;
//       });
//     }
//   }

//   Future<void> _deletePost(String postId) async {
//     final bool confirmDelete = await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Post?'),
//         content: const Text('Are you sure you want to delete this post? This cannot be undone.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorColor),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     ) ?? false;

//     if (confirmDelete) {
//       try {
//         final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//         await firebaseService.getFirestore().collection(AppConstants.communityPostsCollection).doc(postId).delete();
//         _showSnackBar('Post deleted successfully!');
//       } catch (e) {
//         _showSnackBar('Error deleting post: $e', isError: true);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final firebaseService = Provider.of<FirebaseService>(context);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null || _currentUserProfile == null) {
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
//         title: 'Community Forum',
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
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     CustomTextField(
//                       controller: _postController,
//                       labelText: 'Share your thoughts...',
//                       hintText: 'What\'s on your mind?',
//                       maxLines: 3,
//                       validator: (value) =>
//                           value == null || value.trim().isEmpty ? 'Post content cannot be empty.' : null,
//                     ),
//                     const SizedBox(height: AppConstants.spacing),
//                     CustomButton(
//                       text: 'Create Post',
//                       onPressed: _createPost,
//                       isLoading: _isPosting,
//                       icon: Icons.send,
//                       width: double.infinity,
//                     ),
//                   ],
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
//                       child: Text(
//                         'No posts yet. Be the first to share something!',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//                         textAlign: TextAlign.center,
//                       ),
//                     );
//                   }

//                   final posts = snapshot.data!;
//                   // Ensure posts are sorted by timestamp for consistent display, newest first
//                   posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));

//                   return ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
//                     itemCount: posts.length,
//                     itemBuilder: (context, index) {
//                       final post = posts[index];
//                       return PostCard(
//                         post: post,
//                         currentUserId: currentUser.uid,
//                         onDelete: post.authorId == currentUser.uid ? _deletePost : null, // Pass delete function only if current user is author
//                       );
//                     },
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
// // lib/screens/chat_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/gemini_api_service.dart';
// import 'package:gamifier/models/chat_message.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   UserProfile? _userProfile;
//   bool _isSendingMessage = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserProfile();
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchUserProfile() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;
//     if (currentUser != null) {
//       _userProfile = await firebaseService.getUserProfile(currentUser.uid);
//       setState(() {});
//     }
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
//     final text = _messageController.text.trim();
//     if (text.isEmpty || _userProfile == null || _isSendingMessage) {
//       return;
//     }

//     setState(() {
//       _isSendingMessage = true;
//     });

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final geminiApiService = Provider.of<GeminiApiService>(context, listen: false);

//     final userMessage = ChatMessage(
//       id: firebaseService.generateNewDocId(),
//       senderId: _userProfile!.uid,
//       senderUsername: _userProfile!.username,
//       senderAvatarUrl: _userProfile!.avatarAssetPath,
//       text: text,
//       timestamp: DateTime.now(),
//       isUser: true,
//     );

//     _messageController.clear();
//     await firebaseService.sendChatMessage(userMessage);

//     // Get chat history for AI
//     final chatHistory = await firebaseService.streamChatMessages().first;

//     try {
//       final aiResponseText = await geminiApiService.generateChatResponse(chatHistory);
//       final aiMessage = ChatMessage(
//         id: firebaseService.generateNewDocId(),
//         senderId: 'ai_tutor',
//         senderUsername: 'AI Tutor 🤖',
//         senderAvatarUrl: 'assets/app_icon.png', // Or a specific AI avatar
//         text: aiResponseText,
//         timestamp: DateTime.now(),
//         isUser: false,
//       );
//       await firebaseService.sendChatMessage(aiMessage);
//     } catch (e) {
//       _showSnackBar('Error getting AI response: $e', isError: true);
//     } finally {
//       setState(() {
//         _isSendingMessage = false;
//       });
//       _scrollToBottom();
//     }
//   }

//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: AppConstants.defaultAnimationDuration,
//         curve: Curves.easeOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final firebaseService = Provider.of<FirebaseService>(context);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null || _userProfile == null) {
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
//         title: 'AI Chat Tutor',
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
//               child: StreamBuilder<List<ChatMessage>>(
//                 stream: firebaseService.streamChatMessages(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                         child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
//                   }
//                   if (snapshot.hasError) {
//                     return Center(
//                         child: Text('Error loading chat: ${snapshot.error}',
//                             style: const TextStyle(color: AppColors.errorColor)));
//                   }
//                   if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'Start a conversation with your AI tutor!',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColorSecondary),
//                         textAlign: TextAlign.center,
//                       ),
//                     );
//                   }

//                   final messages = snapshot.data!;
//                   WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

//                   return ListView.builder(
//                     controller: _scrollController,
//                     padding: const EdgeInsets.all(AppConstants.padding),
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       final isUser = message.senderId == currentUser.uid;

//                       return Align(
//                         alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//                           padding: const EdgeInsets.all(AppConstants.padding),
//                           decoration: BoxDecoration(
//                             color: isUser ? AppColors.primaryColor.withOpacity(0.8) : AppColors.cardColor.withOpacity(0.9),
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(AppConstants.borderRadius),
//                               topRight: Radius.circular(AppConstants.borderRadius),
//                               bottomLeft: isUser ? Radius.circular(AppConstants.borderRadius) : Radius.circular(0),
//                               bottomRight: isUser ? Radius.circular(0) : Radius.circular(AppConstants.borderRadius),
//                             ),
//                           ),
//                           constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 isUser ? message.senderUsername : message.senderUsername,
//                                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                                       color: AppColors.textColorSecondary,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                               ),
//                               const SizedBox(height: AppConstants.spacing / 4),
//                               Text(
//                                 message.text,
//                                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColor),
//                               ),
//                               const SizedBox(height: AppConstants.spacing / 4),
//                               Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: Text(
//                                   '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
//                                   style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                                         color: AppColors.textColorSecondary.withOpacity(0.7),
//                                         fontSize: 10,
//                                       ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(AppConstants.padding),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       style: const TextStyle(color: AppColors.textColor),
//                       decoration: InputDecoration(
//                         hintText: 'Ask your AI tutor anything...',
//                         hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.7)),
//                         filled: true,
//                         fillColor: AppColors.cardColor.withOpacity(0.8),
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
//                   _isSendingMessage
//                       ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor))
//                       : FloatingActionButton(
//                           onPressed: _sendMessage,
//                           backgroundColor: AppColors.accentColor,
//                           foregroundColor: AppColors.cardColor,
//                           mini: true,
//                           child: const Icon(Icons.send),
//                         ),
//                 ],
//               ),
//             ),
//           ],
//         ),
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
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/gamification/avatar_customizer.dart';

// class AvatarCustomizerScreen extends StatefulWidget {
//   const AvatarCustomizerScreen({super.key});

//   @override
//   State<AvatarCustomizerScreen> createState() => _AvatarCustomizerScreenState();
// }

// class _AvatarCustomizerScreenState extends State<AvatarCustomizerScreen> {
//   String? _selectedAvatarPath;
//   UserProfile? _userProfile;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     setState(() {
//       _isLoading = true;
//     });
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;
//     if (currentUser != null) {
//       _userProfile = await firebaseService.getUserProfile(currentUser.uid);
//       _selectedAvatarPath = _userProfile?.avatarAssetPath;
//     }
//     setState(() {
//       _isLoading = false;
//     });
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

//   Future<void> _saveAvatar() async {
//     if (_userProfile == null || _selectedAvatarPath == null) {
//       _showSnackBar('No avatar selected or user not logged in.', isError: true);
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       await firebaseService.updateUserProfile(
//         _userProfile!.uid,
//         {'avatarAssetPath': _selectedAvatarPath},
//       );
//       _showSnackBar('Avatar updated successfully!');
//       Navigator.of(context).pop();
//     } catch (e) {
//       _showSnackBar('Failed to save avatar: $e', isError: true);
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading || _userProfile == null || _selectedAvatarPath == null) {
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
//         title: 'Customize Avatar',
//         leadingWidget: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(AppConstants.padding * 2),
//           child: Column(
//             children: [
//               AvatarCustomizer(
//                 currentAvatarPath: _selectedAvatarPath!,
//                 availableAvatars: AppConstants.defaultAvatarAssets,
//                 onAvatarSelected: (path) {
//                   setState(() {
//                     _selectedAvatarPath = path;
//                   });
//                 },
//               ),
//               const SizedBox(height: AppConstants.padding * 2),
//               CustomButton(
//                 text: 'Save Avatar',
//                 onPressed: _saveAvatar,
//                 isLoading: _isLoading,
//                 backgroundColor: AppColors.accentColor,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/screens/auth_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/utils/validation_utils.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/custom_text_field.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   bool _isLogin = true;
//   bool _isLoading = false;
//   bool _obscurePassword = true;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _usernameController.dispose();
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

//   Future<void> _submitForm() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       if (_isLogin) {
//         await firebaseService.signInWithEmailAndPassword(
//           _emailController.text,
//           _passwordController.text,
//         );
//         _showSnackBar('Login successful!');
//         Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//       } else {
//         await firebaseService.registerWithEmailAndPassword(
//           _emailController.text,
//           _passwordController.text,
//           _usernameController.text,
//         );
//         _showSnackBar('Registration successful! Please complete your profile.');
//         Navigator.of(context).pushReplacementNamed(AppRouter.onboardingRoute);
//       }
//     } on Exception catch (e) {
//       _showSnackBar('Authentication failed: ${e.toString().replaceAll('Exception: ', '')}', isError: true);
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
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
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.games,
//                     size: 80,
//                     color: AppColors.accentColor,
//                   ),
//                   const SizedBox(height: AppConstants.padding),
//                   Text(
//                     _isLogin ? 'Welcome Back!' : 'Join Gamifier',
//                     style: AppColors.neonTextStyle(fontSize: 32),
//                   ),
//                   Text(
//                     _isLogin ? 'Sign in to continue your journey' : 'Create an account to start playing',
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColorSecondary),
//                   ),
//                   const SizedBox(height: AppConstants.padding * 2),
//                   CustomTextField(
//                     controller: _emailController,
//                     labelText: 'Email',
//                     hintText: 'your@email.com',
//                     keyboardType: TextInputType.emailAddress,
//                     validator: ValidationUtils.validateEmail,
//                   ),
//                   const SizedBox(height: AppConstants.padding),
//                   if (!_isLogin)
//                     CustomTextField(
//                       controller: _usernameController,
//                       labelText: 'Username',
//                       hintText: 'Choose a unique username',
//                       validator: ValidationUtils.validateUsername,
//                     ),
//                   if (!_isLogin) const SizedBox(height: AppConstants.padding),
//                   CustomTextField(
//                     controller: _passwordController,
//                     labelText: 'Password',
//                     hintText: 'Enter your password',
//                     obscureText: _obscurePassword,
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                         color: AppColors.textColorSecondary,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                     validator: ValidationUtils.validatePassword,
//                   ),
//                   const SizedBox(height: AppConstants.padding * 1.5),
//                   CustomButton(
//                     text: _isLogin ? 'Sign In' : 'Register',
//                     onPressed: _submitForm,
//                     isLoading: _isLoading,
//                   ),
//                   const SizedBox(height: AppConstants.padding),
//                   TextButton(
//                     onPressed: () {
//                       setState(() {
//                         _isLogin = !_isLogin;
//                       });
//                       _formKey.currentState?.reset();
//                       _emailController.clear();
//                       _passwordController.clear();
//                       _usernameController.clear();
//                     },
//                     child: Text(
//                       _isLogin
//                           ? 'Don\'t have an account? Register Now'
//                           : 'Already have an account? Sign In',
//                       style: const TextStyle(color: AppColors.accentColor),
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
// }
// // lib/models/user_progress.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

// @immutable
// class UserProgress {
//   final String id; // userId_courseId
//   final String userId;
//   final String courseId;
//   final String? currentLevelId;
//   final String? currentLessonId;
//   final Map<String, LevelProgress> levelsProgress; // Map<levelId, LevelProgress>
//   final Map<String, LessonProgress> lessonsProgress; // Map<lessonId, LessonProgress>

//   const UserProgress({
//     required this.id,
//     required this.userId,
//     required this.courseId,
//     this.currentLevelId,
//     this.currentLessonId,
//     this.levelsProgress = const {},
//     this.lessonsProgress = const {},
//   });

//   factory UserProgress.fromMap(Map<String, dynamic> map) {
//     return UserProgress(
//       id: map['id'] as String,
//       userId: map['userId'] as String,
//       courseId: map['courseId'] as String,
//       currentLevelId: map['currentLevelId'] as String?,
//       currentLessonId: map['currentLessonId'] as String?,
//       levelsProgress: (map['levelsProgress'] as Map<String, dynamic>?)
//               ?.map((key, value) => MapEntry(key, LevelProgress.fromMap(value as Map<String, dynamic>))) ??
//           {},
//       lessonsProgress: (map['lessonsProgress'] as Map<String, dynamic>?)
//               ?.map((key, value) => MapEntry(key, LessonProgress.fromMap(value as Map<String, dynamic>))) ??
//           {},
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'userId': userId,
//       'courseId': courseId,
//       'currentLevelId': currentLevelId,
//       'currentLessonId': currentLessonId,
//       'levelsProgress': levelsProgress.map((key, value) => MapEntry(key, value.toMap())),
//       'lessonsProgress': lessonsProgress.map((key, value) => MapEntry(key, value.toMap())),
//     };
//   }

//   UserProgress copyWith({
//     String? id,
//     String? userId,
//     String? courseId,
//     String? currentLevelId,
//     String? currentLessonId,
//     Map<String, LevelProgress>? levelsProgress,
//     Map<String, LessonProgress>? lessonsProgress,
//   }) {
//     return UserProgress(
//       id: id ?? this.id,
//       userId: userId ?? this.userId,
//       courseId: courseId ?? this.courseId,
//       currentLevelId: currentLevelId ?? this.currentLevelId,
//       currentLessonId: currentLessonId ?? this.currentLessonId,
//       levelsProgress: levelsProgress ?? this.levelsProgress,
//       lessonsProgress: lessonsProgress ?? this.lessonsProgress,
//     );
//   }

//   @override
//   String toString() {
//     return 'UserProgress(id: $id, userId: $userId, courseId: $courseId, currentLevelId: $currentLevelId, currentLessonId: $currentLessonId, levelsProgress: $levelsProgress, lessonsProgress: $lessonsProgress)';
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
//           mapEquals(levelsProgress, other.levelsProgress) &&
//           mapEquals(lessonsProgress, other.lessonsProgress);

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       userId.hashCode ^
//       courseId.hashCode ^
//       currentLevelId.hashCode ^
//       currentLessonId.hashCode ^
//       mapEquals(levelsProgress, levelsProgress).hashCode ^
//       mapEquals(lessonsProgress, lessonsProgress).hashCode;
// }

// @immutable
// class LevelProgress {
//   final bool isCompleted;
//   final int xpEarned;
//   final int score;
//   final DateTime? completedAt;

//   const LevelProgress({
//     this.isCompleted = false,
//     this.xpEarned = 0,
//     this.score = 0,
//     this.completedAt,
//   });

//   factory LevelProgress.fromMap(Map<String, dynamic> map) {
//     return LevelProgress(
//       isCompleted: map['isCompleted'] as bool,
//       xpEarned: map['xpEarned'] as int,
//       score: map['score'] as int,
//       completedAt: map['completedAt'] != null ? (map['completedAt'] as Timestamp).toDate() : null,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'isCompleted': isCompleted,
//       'xpEarned': xpEarned,
//       'score': score,
//       'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
//     };
//   }

//   LevelProgress copyWith({
//     bool? isCompleted,
//     int? xpEarned,
//     int? score,
//     DateTime? completedAt,
//   }) {
//     return LevelProgress(
//       isCompleted: isCompleted ?? this.isCompleted,
//       xpEarned: xpEarned ?? this.xpEarned,
//       score: score ?? this.score,
//       completedAt: completedAt ?? this.completedAt,
//     );
//   }

//   @override
//   String toString() {
//     return 'LevelProgress(isCompleted: $isCompleted, xpEarned: $xpEarned, score: $score, completedAt: $completedAt)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is LevelProgress &&
//           runtimeType == other.runtimeType &&
//           isCompleted == other.isCompleted &&
//           xpEarned == other.xpEarned &&
//           score == other.score &&
//           completedAt == other.completedAt;

//   @override
//   int get hashCode =>
//       isCompleted.hashCode ^ xpEarned.hashCode ^ score.hashCode ^ completedAt.hashCode;
// }

// @immutable
// class LessonProgress {
//   final bool isCompleted;
//   final int xpEarned;
//   final Map<String, QuestionAttempt> questionAttempts; // Map<questionId, QuestionAttempt>
//   final DateTime? completedAt;

//   const LessonProgress({
//     this.isCompleted = false,
//     this.xpEarned = 0,
//     this.questionAttempts = const {},
//     this.completedAt,
//   });

//   factory LessonProgress.fromMap(Map<String, dynamic> map) {
//     return LessonProgress(
//       isCompleted: map['isCompleted'] as bool,
//       xpEarned: map['xpEarned'] as int,
//       questionAttempts: (map['questionAttempts'] as Map<String, dynamic>?)
//               ?.map((key, value) => MapEntry(key, QuestionAttempt.fromMap(value as Map<String, dynamic>))) ??
//           {},
//       completedAt: map['completedAt'] != null ? (map['completedAt'] as Timestamp).toDate() : null,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'isCompleted': isCompleted,
//       'xpEarned': xpEarned,
//       'questionAttempts': questionAttempts.map((key, value) => MapEntry(key, value.toMap())),
//       'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
//     };
//   }

//   LessonProgress copyWith({
//     bool? isCompleted,
//     int? xpEarned,
//     Map<String, QuestionAttempt>? questionAttempts,
//     DateTime? completedAt,
//   }) {
//     return LessonProgress(
//       isCompleted: isCompleted ?? this.isCompleted,
//       xpEarned: xpEarned ?? this.xpEarned,
//       questionAttempts: questionAttempts ?? this.questionAttempts,
//       completedAt: completedAt ?? this.completedAt,
//     );
//   }

//   @override
//   String toString() {
//     return 'LessonProgress(isCompleted: $isCompleted, xpEarned: $xpEarned, questionAttempts: $questionAttempts, completedAt: $completedAt)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is LessonProgress &&
//           runtimeType == other.runtimeType &&
//           isCompleted == other.isCompleted &&
//           xpEarned == other.xpEarned &&
//           mapEquals(questionAttempts, other.questionAttempts) &&
//           completedAt == other.completedAt;

//   @override
//   int get hashCode =>
//       isCompleted.hashCode ^ xpEarned.hashCode ^ mapEquals(questionAttempts, questionAttempts).hashCode ^ completedAt.hashCode;
// }

// @immutable
// class QuestionAttempt {
//   final String userAnswer;
//   final bool isCorrect;
//   final DateTime attemptedAt;
//   final int xpAwarded;

//   const QuestionAttempt({
//     required this.userAnswer,
//     required this.isCorrect,
//     required this.attemptedAt,
//     this.xpAwarded = 0,
//   });

//   factory QuestionAttempt.fromMap(Map<String, dynamic> map) {
//     return QuestionAttempt(
//       userAnswer: map['userAnswer'] as String,
//       isCorrect: map['isCorrect'] as bool,
//       attemptedAt: (map['attemptedAt'] as Timestamp).toDate(),
//       xpAwarded: map['xpAwarded'] as int,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'userAnswer': userAnswer,
//       'isCorrect': isCorrect,
//       'attemptedAt': Timestamp.fromDate(attemptedAt),
//       'xpAwarded': xpAwarded,
//     };
//   }

//   QuestionAttempt copyWith({
//     String? userAnswer,
//     bool? isCorrect,
//     DateTime? attemptedAt,
//     int? xpAwarded,
//   }) {
//     return QuestionAttempt(
//       userAnswer: userAnswer ?? this.userAnswer,
//       isCorrect: isCorrect ?? this.isCorrect,
//       attemptedAt: attemptedAt ?? this.attemptedAt,
//       xpAwarded: xpAwarded ?? this.xpAwarded,
//     );
//   }

//   @override
//   String toString() {
//     return 'QuestionAttempt(userAnswer: $userAnswer, isCorrect: $isCorrect, attemptedAt: $attemptedAt, xpAwarded: $xpAwarded)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is QuestionAttempt &&
//           runtimeType == other.runtimeType &&
//           userAnswer == other.userAnswer &&
//           isCorrect == other.isCorrect &&
//           attemptedAt == other.attemptedAt &&
//           xpAwarded == other.xpAwarded;

//   @override
//   int get hashCode =>
//       userAnswer.hashCode ^ isCorrect.hashCode ^ attemptedAt.hashCode ^ xpAwarded.hashCode;
// }
// // lib/models/user_profile.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gamifier/constants/app_constants.dart'; // Import AppConstants

// class UserProfile {
//   final String uid;
//   final String username;
//   final String email;
//   final String avatarAssetPath;
//   final int xp;
//   final int level;
//   final int currentStreak;
//   final DateTime lastLoginDate;
//   final DateTime createdAt;
//   final String? educationLevel;
//   final String? specialty;
//   final List<String> earnedBadges;
//   final List<String> friends; // Added for social features

//   UserProfile({
//     required this.uid,
//     required this.username,
//     this.email = '', // Default empty string
//     this.avatarAssetPath = 'assets/avatars/avatar1.png',
//     this.xp = AppConstants.initialXp, // Use constant for initial XP
//     this.level = 1,
//     this.currentStreak = 0,
//     required this.lastLoginDate,
//     required this.createdAt,
//     this.educationLevel,
//     this.specialty,
//     this.earnedBadges = const [],
//     this.friends = const [],
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'username': username,
//       'email': email,
//       'avatarAssetPath': avatarAssetPath,
//       'xp': xp,
//       'level': level,
//       'currentStreak': currentStreak,
//       'lastLoginDate': Timestamp.fromDate(lastLoginDate),
//       'createdAt': Timestamp.fromDate(createdAt),
//       'educationLevel': educationLevel,
//       'specialty': specialty,
//       'earnedBadges': earnedBadges,
//       'friends': friends,
//     };
//   }

//   factory UserProfile.fromMap(Map<String, dynamic> map) {
//     return UserProfile(
//       uid: map['uid'] as String,
//       username: map['username'] as String,
//       email: map['email'] as String? ?? '',
//       avatarAssetPath: map['avatarAssetPath'] as String? ?? 'assets/avatars/avatar1.png',
//       xp: map['xp'] as int? ?? AppConstants.initialXp, // Use constant for initial XP
//       level: map['level'] as int? ?? 1,
//       currentStreak: map['currentStreak'] as int? ?? 0,
//       lastLoginDate: (map['lastLoginDate'] as Timestamp).toDate(),
//       createdAt: (map['createdAt'] as Timestamp).toDate(),
//       educationLevel: map['educationLevel'] as String?,
//       specialty: map['specialty'] as String?,
//       earnedBadges: List<String>.from(map['earnedBadges'] as List? ?? []),
//       friends: List<String>.from(map['friends'] as List? ?? []),
//     );
//   }

//   UserProfile copyWith({
//     String? uid,
//     String? username,
//     String? email,
//     String? avatarAssetPath,
//     int? xp,
//     int? level,
//     int? currentStreak,
//     DateTime? lastLoginDate,
//     DateTime? createdAt,
//     String? educationLevel,
//     String? specialty,
//     List<String>? earnedBadges,
//     List<String>? friends,
//   }) {
//     return UserProfile(
//       uid: uid ?? this.uid,
//       username: username ?? this.username,
//       email: email ?? this.email,
//       avatarAssetPath: avatarAssetPath ?? this.avatarAssetPath,
//       xp: xp ?? this.xp,
//       level: level ?? this.level,
//       currentStreak: currentStreak ?? this.currentStreak,
//       lastLoginDate: lastLoginDate ?? this.lastLoginDate,
//       createdAt: createdAt ?? this.createdAt,
//       educationLevel: educationLevel ?? this.educationLevel,
//       specialty: specialty ?? this.specialty,
//       earnedBadges: earnedBadges ?? this.earnedBadges,
//       friends: friends ?? this.friends,
//     );
//   }
// }
// // lib/models/question.dart
// class Question {
//   final String id;
//   final String questionText;
//   final String type; // e.g., 'MCQ', 'FillInBlank', 'ShortAnswer', 'Scenario'
//   final int xpReward;

//   // Specific fields for different question types (optional)
//   final List<String>? options; // For MCQ
//   final String? correctAnswer; // For MCQ, FillInBlank
//   final String? expectedAnswerKeywords; // For ShortAnswer (comma-separated)
//   final String? scenarioText; // For Scenario
//   final String? expectedOutcome; // For Scenario

//   Question({
//     required this.id,
//     required this.questionText,
//     required this.type,
//     required this.xpReward,
//     this.options,
//     this.correctAnswer,
//     this.expectedAnswerKeywords,
//     this.scenarioText,
//     this.expectedOutcome,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'questionText': questionText,
//       'type': type,
//       'xpReward': xpReward,
//       if (options != null) 'options': options,
//       if (correctAnswer != null) 'correctAnswer': correctAnswer,
//       if (expectedAnswerKeywords != null) 'expectedAnswerKeywords': expectedAnswerKeywords,
//       if (scenarioText != null) 'scenarioText': scenarioText,
//       if (expectedOutcome != null) 'expectedOutcome': expectedOutcome,
//     };
//   }

//   factory Question.fromMap(Map<String, dynamic> map) {
//     return Question(
//       id: map['id'] as String,
//       questionText: map['questionText'] as String,
//       type: map['type'] as String,
//       xpReward: map['xpReward'] as int,
//       options: (map['options'] as List?)?.map((e) => e as String).toList(),
//       correctAnswer: map['correctAnswer'] as String?,
//       expectedAnswerKeywords: map['expectedAnswerKeywords'] as String?,
//       scenarioText: map['scenarioText'] as String?,
//       expectedOutcome: map['expectedOutcome'] as String?,
//     );
//   }

//   Question copyWith({
//     String? id,
//     String? questionText,
//     String? type,
//     int? xpReward,
//     List<String>? options,
//     String? correctAnswer,
//     String? expectedAnswerKeywords,
//     String? scenarioText,
//     String? expectedOutcome,
//   }) {
//     return Question(
//       id: id ?? this.id,
//       questionText: questionText ?? this.questionText,
//       type: type ?? this.type,
//       xpReward: xpReward ?? this.xpReward,
//       options: options ?? this.options,
//       correctAnswer: correctAnswer ?? this.correctAnswer,
//       expectedAnswerKeywords: expectedAnswerKeywords ?? this.expectedAnswerKeywords,
//       scenarioText: scenarioText ?? this.scenarioText,
//       expectedOutcome: expectedOutcome ?? this.expectedOutcome,
//     );
//   }
// }
// // lib/models/level.dart
// import 'package:flutter/material.dart'; // Required for IconData

// class Level {
//   final String id;
//   final String title;
//   final String description;
//   String courseId; // Made non-final to allow setting after creation
//   final String difficulty;
//   final int order;
//   final String? imageAssetPath; // Path to a local asset image

//   Level({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.courseId,
//     required this.difficulty,
//     required this.order,
//     this.imageAssetPath,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'courseId': courseId,
//       'difficulty': difficulty,
//       'order': order,
//       'imageAssetPath': imageAssetPath,
//     };
//   }

//   factory Level.fromMap(Map<String, dynamic> map) {
//     return Level(
//       id: map['id'] as String,
//       title: map['title'] as String,
//       description: map['description'] as String,
//       courseId: map['courseId'] as String? ?? '', // Provide a default or handle null
//       difficulty: map['difficulty'] as String,
//       order: map['order'] as int,
//       imageAssetPath: map['imageAssetPath'] as String?,
//     );
//   }

//   Level copyWith({
//     String? id,
//     String? title,
//     String? description,
//     String? courseId,
//     String? difficulty,
//     int? order,
//     String? imageAssetPath,
//   }) {
//     return Level(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       courseId: courseId ?? this.courseId,
//       difficulty: difficulty ?? this.difficulty,
//       order: order ?? this.order,
//       imageAssetPath: imageAssetPath ?? this.imageAssetPath,
//     );
//   }
// }
// // lib/models/lesson.dart
// import 'package:gamifier/models/question.dart'; // Import Question model

// class Lesson {
//   final String id;
//   final String title;
//   final String content;
//   String levelId; // Made non-final to allow setting after creation
//   final int order;
//   final List<Question> questions; // Added questions directly to Lesson model for easier parsing from Gemini API

//   Lesson({
//     required this.id,
//     required this.title,
//     required this.content,
//     required this.levelId,
//     required this.order,
//     this.questions = const [], // Initialize as empty list
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'content': content,
//       'levelId': levelId,
//       'order': order,
//       'questions': questions.map((q) => q.toMap()).toList(), // Convert questions to map
//     };
//   }

//   factory Lesson.fromMap(Map<String, dynamic> map) {
//     return Lesson(
//       id: map['id'] as String,
//       title: map['title'] as String,
//       content: map['content'] as String,
//       levelId: map['levelId'] as String? ?? '', // Provide a default or handle null
//       order: map['order'] as int,
//       questions: (map['questions'] as List?)
//               ?.map((q) => Question.fromMap(q as Map<String, dynamic>))
//               .toList() ??
//           const [],
//     );
//   }

//   Lesson copyWith({
//     String? id,
//     String? title,
//     String? content,
//     String? levelId,
//     int? order,
//     List<Question>? questions,
//   }) {
//     return Lesson(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       content: content ?? this.content,
//       levelId: levelId ?? this.levelId,
//       order: order ?? this.order,
//       questions: questions ?? this.questions,
//     );
//   }
// }
// // lib/models/course.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:gamifier/constants/app_constants.dart';

// @immutable
// class Course {
//   final String id;
//   final String title;
//   final String description;
//   final String gameGenre;
//   final String difficulty;
//   final String creatorId;
//   final DateTime createdAt;
//   final List<String> levelIds;
//   final String? educationLevel; // Optional
//   final String? specialty; // Optional

//   const Course({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.gameGenre,
//     required this.difficulty,
//     required this.creatorId,
//     required this.createdAt,
//     this.levelIds = const [],
//     this.educationLevel,
//     this.specialty,
//   });

//   factory Course.fromMap(Map<String, dynamic> map) {
//     return Course(
//       id: map['id'] as String,
//       title: map['title'] as String,
//       description: map['description'] as String,
//       gameGenre: map['gameGenre'] as String,
//       difficulty: map['difficulty'] as String,
//       creatorId: map['creatorId'] as String,
//       createdAt: (map['createdAt'] as Timestamp).toDate(),
//       levelIds: List<String>.from(map['levelIds'] ?? []),
//       educationLevel: map['educationLevel'] as String?,
//       specialty: map['specialty'] as String?,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'gameGenre': gameGenre,
//       'difficulty': difficulty,
//       'creatorId': creatorId,
//       'createdAt': Timestamp.fromDate(createdAt),
//       'levelIds': levelIds,
//       'educationLevel': educationLevel,
//       'specialty': specialty,
//     };
//   }

//   Course copyWith({
//     String? id,
//     String? title,
//     String? description,
//     String? gameGenre,
//     String? difficulty,
//     String? creatorId,
//     DateTime? createdAt,
//     List<String>? levelIds,
//     String? educationLevel,
//     String? specialty,
//   }) {
//     return Course(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       gameGenre: gameGenre ?? this.gameGenre,
//       difficulty: difficulty ?? this.difficulty,
//       creatorId: creatorId ?? this.creatorId,
//       createdAt: createdAt ?? this.createdAt,
//       levelIds: levelIds ?? this.levelIds,
//       educationLevel: educationLevel ?? this.educationLevel,
//       specialty: specialty ?? this.specialty,
//     );
//   }

//   @override
//   String toString() {
//     return 'Course(id: $id, title: $title, description: $description, gameGenre: $gameGenre, difficulty: $difficulty, creatorId: $creatorId, createdAt: $createdAt, levelIds: $levelIds, educationLevel: $educationLevel, specialty: $specialty)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Course &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           title == other.title &&
//           description == other.description &&
//           gameGenre == other.gameGenre &&
//           difficulty == other.difficulty &&
//           creatorId == other.creatorId &&
//           createdAt == other.createdAt &&
//           listEquals(levelIds, other.levelIds) &&
//           educationLevel == other.educationLevel &&
//           specialty == other.specialty;

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       title.hashCode ^
//       description.hashCode ^
//       gameGenre.hashCode ^
//       difficulty.hashCode ^
//       creatorId.hashCode ^
//       createdAt.hashCode ^
//       listEquals(levelIds, levelIds).hashCode ^
//       educationLevel.hashCode ^
//       specialty.hashCode;
// }
// // lib/models/community_post.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

// @immutable
// class CommunityPost {
//   final String id;
//   final String authorId;
//   final String authorUsername;
//   final String authorAvatarUrl;
//   final String content;
//   final String? imageUrl;
//   final DateTime timestamp;
//   final List<String> likedBy;
//   final List<Comment> comments;

//   const CommunityPost({
//     required this.id,
//     required this.authorId,
//     required this.authorUsername,
//     required this.authorAvatarUrl,
//     required this.content,
//     this.imageUrl,
//     required this.timestamp,
//     this.likedBy = const [],
//     this.comments = const [],
//   });

//   factory CommunityPost.fromMap(Map<String, dynamic> map) {
//     return CommunityPost(
//       id: map['id'] as String,
//       authorId: map['authorId'] as String,
//       authorUsername: map['authorUsername'] as String,
//       authorAvatarUrl: map['authorAvatarUrl'] as String,
//       content: map['content'] as String,
//       imageUrl: map['imageUrl'] as String?,
//       timestamp: (map['timestamp'] as Timestamp).toDate(),
//       likedBy: List<String>.from(map['likedBy'] ?? []),
//       comments: (map['comments'] as List<dynamic>?)
//               ?.map((c) => Comment.fromMap(c as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'authorId': authorId,
//       'authorUsername': authorUsername,
//       'authorAvatarUrl': authorAvatarUrl,
//       'content': content,
//       'imageUrl': imageUrl,
//       'timestamp': Timestamp.fromDate(timestamp),
//       'likedBy': likedBy,
//       'comments': comments.map((c) => c.toMap()).toList(),
//     };
//   }

//   CommunityPost copyWith({
//     String? id,
//     String? authorId,
//     String? authorUsername,
//     String? authorAvatarUrl,
//     String? content,
//     String? imageUrl,
//     DateTime? timestamp,
//     List<String>? likedBy,
//     List<Comment>? comments,
//   }) {
//     return CommunityPost(
//       id: id ?? this.id,
//       authorId: authorId ?? this.authorId,
//       authorUsername: authorUsername ?? this.authorUsername,
//       authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
//       content: content ?? this.content,
//       imageUrl: imageUrl ?? this.imageUrl,
//       timestamp: timestamp ?? this.timestamp,
//       likedBy: likedBy ?? this.likedBy,
//       comments: comments ?? this.comments,
//     );
//   }

//   @override
//   String toString() {
//     return 'CommunityPost(id: $id, authorId: $authorId, authorUsername: $authorUsername, content: $content, imageUrl: $imageUrl, timestamp: $timestamp, likedBy: $likedBy, comments: $comments)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is CommunityPost &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           authorId == other.authorId &&
//           authorUsername == other.authorUsername &&
//           authorAvatarUrl == other.authorAvatarUrl &&
//           content == other.content &&
//           imageUrl == other.imageUrl &&
//           timestamp == other.timestamp &&
//           listEquals(likedBy, other.likedBy) &&
//           listEquals(comments, other.comments);

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       authorId.hashCode ^
//       authorUsername.hashCode ^
//       authorAvatarUrl.hashCode ^
//       content.hashCode ^
//       imageUrl.hashCode ^
//       timestamp.hashCode ^
//       listEquals(likedBy, likedBy).hashCode ^
//       listEquals(comments, comments).hashCode;
// }

// @immutable
// class Comment {
//   final String id;
//   final String userId;
//   final String username;
//   final String avatarUrl;
//   final String text;
//   final DateTime timestamp;

//   const Comment({
//     required this.id,
//     required this.userId,
//     required this.username,
//     required this.avatarUrl,
//     required this.text,
//     required this.timestamp,
//   });

//   factory Comment.fromMap(Map<String, dynamic> map) {
//     return Comment(
//       id: map['id'] as String,
//       userId: map['userId'] as String,
//       username: map['username'] as String,
//       avatarUrl: map['avatarUrl'] as String,
//       text: map['text'] as String,
//       timestamp: (map['timestamp'] as Timestamp).toDate(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'userId': userId,
//       'username': username,
//       'avatarUrl': avatarUrl,
//       'text': text,
//       'timestamp': Timestamp.fromDate(timestamp),
//     };
//   }

//   @override
//   String toString() {
//     return 'Comment(id: $id, userId: $userId, username: $username, text: $text, timestamp: $timestamp)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Comment &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           userId == other.userId &&
//           username == other.username &&
//           avatarUrl == other.avatarUrl &&
//           text == other.text &&
//           timestamp == other.timestamp;

//   @override
//   int get hashCode =>
//       id.hashCode ^ userId.hashCode ^ username.hashCode ^ avatarUrl.hashCode ^ text.hashCode ^ timestamp.hashCode;
// }
// // lib/models/chat_message.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

// @immutable
// class ChatMessage {
//   final String id;
//   final String senderId;
//   final String senderUsername;
//   final String senderAvatarUrl;
//   final String text;
//   final DateTime timestamp;
//   final bool isUser;

//   const ChatMessage({
//     required this.id,
//     required this.senderId,
//     required this.senderUsername,
//     required this.senderAvatarUrl,
//     required this.text,
//     required this.timestamp,
//     required this.isUser,
//   });

//   factory ChatMessage.fromMap(Map<String, dynamic> map) {
//     return ChatMessage(
//       id: map['id'] as String,
//       senderId: map['senderId'] as String,
//       senderUsername: map['senderUsername'] as String,
//       senderAvatarUrl: map['senderAvatarUrl'] as String,
//       text: map['text'] as String,
//       timestamp: (map['timestamp'] as Timestamp).toDate(),
//       isUser: map['isUser'] as bool,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'senderId': senderId,
//       'senderUsername': senderUsername,
//       'senderAvatarUrl': senderAvatarUrl,
//       'text': text,
//       'timestamp': Timestamp.fromDate(timestamp),
//       'isUser': isUser,
//     };
//   }

//   @override
//   String toString() {
//     return 'ChatMessage(id: $id, senderId: $senderId, senderUsername: $senderUsername, text: $text, timestamp: $timestamp, isUser: $isUser)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is ChatMessage &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           senderId == other.senderId &&
//           senderUsername == other.senderUsername &&
//           senderAvatarUrl == other.senderAvatarUrl &&
//           text == other.text &&
//           timestamp == other.timestamp &&
//           isUser == other.isUser;

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       senderId.hashCode ^
//       senderUsername.hashCode ^
//       senderAvatarUrl.hashCode ^
//       text.hashCode ^
//       timestamp.hashCode ^
//       isUser.hashCode;
// }
// // lib/models/badge.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';

// @immutable
// class Badge {
//   final String id;
//   final String name;
//   final String description;
//   final IconData icon; // Storing IconData directly (requires Flutter import)
//   final String imageUrl; // Optional, for network images if needed

//   const Badge({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.icon,
//     this.imageUrl = '',
//   });

//   factory Badge.fromMap(Map<String, dynamic> map) {
//     return Badge(
//       id: map['id'] as String,
//       name: map['name'] as String,
//       description: map['description'] as String,
//       icon: IconData(map['iconCodePoint'] as int, fontFamily: map['iconFontFamily'] as String),
//       imageUrl: map['imageUrl'] as String? ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'iconCodePoint': icon.codePoint,
//       'iconFontFamily': icon.fontFamily,
//       'imageUrl': imageUrl,
//     };
//   }

//   @override
//   String toString() {
//     return 'Badge(id: $id, name: $name, description: $description, icon: $icon, imageUrl: $imageUrl)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Badge &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           name == other.name &&
//           description == other.description &&
//           icon == other.icon &&
//           imageUrl == other.imageUrl;

//   @override
//   int get hashCode =>
//       id.hashCode ^ name.hashCode ^ description.hashCode ^ icon.hashCode ^ imageUrl.hashCode;
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

//   factory AvatarAsset.fromMap(Map<String, dynamic> map) {
//     return AvatarAsset(
//       id: map['id'] as String,
//       name: map['name'] as String,
//       assetPath: map['assetPath'] as String,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'assetPath': assetPath,
//     };
//   }

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
//   static const Color primaryColor = Color(0xFF6A1B9A);
//   static const Color primaryColorDark = Color(0xFF4A148C);
//   static const Color accentColor = Color(0xFF00E5FF);
//   static const Color secondaryColor = Color(0xFFE040FB);
//   static const Color textColor = Color(0xFFE0E0E0);
//   static const Color textColorSecondary = Color(0xFFB0BEC5);
//   static const Color cardColor = Color(0xFF2C2C2C);
//   static const Color backgroundColor = Color(0xFF121212);
//   static const Color borderColor = Color(0xFF424242);
//   static const Color successColor = Color(0xFF00C853);
//   static const Color errorColor = Color(0xFFD50000);
//   static const Color warningColor = Color(0xFFFFC400);
//   static const Color infoColor = Color(0xFF2196F3);
//   static const Color xpColor = Color(0xFFFDD835);
//   static const Color levelColor = Color(0xFF8BC34A);
//   static const Color streakColor = Color(0xFFFD8C00); // New streak color
//   static const Color progressTrackColor = Color(0xFF37474F);

//   static LinearGradient backgroundGradient() {
//     return const LinearGradient(
//       colors: [
//         backgroundColor,
//         Color(0xFF1A237E),
//         primaryColorDark,
//       ],
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//     );
//   }

//   static TextStyle neonTextStyle({
//     double fontSize = 24,
//     FontWeight fontWeight = FontWeight.bold,
//     Color color = accentColor,
//     double blurRadius = 15.0,
//     double spreadRadius = 0.0,
//   }) {
//     return TextStyle(
//       fontSize: fontSize,
//       fontWeight: fontWeight,
//       color: color,
//       shadows: [
//         Shadow(
//           color: color.withOpacity(0.8),
//           blurRadius: blurRadius,
//         ),
//         Shadow(
//           color: color.withOpacity(0.4),
//           blurRadius: blurRadius * 2,
//         ),
//       ],
//     );
//   }
// }
// // lib/constants/app_constants.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/models/avatar_asset.dart';

// class AppConstants {
//   static const String appName = 'Gamifier';

//   // API Keys
//   static const String geminiApiKey = 'AIzaSyDZ6yDuQgQWxzc5Qq24Dpf_BkvcOjx_SP8'; // Replace with your actual Gemini API Key
//   static const String appTagline = 'Learn. Play. Conquer.';
//   // Firestore Collection Names
//   static const String usersCollection = 'users';
//   static const String coursesCollection = 'courses';
//   static const String levelsCollection = 'levels';
//   static const String lessonsCollection = 'lessons'; // Subcollection under levels
//   static const String questionsCollection = 'questions'; // Subcollection under lessons
//   static const String userProgressCollection = 'userProgress';
//   static const String badgesCollection = 'badges';
//   static const String communityPostsCollection = 'communityPosts';
//   static const String chatMessagesCollection = 'chatMessages';

//   // App theming and UI
//   static const double padding = 16.0;
//   static const double spacing = 8.0;
//   static const double borderRadius = 12.0;
//   static const double iconSize = 24.0;
//   static const double avatarSize = 60.0;
//   static const double badgeSize = 80.0;
//   static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

//   // Gamification Constants
//    // Gamification Constants
//   static const int initialXp = 0; // Added: Initial XP for a new user profile
//   static const int xpPerLevel = 100;
//   static const int leaderboardLimit = 10; // Number of users to show on leaderboard
//   static const int minStreakDaysForBonus = 3;
//   static const int streakBonusXp = 20;

//   // Course Generation Constants
//   static const int initialLevelsCount = 5; // Generate first 5 levels
//   static const int subsequentLevelsBatchSize = 5; // Generate 5 more levels at a time
//   static const int maxLevelsPerCourse = 15; // Max total levels

//   // Default Content for Placeholders/Initial Data
//   static String defaultFontFamily = 'Inter';

//   static const double geminiTemperature = 0.7;
//   static const int geminiMaxOutputTokens = 2000;

//   static const List<AvatarAsset> defaultAvatarAssets = [
//     AvatarAsset(id: 'avatar1', name: 'Adventurer', assetPath: 'assets/avatars/avatar1.png'),
//     AvatarAsset(id: 'avatar2', name: 'Explorer', assetPath: 'assets/avatars/avatar2.png'),
//     AvatarAsset(id: 'avatar3', name: 'Wizard', assetPath: 'assets/avatars/avatar3.png'),
//     AvatarAsset(id: 'avatar4', name: 'Knight', assetPath: 'assets/avatars/avatar4.png'),
//   ];

//   static const String correctSoundPath = 'audios/correct.mp3';
//   static const String levelUpSoundPath = 'audios/level_up.mp3';

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
//     'Doctorate',
//     'Self-Taught',
//   ];

//   static const List<String> defaultCourseTopics = [
//     'Artificial Intelligence',
//     'Machine Learning',
//     'Web Development (Frontend)',
//     'Web Development (Backend)',
//     'Mobile App Development (Flutter)',
//     'Data Science',
//     'Cybersecurity',
//     'Cloud Computing',
//     'Game Development',
//     'Database Management',
//     'Network Engineering',
//     'DevOps',
//     'UI/UX Design',
//     'Digital Marketing',
//     'Business Analytics',
//     'Project Management',
//   ];
// }
