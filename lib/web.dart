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
//     debugPrint('Error initializing Firebase: $e');
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
// // lib/widgets/questions/scenario_question_widget.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/widgets/lesson/question_widget.dart';

// class ScenarioQuestionWidget extends StatelessWidget {
//   final Question question;
//   final ValueChanged<String> onSubmit;
//   final bool isSubmitted;
//   final String? lastUserAnswer;
//   final bool? isLastAttemptCorrect;
//   final int? xpAwarded;

//   const ScenarioQuestionWidget({
//     super.key,
//     required this.question,
//     required this.onSubmit,
//     this.isSubmitted = false,
//     this.lastUserAnswer,
//     this.isLastAttemptCorrect,
//     this.xpAwarded,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return QuestionWidget(
//       question: question,
//       onSubmit: onSubmit,
//       isSubmitted: isSubmitted,
//       lastUserAnswer: lastUserAnswer,
//       isLastAttemptCorrect: isLastAttemptCorrect,
//       xpAwarded: xpAwarded,
//     );
//   }
// }
// // lib/widgets/questions/short_answer_question_widget.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/widgets/lesson/question_widget.dart';

// class ShortAnswerQuestionWidget extends StatelessWidget {
//   final Question question;
//   final ValueChanged<String> onSubmit;
//   final bool isSubmitted;
//   final String? lastUserAnswer;
//   final bool? isLastAttemptCorrect;
//   final int? xpAwarded;

//   const ShortAnswerQuestionWidget({
//     super.key,
//     required this.question,
//     required this.onSubmit,
//     this.isSubmitted = false,
//     this.lastUserAnswer,
//     this.isLastAttemptCorrect,
//     this.xpAwarded,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return QuestionWidget(
//       question: question,
//       onSubmit: onSubmit,
//       isSubmitted: isSubmitted,
//       lastUserAnswer: lastUserAnswer,
//       isLastAttemptCorrect: isLastAttemptCorrect,
//       xpAwarded: xpAwarded,
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

// class QuestionRenderer extends StatelessWidget {
//   final Question question;
//   final ValueChanged<String> onSubmit;
//   final bool isSubmitted;
//   final String? lastUserAnswer;
//   final bool? isLastAttemptCorrect;
//   final int? xpAwarded;

//   const QuestionRenderer({
//     super.key,
//     required this.question,
//     required this.onSubmit,
//     this.isSubmitted = false,
//     this.lastUserAnswer,
//     this.isLastAttemptCorrect,
//     this.xpAwarded,
//   });

//   @override
//   Widget build(BuildContext context) {
//     switch (question.type) {
//       case 'MCQ':
//         return McqQuestionWidget(
//           question: question,
//           onSubmit: onSubmit,
//           isSubmitted: isSubmitted,
//           lastUserAnswer: lastUserAnswer,
//           isLastAttemptCorrect: isLastAttemptCorrect,
//           xpAwarded: xpAwarded,
//         );
//       case 'FillInBlank':
//         return FillInBlankQuestionWidget(
//           question: question,
//           onSubmit: onSubmit,
//           isSubmitted: isSubmitted,
//           lastUserAnswer: lastUserAnswer,
//           isLastAttemptCorrect: isLastAttemptCorrect,
//           xpAwarded: xpAwarded,
//         );
//       case 'ShortAnswer':
//         return ShortAnswerQuestionWidget(
//           question: question,
//           onSubmit: onSubmit,
//           isSubmitted: isSubmitted,
//           lastUserAnswer: lastUserAnswer,
//           isLastAttemptCorrect: isLastAttemptCorrect,
//           xpAwarded: xpAwarded,
//         );
//       case 'Scenario':
//         return ScenarioQuestionWidget(
//           question: question,
//           onSubmit: onSubmit,
//           isSubmitted: isSubmitted,
//           lastUserAnswer: lastUserAnswer,
//           isLastAttemptCorrect: isLastAttemptCorrect,
//           xpAwarded: xpAwarded,
//         );
//       default:
//         return Center(child: Text('Unknown question type: ${question.type}'));
//     }
//   }
// }
// // lib/widgets/questions/mcq_question_widget.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/widgets/lesson/question_widget.dart';

// class McqQuestionWidget extends StatelessWidget {
//   final Question question;
//   final ValueChanged<String> onSubmit;
//   final bool isSubmitted;
//   final String? lastUserAnswer;
//   final bool? isLastAttemptCorrect;
//   final int? xpAwarded;

//   const McqQuestionWidget({
//     super.key,
//     required this.question,
//     required this.onSubmit,
//     this.isSubmitted = false,
//     this.lastUserAnswer,
//     this.isLastAttemptCorrect,
//     this.xpAwarded,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return QuestionWidget(
//       question: question,
//       onSubmit: onSubmit,
//       isSubmitted: isSubmitted,
//       lastUserAnswer: lastUserAnswer,
//       isLastAttemptCorrect: isLastAttemptCorrect,
//       xpAwarded: xpAwarded,
//     );
//   }
// }
// // lib/widgets/questions/fill_in_blank_question_widget.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/widgets/lesson/question_widget.dart';

// class FillInBlankQuestionWidget extends StatelessWidget {
//   final Question question;
//   final ValueChanged<String> onSubmit;
//   final bool isSubmitted;
//   final String? lastUserAnswer;
//   final bool? isLastAttemptCorrect;
//   final int? xpAwarded;

//   const FillInBlankQuestionWidget({
//     super.key,
//     required this.question,
//     required this.onSubmit,
//     this.isSubmitted = false,
//     this.lastUserAnswer,
//     this.isLastAttemptCorrect,
//     this.xpAwarded,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return QuestionWidget(
//       question: question,
//       onSubmit: onSubmit,
//       isSubmitted: isSubmitted,
//       lastUserAnswer: lastUserAnswer,
//       isLastAttemptCorrect: isLastAttemptCorrect,
//       xpAwarded: xpAwarded,
//     );
//   }
// }
// // lib/widgets/navigation/bottom_nav_bar.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/utils/app_router.dart';

// class BottomNavBar extends StatelessWidget {
//   final int currentIndex;

//   const BottomNavBar({
//     super.key,
//     required this.currentIndex,
//   });

//   void _onItemTapped(BuildContext context, int index) {
//     // Determine if we should replace the current route or push a new one
//     // Course Creation (index 4) should push, allowing back navigation to the previous main screen.
//     // Other main screens (Home, Progress, Community, AI Tutor, Profile) should replace to avoid deep navigation stacks.
//     if (index == currentIndex) return; // Prevent navigating to the same route again

//     switch (index) {
//       case 0:
//         Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//         break;
//       case 1:
//         Navigator.of(context).pushReplacementNamed(AppRouter.progressRoute);
//         break;
//       case 2:
//         Navigator.of(context).pushReplacementNamed(AppRouter.communityRoute);
//         break;
//       case 3:
//         Navigator.of(context).pushReplacementNamed(AppRouter.chatRoute);
//         break;
//       case 4: // Create Course
//         // Use pushNamed to allow navigating back to the previous main tab
//         Navigator.of(context).pushNamed(AppRouter.courseCreationRoute);
//         break;
//       case 5:
//         Navigator.of(context).pushReplacementNamed(AppRouter.profileRoute);
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: (index) => _onItemTapped(context, index),
//       backgroundColor: AppColors.primaryColorDark.withOpacity(0.9),
//       selectedItemColor: AppColors.accentColor,
//       unselectedItemColor: AppColors.textColorSecondary,
//       type: BottomNavigationBarType.fixed,
//       selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//       unselectedLabelStyle: const TextStyle(fontSize: 11),
//       elevation: 8,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.show_chart),
//           label: 'Progress',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.group),
//           label: 'Community',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.chat),
//           label: 'AI Tutor',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.add_box), // Icon for Create Course
//           label: 'Create Course',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }
// // lib/widgets/lesson/question_widget.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/custom_text_field.dart';

// class QuestionWidget extends StatefulWidget {
//   final Question question;
//   final ValueChanged<String> onSubmit;
//   final bool isSubmitted;
//   final String? lastUserAnswer;
//   final bool? isLastAttemptCorrect;
//   final int? xpAwarded;

//   const QuestionWidget({
//     super.key,
//     required this.question,
//     required this.onSubmit,
//     this.isSubmitted = false,
//     this.lastUserAnswer,
//     this.isLastAttemptCorrect,
//     this.xpAwarded,
//   });

//   @override
//   State<QuestionWidget> createState() => _QuestionWidgetState();
// }

// class _QuestionWidgetState extends State<QuestionWidget> {
//   final TextEditingController _textAnswerController = TextEditingController();
//   String? _selectedMcqOption;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.isSubmitted) {
//       if (widget.question.type == 'MCQ') {
//         _selectedMcqOption = widget.lastUserAnswer;
//       } else {
//         _textAnswerController.text = widget.lastUserAnswer ?? '';
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _textAnswerController.dispose();
//     super.dispose();
//   }

//   Widget _buildQuestionInput() {
//     switch (widget.question.type) {
//       case 'MCQ':
//         return Column(
//           children: widget.question.options!.map((option) {
//             return RadioListTile<String>(
//               title: Text(
//                 option,
//                 style: TextStyle(
//                   color: widget.isSubmitted && _selectedMcqOption == option
//                       ? (widget.isLastAttemptCorrect! ? AppColors.successColor : AppColors.errorColor)
//                       : AppColors.textColor,
//                 ),
//               ),
//               value: option,
//               groupValue: _selectedMcqOption,
//               onChanged: widget.isSubmitted
//                   ? null
//                   : (value) {
//                       setState(() {
//                         _selectedMcqOption = value;
//                       });
//                     },
//               activeColor: AppColors.accentColor,
//               tileColor: AppColors.cardColor.withOpacity(0.5),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                 side: BorderSide(
//                   color: widget.isSubmitted && _selectedMcqOption == option
//                       ? (widget.isLastAttemptCorrect! ? AppColors.successColor : AppColors.errorColor)
//                       : Colors.transparent,
//                   width: 2,
//                 ),
//               ),
//             );
//           }).toList(),
//         );
//       case 'FillInBlank':
//       case 'ShortAnswer':
//         return CustomTextField(
//           controller: _textAnswerController,
//           labelText: 'Your Answer',
//           icon: Icons.text_fields,
//           keyboardType: TextInputType.text,
//           maxLines: 2,
//           readOnly: widget.isSubmitted,
//         );
//       case 'Scenario':
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(AppConstants.padding),
//               decoration: BoxDecoration(
//                 color: AppColors.cardColor.withOpacity(0.7),
//                 borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                 border: Border.all(color: AppColors.borderColor),
//               ),
//               child: Text(
//                 widget.question.scenarioText ?? 'No scenario provided.',
//                 style: const TextStyle(color: AppColors.textColor, fontSize: 16, fontStyle: FontStyle.italic),
//               ),
//             ),
//             const SizedBox(height: AppConstants.spacing * 2),
//             CustomTextField(
//               controller: _textAnswerController,
//               labelText: 'What is the expected outcome?',
//               icon: Icons.lightbulb_outline,
//               keyboardType: TextInputType.text,
//               maxLines: 3,
//               readOnly: widget.isSubmitted,
//             ),
//           ],
//         );
//       default:
//         return const Text('Unsupported Question Type');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         side: widget.isSubmitted
//             ? BorderSide(
//                 color: widget.isLastAttemptCorrect! ? AppColors.successColor : AppColors.errorColor,
//                 width: 2,
//               )
//             : BorderSide.none,
//       ),
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.question.questionText,
//               style: const TextStyle(
//                 color: AppColors.textColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: AppConstants.spacing * 2),
//             _buildQuestionInput(),
//             const SizedBox(height: AppConstants.spacing * 2),
//             if (!widget.isSubmitted)
//               CustomButton(
//                 onPressed: () {
//                   String answer = '';
//                   if (widget.question.type == 'MCQ') {
//                     answer = _selectedMcqOption ?? '';
//                   } else {
//                     answer = _textAnswerController.text;
//                   }
//                   widget.onSubmit(answer);
//                 },
//                 text: 'Submit Answer',
//                 icon: Icons.send,
//               ),
//             if (widget.isSubmitted)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         widget.isLastAttemptCorrect! ? 'Correct!' : 'Incorrect.',
//                         style: TextStyle(
//                           color: widget.isLastAttemptCorrect! ? AppColors.successColor : AppColors.errorColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       if (widget.xpAwarded != null && widget.xpAwarded! > 0)
//                         Text(
//                           '+${widget.xpAwarded} XP',
//                           style: const TextStyle(
//                             color: AppColors.xpColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                     ],
//                   ),
//                   const SizedBox(height: AppConstants.spacing),
//                   Text(
//                     'Your Answer: "${widget.lastUserAnswer}"',
//                     style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 14),
//                   ),
//                   if (!widget.isLastAttemptCorrect!)
//                     Text(
//                       'Correct Answer: ${widget.question.correctAnswer ?? widget.question.expectedAnswerKeywords ?? widget.question.expectedOutcome}',
//                       style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 14),
//                     ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/lesson/lesson_content_display.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:url_launcher/url_launcher.dart';

// class LessonContentDisplay extends StatelessWidget {
//   final String content;

//   const LessonContentDisplay({
//     super.key,
//     required this.content,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MarkdownBody(
//       data: content,
//       selectable: true,
//       onTapLink: (text, href, title) async {
//         if (href != null) {
//           final Uri url = Uri.parse(href);
//           if (await canLaunchUrl(url)) {
//             await launchUrl(url, mode: LaunchMode.externalApplication);
//           } else {
//             debugPrint('Could not launch $url');
//           }
//         }
//       },
//       styleSheet: MarkdownStyleSheet(
//         // Ensure paragraph text has a clear, non-neon style
//         p: const TextStyle(color: AppColors.textColor, fontSize: 16),
        
//         // Apply neon style specifically to headings
//         h1: AppColors.neonTextStyle(fontSize: 28, color: AppColors.accentColor, blurRadius: 10, fontWeight: FontWeight.bold),
//         h2: AppColors.neonTextStyle(fontSize: 24, color: AppColors.secondaryColor, blurRadius: 8, fontWeight: FontWeight.bold),
//         h3: const TextStyle(color: AppColors.textColor, fontSize: 20, fontWeight: FontWeight.bold),
//         h4: const TextStyle(color: AppColors.textColor, fontSize: 18, fontWeight: FontWeight.bold),
//         strong: const TextStyle(color: AppColors.xpColor, fontWeight: FontWeight.bold),
//         em: const TextStyle(fontStyle: FontStyle.italic, color: AppColors.textColorSecondary),
//         blockquote: const TextStyle(color: AppColors.textColorSecondary, fontStyle: FontStyle.italic),
//         code: const TextStyle(color: AppColors.accentColor, backgroundColor: AppColors.cardColor, fontFamily: 'monospace'),
//         codeblockDecoration: BoxDecoration(
//           color: AppColors.cardColor.withOpacity(0.5),
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           border: Border.all(color: AppColors.borderColor),
//         ),
//         listBullet: const TextStyle(color: AppColors.textColor),
//         checkbox: const TextStyle(color: AppColors.textColor),
//         a: const TextStyle(color: AppColors.accentColor, decoration: TextDecoration.underline),
//       ),
//     );
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
//       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
//       decoration: BoxDecoration(
//         color: AppColors.streakColor.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         border: Border.all(color: AppColors.streakColor, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.streakColor.withOpacity(0.3),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(
//             Icons.local_fire_department,
//             color: AppColors.streakColor,
//             size: AppConstants.iconSize + 8,
//           ),
//           const SizedBox(width: AppConstants.spacing),
//           Text(
//             '$currentStreak-Day Streak!',
//             style: const TextStyle(
//               color: AppColors.streakColor,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           if (currentStreak >= AppConstants.minStreakDaysForBonus) ...[
//             const SizedBox(width: AppConstants.spacing),
//             const Tooltip(
//               message: 'XP Bonus for maintaining streak!',
//               child: Icon(Icons.star, color: AppColors.xpColor, size: AppConstants.iconSize),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
// // lib/widgets/gamification/level_path_painter.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/models/level.dart';

// class LevelPathPainter extends CustomPainter {
//   final List<Level> levels;
//   final Map<String, Offset> levelPositions;
//   final Map<String, bool> levelCompletionStatus;
//   final double nodeSize; // Added nodeSize to correctly calculate center points

//   LevelPathPainter({
//     required this.levels,
//     required this.levelPositions,
//     required this.levelCompletionStatus,
//     this.nodeSize = 120.0, // Default node size, ensure it matches LevelNode
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint completedPathPaint = Paint()
//       ..color = AppColors.successColor
//       ..strokeWidth = 4.0
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     final Paint upcomingPathPaint = Paint()
//       ..color = AppColors.borderColor.withOpacity(0.7) // Darker for visibility
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     for (int i = 0; i < levels.length - 1; i++) {
//       final Level currentLevel = levels[i];
//       final Level nextLevel = levels[i + 1];

//       final Offset? startNodeTopLeft = levelPositions[currentLevel.id];
//       final Offset? endNodeTopLeft = levelPositions[nextLevel.id];

//       if (startNodeTopLeft != null && endNodeTopLeft != null) {
//         // Calculate center points of the nodes
//         final Offset startPoint = Offset(startNodeTopLeft.dx + nodeSize / 2, startNodeTopLeft.dy + nodeSize / 2);
//         final Offset endPoint = Offset(endNodeTopLeft.dx + nodeSize / 2, endNodeTopLeft.dy + nodeSize / 2);

//         final bool isCurrentLevelCompleted = levelCompletionStatus[currentLevel.id] ?? false;

//         final path = Path();
//         path.moveTo(startPoint.dx, startPoint.dy);

//         // Determine if current level is on the left or right column
//         bool currentIsLeft = startNodeTopLeft.dx < size.width / 2;

//         // Calculate a control point for a smooth zigzag curve
//         // This creates a "bend" in the middle of the line segment
//         final double midX = (startPoint.dx + endPoint.dx) / 2;
//         final double midY = (startPoint.dy + endPoint.dy) / 2;

//         final double controlX;
//         final double controlY;

//         if (currentIsLeft) {
//           // If current is left, and next is right, control point goes down-right from midpoint
//           controlX = midX + 60; // Offset control point horizontally
//           controlY = midY + 40; // Offset control point vertically
//         } else {
//           // If current is right, and next is left, control point goes down-left from midpoint
//           controlX = midX - 60;
//           controlY = midY + 40;
//         }

//         path.quadraticBezierTo(controlX, controlY, endPoint.dx, endPoint.dy);

//         if (isCurrentLevelCompleted) {
//           canvas.drawPath(path, completedPathPaint);
//         } else {
//           canvas.drawPath(path, upcomingPathPaint);
//         }
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     LevelPathPainter oldPainter = oldDelegate as LevelPathPainter;
//     return levels != oldPainter.levels ||
//         levelPositions != oldPainter.levelPositions ||
//         levelCompletionStatus != oldPainter.levelCompletionStatus ||
//         nodeSize != oldPainter.nodeSize;
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
//   final VoidCallback onTap;

//   const LevelNode({
//     super.key,
//     required this.level,
//     required this.isCompleted,
//     required this.isLocked,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Color nodeColor = AppColors.cardColor;
//     Color iconColor = AppColors.textColorSecondary;
//     Color borderColor = AppColors.borderColor;
//     IconData icon = Icons.lock;

//     if (isCompleted) {
//       nodeColor = AppColors.successColor.withOpacity(0.3);
//       iconColor = AppColors.successColor;
//       borderColor = AppColors.successColor;
//       icon = Icons.check_circle_outline;
//     } else if (!isLocked) {
//       nodeColor = AppColors.accentColor.withOpacity(0.3);
//       iconColor = AppColors.accentColor;
//       borderColor = AppColors.accentColor;
//       icon = Icons.play_circle_outline;
//     }

//     return GestureDetector(
//       onTap: isLocked ? null : onTap,
//       child: AnimatedContainer(
//         duration: AppConstants.defaultAnimationDuration,
//         curve: Curves.easeInOut,
//         width: 120, // Fixed width for circular node
//         height: 120, // Fixed height for circular node
//         decoration: BoxDecoration(
//           color: nodeColor,
//           shape: BoxShape.circle, // Make it circular
//           border: Border.all(color: borderColor, width: 2),
//           boxShadow: [
//             BoxShadow(
//               color: borderColor.withOpacity(0.3),
//               blurRadius: 10,
//               spreadRadius: isCompleted ? 3 : 1,
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               color: iconColor,
//               size: 40, // Adjusted icon size for circular node
//             ),
//             const SizedBox(height: AppConstants.spacing / 2),
//             Text(
//               'Level ${level.order}',
//               style: TextStyle(
//                 color: iconColor,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing),
//               child: Text(
//                 level.title,
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   color: AppColors.textColorSecondary,
//                   fontSize: 10, // Adjusted font size
//                 ),
//               ),
//             ),
//             if (isLocked)
//               const Padding(
//                 padding: EdgeInsets.only(top: AppConstants.spacing / 2),
//                 child: Text(
//                   'Locked',
//                   style: TextStyle(
//                     color: AppColors.errorColor,
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/gamification/leaderboard_list.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/services/firebase_service.dart';

// class LeaderboardList extends StatelessWidget {
//   const LeaderboardList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<UserProfile>>(
//       stream: Provider.of<FirebaseService>(context).streamLeaderboard(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text('Error loading leaderboard: ${snapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
//         }
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(
//             child: Text(
//               'No users on the leaderboard yet. Be the first!',
//               style: TextStyle(color: AppColors.textColorSecondary),
//             ),
//           );
//         }

//         final users = snapshot.data!;
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: users.length,
//           itemBuilder: (context, index) {
//             final user = users[index];
//             return Card(
//               color: AppColors.cardColor.withOpacity(0.8),
//               margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(AppConstants.padding),
//                 child: Row(
//                   children: [
//                     Text(
//                       '${index + 1}.',
//                       style: AppColors.neonTextStyle(fontSize: 20, color: AppColors.xpColor),
//                     ),
//                     const SizedBox(width: AppConstants.spacing),
//                     CircleAvatar(
//                       radius: 20,
//                       backgroundImage: AssetImage(user.avatarAssetPath),
//                       backgroundColor: AppColors.borderColor,
//                     ),
//                     const SizedBox(width: AppConstants.spacing),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             user.username,
//                             style: const TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold, fontSize: 16),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Text(
//                             'Level: ${user.level}',
//                             style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 13),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           '${user.xp} XP',
//                           style: const TextStyle(color: AppColors.xpColor, fontWeight: FontWeight.bold, fontSize: 16),
//                         ),
//                         Text(
//                           '${user.currentStreak} 🔥',
//                           style: const TextStyle(color: AppColors.streakColor, fontSize: 13),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
// // lib/widgets/gamification/badge_display.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/badge.dart' as GamifierBadge; // Alias your custom Badge model

// class BadgeDisplay extends StatelessWidget {
//   final List<String> badgeIds; // Only display based on IDs for now

//   // Placeholder for actual badge data - in a real app, this would come from a service
//   static final Map<String, GamifierBadge.Badge> _allBadges = { // Changed to final and use aliased name
//     'first_course': const GamifierBadge.Badge( // Use const and aliased name
//       id: 'first_course',
//       name: 'First Course Conqueror',
//       description: 'Completed your first course!',
//       icon: Icons.star,
//     ),
//     'streak_master': const GamifierBadge.Badge( // Use const and aliased name
//       id: 'streak_master',
//       name: 'Streak Master',
//       description: 'Maintained a 7-day learning streak!',
//       icon: Icons.local_fire_department,
//     ),
//     'level_10': const GamifierBadge.Badge( // Use const and aliased name
//       id: 'level_10',
//       name: 'Level 10 Achiever',
//       description: 'Reached level 10!',
//       icon: Icons.trending_up,
//     ),
//     'community_contributor': const GamifierBadge.Badge( // Use const and aliased name
//       id: 'community_contributor',
//       name: 'Community Contributor',
//       description: 'Made 5 community posts!',
//       icon: Icons.people,
//     ),
//     'first_question_correct': const GamifierBadge.Badge( // Use const and aliased name
//       id: 'first_question_correct',
//       name: 'First Blood',
//       description: 'Answered your first question correctly!',
//       icon: Icons.check_circle,
//     ),
//   };

//   const BadgeDisplay({
//     super.key,
//     required this.badgeIds,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (badgeIds.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//       child: Row(
//         children: badgeIds.map((id) {
//           final badge = _allBadges[id];
//           if (badge == null) {
//             return const SizedBox.shrink();
//           }
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing / 2),
//             child: Tooltip(
//               message: '${badge.name}: ${badge.description}',
//               child: Container(
//                 width: AppConstants.badgeSize,
//                 height: AppConstants.badgeSize,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [AppColors.primaryColorDark, AppColors.secondaryColor],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.secondaryColor.withOpacity(0.3),
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       badge.icon,
//                       color: AppColors.xpColor,
//                       size: AppConstants.iconSize * 1.5,
//                     ),
//                     const SizedBox(height: AppConstants.spacing / 2),
//                     Text(
//                       badge.name,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: AppColors.textColor,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
// // lib/widgets/gamification/avatar_customizer.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/avatar_asset.dart';

// class AvatarCustomizer extends StatelessWidget {
//   final String? selectedAvatarPath;
//   final ValueChanged<AvatarAsset> onAvatarSelected;

//   const AvatarCustomizer({
//     super.key,
//     this.selectedAvatarPath,
//     required this.onAvatarSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Text(
//           'Choose Your Avatar',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textColor,
//           ),
//         ),
//         const SizedBox(height: AppConstants.spacing * 2),
//         Expanded(
//           child: GridView.builder(
//             padding: const EdgeInsets.all(AppConstants.padding),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: AppConstants.padding,
//               mainAxisSpacing: AppConstants.padding,
//               childAspectRatio: 1.0,
//             ),
//             itemCount: AppConstants.defaultAvatarAssets.length,
//             itemBuilder: (context, index) {
//               final avatar = AppConstants.defaultAvatarAssets[index];
//               final bool isSelected = avatar.assetPath == selectedAvatarPath;
//               return GestureDetector(
//                 onTap: () => onAvatarSelected(avatar),
//                 child: AnimatedContainer(
//                   duration: AppConstants.defaultAnimationDuration,
//                   curve: Curves.easeInOut,
//                   decoration: BoxDecoration(
//                     color: AppColors.cardColor.withOpacity(0.8),
//                     borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                     border: Border.all(
//                       color: isSelected ? AppColors.accentColor : AppColors.borderColor,
//                       width: isSelected ? 3 : 1,
//                     ),
//                     boxShadow: isSelected
//                         ? [
//                             BoxShadow(
//                               color: AppColors.accentColor.withOpacity(0.4),
//                               blurRadius: 10,
//                               spreadRadius: 2,
//                             ),
//                           ]
//                         : [],
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         avatar.assetPath,
//                         width: AppConstants.avatarSize * 1.5,
//                         height: AppConstants.avatarSize * 1.5,
//                         fit: BoxFit.contain,
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       Text(
//                         avatar.name,
//                         style: TextStyle(
//                           color: isSelected ? AppColors.accentColor : AppColors.textColor,
//                           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
// // lib/widgets/feedback/personalized_feedback_modal.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/services/gemini_api_service.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';

// class PersonalizedFeedbackModal extends StatefulWidget {
//   final bool isCorrect;
//   final String userAnswer;
//   final String questionText;
//   final dynamic correctAnswer; // Can be String or List<String>
//   final String lessonContent;
//   final UserProgress userProgress;

//   const PersonalizedFeedbackModal({
//     super.key,
//     required this.isCorrect,
//     required this.userAnswer,
//     required this.questionText,
//     required this.correctAnswer,
//     required this.lessonContent,
//     required this.userProgress,
//   });

//   @override
//   State<PersonalizedFeedbackModal> createState() => _PersonalizedFeedbackModalState();
// }

// class _PersonalizedFeedbackModalState extends State<PersonalizedFeedbackModal> {
//   bool _isLoadingFeedback = true;
//   String _feedbackText = '';
//   String _socraticFollowUp = '';
//   String _adaptiveHints = '';
//   String _encouragement = '';
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _generateFeedback();
//   }

//   Future<void> _generateFeedback() async {
//     setState(() {
//       _isLoadingFeedback = true;
//       _errorMessage = null;
//     });

//     try {
//       final geminiService = Provider.of<GeminiApiService>(context, listen: false);
//       final feedback = await geminiService.generateSocraticFeedback(
//         userAnswer: widget.userAnswer,
//         questionText: widget.questionText,
//         correctAnswer: widget.correctAnswer.toString(),
//         lessonContent: widget.lessonContent,
//         userProgress: widget.userProgress,
//       );

//       setState(() {
//         _feedbackText = feedback['feedbackText'] ?? 'No specific feedback provided.';
//         _socraticFollowUp = feedback['socraticFollowUp'] ?? '';
//         _adaptiveHints = feedback['adaptiveHints'] ?? '';
//         _encouragement = feedback['encouragement'] ?? 'Keep up the great work!';
//       });
//     } catch (e) {
//       debugPrint('Error generating feedback: $e');
//       setState(() {
//         _errorMessage = 'Failed to generate personalized feedback: ${e.toString()}';
//         _feedbackText = widget.isCorrect
//             ? 'That\'s correct! Well done!'
//             : 'Not quite. The correct answer was: ${widget.correctAnswer}.';
//         _encouragement = 'Keep trying!';
//       });
//     } finally {
//       setState(() {
//         _isLoadingFeedback = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.of(context).pop(),
//       child: Container(
//         color: Colors.black54,
//         child: Center(
//           child: GestureDetector(
//             onTap: () {}, // Prevent tap from closing modal
//             child: Material(
//               color: Colors.transparent,
//               child: Container(
//                 margin: const EdgeInsets.all(AppConstants.padding * 2),
//                 padding: const EdgeInsets.all(AppConstants.padding * 1.5),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.cardColor.withOpacity(0.95),
//                       AppColors.backgroundColor.withOpacity(0.95),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
//                   border: Border.all(
//                     color: widget.isCorrect ? AppColors.successColor : AppColors.errorColor,
//                     width: 3,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: widget.isCorrect
//                           ? AppColors.successColor.withOpacity(0.3)
//                           : AppColors.errorColor.withOpacity(0.3),
//                       blurRadius: 20,
//                       spreadRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Icon(
//                           widget.isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined,
//                           color: widget.isCorrect ? AppColors.successColor : AppColors.errorColor,
//                           size: 70,
//                         ),
//                       ),
//                       const SizedBox(height: AppConstants.spacing * 2),
//                       Center(
//                         child: Text(
//                           widget.isCorrect ? 'Correct Answer!' : 'Incorrect Answer.',
//                           style: AppColors.neonTextStyle(
//                             fontSize: 28,
//                             color: widget.isCorrect ? AppColors.successColor : AppColors.errorColor,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       Text(
//                         'Your Answer: "${widget.userAnswer}"',
//                         style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16, fontStyle: FontStyle.italic),
//                         textAlign: TextAlign.center,
//                       ),
//                       if (!widget.isCorrect) ...[
//                         const SizedBox(height: AppConstants.spacing),
//                         Text(
//                           'Correct Answer: "${widget.correctAnswer}"',
//                           style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16, fontStyle: FontStyle.italic),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                       const SizedBox(height: AppConstants.spacing * 2),
//                       _isLoadingFeedback
//                           ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//                           : _errorMessage != null
//                               ? Center(
//                                   child: Text(
//                                     _errorMessage!,
//                                     style: const TextStyle(color: AppColors.errorColor, fontSize: 16),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 )
//                               : Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'AI Tutor Feedback:',
//                                       style: AppColors.neonTextStyle(fontSize: 18, color: AppColors.accentColor),
//                                     ),
//                                     const SizedBox(height: AppConstants.spacing),
//                                     Text(
//                                       _feedbackText,
//                                       style: const TextStyle(color: AppColors.textColor, fontSize: 16),
//                                     ),
//                                     if (_socraticFollowUp.isNotEmpty) ...[
//                                       const SizedBox(height: AppConstants.spacing),
//                                       Text(
//                                         'Think about it: $_socraticFollowUp',
//                                         style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 15, fontStyle: FontStyle.italic),
//                                       ),
//                                     ],
//                                     if (_adaptiveHints.isNotEmpty) ...[
//                                       const SizedBox(height: AppConstants.spacing),
//                                       Text(
//                                         'Hint: $_adaptiveHints',
//                                         style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 15),
//                                       ),
//                                     ],
//                                     const SizedBox(height: AppConstants.spacing * 2),
//                                     Center(
//                                       child: Text(
//                                         _encouragement,
//                                         style: const TextStyle(color: AppColors.xpColor, fontSize: 17, fontWeight: FontWeight.bold),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                       const SizedBox(height: AppConstants.spacing * 3),
//                       CustomButton(
//                         onPressed: _isLoadingFeedback ? null : () => Navigator.of(context).pop(),
//                         text: 'Continue',
//                         icon: Icons.arrow_forward,
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
// // lib/widgets/course/course_form.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/widgets/common/custom_text_field.dart';
// import 'package:gamifier/utils/validation_utils.dart';

// class CourseForm extends StatelessWidget {
//   final ValueChanged<String> onTopicChanged;
//   final ValueChanged<String> onDomainChanged;
//   final ValueChanged<String?> onDifficultyChanged;
//   final ValueChanged<String?> onEducationLevelChanged;
//   final ValueChanged<String?> onLanguageChanged; // Changed from onGameGenreChanged
//   final ValueChanged<String> onYoutubeUrlChanged;
//   final ValueChanged<String> onSourceContentChanged; // Not directly used here, but keeps signature consistent
//   final String currentDifficulty;
//   final String currentEducationLevel;
//   final String currentLanguage; // Changed from currentGameGenre

//   const CourseForm({
//     super.key,
//     required this.onTopicChanged,
//     required this.onDomainChanged,
//     required this.onDifficultyChanged,
//     required this.onEducationLevelChanged,
//     required this.onLanguageChanged, // Changed here
//     required this.onYoutubeUrlChanged,
//     required this.onSourceContentChanged,
//     required this.currentDifficulty,
//     required this.currentEducationLevel,
//     required this.currentLanguage, // Changed here
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CustomTextField(
//           labelText: 'Course Topic (e.g., "Quantum Physics")',
//           icon: Icons.topic,
//           onChanged: onTopicChanged,
//           validator: (value) => ValidationUtils.validateField(value, 'Course Topic'),
//         ),
//         const SizedBox(height: AppConstants.spacing * 2),
//         CustomTextField(
//           labelText: 'Domain (e.g., "Science", "Technology")',
//           icon: Icons.domain,
//           onChanged: onDomainChanged,
//           validator: (value) => ValidationUtils.validateField(value, 'Domain'),
//         ),
//         const SizedBox(height: AppConstants.spacing * 2),
//         _buildDropdownField(
//           label: 'Difficulty',
//           value: currentDifficulty,
//           items: AppConstants.difficultyLevels,
//           onChanged: onDifficultyChanged,
//           icon: Icons.signal_cellular_alt,
//         ),
//         const SizedBox(height: AppConstants.spacing * 2),
//         _buildDropdownField(
//           label: 'Education Level',
//           value: currentEducationLevel,
//           items: AppConstants.educationLevels,
//           onChanged: onEducationLevelChanged,
//           icon: Icons.school,
//         ),
//         const SizedBox(height: AppConstants.spacing * 2),
//         _buildDropdownField(
//           label: 'Course Language', // Changed label
//           value: currentLanguage, // Changed value
//           items: AppConstants.supportedLanguages, // Changed items
//           onChanged: onLanguageChanged, // Changed onChanged
//           icon: Icons.language, // Changed icon
//         ),
//         const SizedBox(height: AppConstants.spacing * 2),
//         CustomTextField(
//           labelText: 'YouTube URL (Optional, for video lessons)',
//           icon: Icons.video_library,
//           onChanged: onYoutubeUrlChanged,
//           keyboardType: TextInputType.url,
//         ),
//       ],
//     );
//   }

//   Widget _buildDropdownField({
//     required String label,
//     required String value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//     required IconData icon,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
//       decoration: BoxDecoration(
//         color: AppColors.cardColor.withOpacity(0.7),
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         border: Border.all(color: AppColors.borderColor, width: 1),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           isExpanded: true,
//           dropdownColor: AppColors.cardColor,
//           icon: Icon(Icons.arrow_drop_down, color: AppColors.textColorSecondary),
//           style: const TextStyle(color: AppColors.textColor, fontSize: 16),
//           onChanged: onChanged,
//           items: items.map<DropdownMenuItem<String>>((String itemValue) {
//             return DropdownMenuItem<String>(
//               value: itemValue,
//               child: Row(
//                 children: [
//                   Icon(icon, color: AppColors.textColorSecondary, size: 20),
//                   SizedBox(width: AppConstants.spacing),
//                   Text(itemValue),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/course/course_card.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/course.dart';

// class CourseCard extends StatelessWidget {
//   final Course course;
//   final VoidCallback onTap;
//   final VoidCallback onDelete;

//   const CourseCard({
//     super.key,
//     required this.course,
//     required this.onTap,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//         color: AppColors.cardColor.withOpacity(0.9),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         ),
//         elevation: 5,
//         child: Padding(
//           padding: const EdgeInsets.all(AppConstants.padding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Align(
//                 alignment: Alignment.topRight,
//                 child: IconButton(
//                   icon: const Icon(Icons.delete, color: AppColors.errorColor),
//                   onPressed: onDelete,
//                   tooltip: 'Delete Course',
//                 ),
//               ),
//               Text(
//                 course.title,
//                 style: AppColors.neonTextStyle(fontSize: 22, color: AppColors.accentColor),
//               ),
//               const SizedBox(height: AppConstants.spacing),
//               Text(
//                 course.description,
//                 style: const TextStyle(
//                   color: AppColors.textColorSecondary,
//                   fontSize: 14,
//                 ),
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: AppConstants.spacing * 2),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildInfoChip(
//                     icon: Icons.language, // Changed icon
//                     label: course.language, // Display language
//                     color: AppColors.primaryColor,
//                   ),
//                   _buildInfoChip(
//                     icon: Icons.trending_up,
//                     label: course.difficulty,
//                     color: AppColors.levelColor,
//                   ),
//                   _buildInfoChip(
//                     icon: Icons.layers,
//                     label: '${course.levelIds.length} Levels',
//                     color: AppColors.xpColor,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip({required IconData icon, required String label, required Color color}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing, vertical: AppConstants.spacing / 2),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         border: Border.all(color: color, width: 1),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: color, size: 16),
//           const SizedBox(width: AppConstants.spacing / 2),
//           Text(
//             label,
//             style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/widgets/community/post_card.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/community_post.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/widgets/common/custom_text_field.dart';

// class PostCard extends StatefulWidget {
//   final CommunityPost post;
//   final String? currentUserId;

//   const PostCard({
//     super.key,
//     required this.post,
//     this.currentUserId,
//   });

//   @override
//   State<PostCard> createState() => _PostCardState();
// }

// class _PostCardState extends State<PostCard> {
//   final TextEditingController _commentController = TextEditingController();
//   bool _showComments = false;
//   bool _isLoadingComment = false;

//   Future<void> _toggleLike() async {
//     if (widget.currentUserId == null) return;
//     try {
//       await Provider.of<FirebaseService>(context, listen: false)
//           .toggleLikeOnPost(widget.post.id, widget.currentUserId!);
//     } catch (e) {
//       debugPrint('Error toggling like: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to like/unlike post: ${e.toString()}')),
//         );
//       }
//     }
//   }

//   Future<void> _addComment() async {
//     if (_commentController.text.trim().isEmpty || widget.currentUserId == null) return;

//     setState(() {
//       _isLoadingComment = true;
//     });

//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       final currentUserProfile = await firebaseService.getUserProfile(widget.currentUserId!);

//       if (currentUserProfile == null) {
//         throw Exception('User profile not found.');
//       }

//       final newComment = Comment(
//         id: firebaseService.generateNewDocId(),
//         userId: currentUserProfile.uid,
//         username: currentUserProfile.username,
//         avatarUrl: currentUserProfile.avatarAssetPath,
//         text: _commentController.text.trim(),
//         timestamp: DateTime.now(),
//       );
//       await firebaseService.addCommentToPost(widget.post.id, newComment);
//       _commentController.clear();
//     } catch (e) {
//       debugPrint('Error adding comment: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to add comment: ${e.toString()}')),
//         );
//       }
//     } finally {
//       setState(() {
//         _isLoadingComment = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _commentController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isLiked = widget.post.likedBy.contains(widget.currentUserId);

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//       color: AppColors.cardColor.withOpacity(0.9),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//       ),
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundImage: AssetImage(widget.post.authorAvatarUrl),
//                   backgroundColor: AppColors.borderColor,
//                 ),
//                 const SizedBox(width: AppConstants.spacing),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.post.authorUsername,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.textColor,
//                           fontSize: 16,
//                         ),
//                       ),
//                       Text(
//                         '${widget.post.timestamp.day}/${widget.post.timestamp.month}/${widget.post.timestamp.year} at ${widget.post.timestamp.hour}:${widget.post.timestamp.minute.toString().padLeft(2, '0')}',
//                         style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: AppConstants.spacing),
//             Text(
//               widget.post.content,
//               style: const TextStyle(color: AppColors.textColor, fontSize: 15),
//             ),
//             if (widget.post.imageUrl != null && widget.post.imageUrl!.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                   child: Image.network(
//                     widget.post.imageUrl!,
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: 200,
//                     errorBuilder: (context, error, stackTrace) => Container(
//                       color: AppColors.borderColor,
//                       height: 200,
//                       child: const Center(
//                         child: Icon(Icons.broken_image, color: AppColors.textColorSecondary),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             const Divider(color: AppColors.borderColor),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 GestureDetector(
//                   onTap: widget.currentUserId != null ? _toggleLike : null,
//                   child: Row(
//                     children: [
//                       Icon(
//                         isLiked ? Icons.favorite : Icons.favorite_border,
//                         color: isLiked ? AppColors.errorColor : AppColors.textColorSecondary,
//                         size: 20,
//                       ),
//                       const SizedBox(width: AppConstants.spacing / 2),
//                       Text(
//                         '${widget.post.likedBy.length}',
//                         style: TextStyle(color: isLiked ? AppColors.errorColor : AppColors.textColorSecondary),
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
//                       Icon(Icons.comment_outlined, color: AppColors.textColorSecondary, size: 20),
//                       const SizedBox(width: AppConstants.spacing / 2),
//                       Text(
//                         '${widget.post.comments.length}',
//                         style: const TextStyle(color: AppColors.textColorSecondary),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             if (_showComments)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Divider(color: AppColors.borderColor),
//                   ...widget.post.comments.map((comment) => Padding(
//                         padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CircleAvatar(
//                               radius: 12,
//                               backgroundImage: AssetImage(comment.avatarUrl),
//                               backgroundColor: AppColors.borderColor,
//                             ),
//                             const SizedBox(width: AppConstants.spacing),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     comment.username,
//                                     style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor, fontSize: 13),
//                                   ),
//                                   Text(
//                                     comment.text,
//                                     style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 14),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                   const SizedBox(height: AppConstants.spacing),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomTextField(
//                           controller: _commentController,
//                           labelText: 'Add a comment...',
//                           keyboardType: TextInputType.text,
//                           maxLines: 1,
//                         ),
//                       ),
//                       const SizedBox(width: AppConstants.spacing),
//                       _isLoadingComment
//                           ? const SizedBox(
//                               width: 24,
//                               height: 24,
//                               child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accentColor),
//                             )
//                           : IconButton(
//                               icon: const Icon(Icons.send, color: AppColors.accentColor),
//                               onPressed: _addComment,
//                             ),
//                     ],
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // lib/widgets/common/xp_level_display.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/widgets/common/progress_bar.dart';

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
//     final int xpForCurrentLevel = (level - 1) * AppConstants.xpPerLevel;
//     final int xpProgressInCurrentLevel = xp - xpForCurrentLevel;
//     final int xpNeededForNextLevel = AppConstants.xpPerLevel;

//     double progress = xpNeededForNextLevel > 0
//         ? xpProgressInCurrentLevel / xpNeededForNextLevel
//         : 0.0;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Level $level',
//               style: const TextStyle(
//                 color: AppColors.levelColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               '$xp XP',
//               style: const TextStyle(
//                 color: AppColors.xpColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: AppConstants.spacing),
//         ProgressBar(
//           current: xpProgressInCurrentLevel,
//           total: xpNeededForNextLevel,
//           backgroundColor: AppColors.progressTrackColor,
//           progressColor: AppColors.xpColor,
//         ),
//         const SizedBox(height: AppConstants.spacing / 2),
//         Text(
//           '${xpProgressInCurrentLevel} / $xpNeededForNextLevel XP to next level',
//           style: const TextStyle(
//             color: AppColors.textColorSecondary,
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }
// }
// // lib/widgets/common/progress_bar.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class ProgressBar extends StatelessWidget {
//   final int current;
//   final int total;
//   final Color backgroundColor;
//   final Color progressColor;

//   const ProgressBar({
//     super.key,
//     required this.current,
//     required this.total,
//     this.backgroundColor = AppColors.progressTrackColor,
//     this.progressColor = AppColors.accentColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double progress = total > 0 ? current / total : 0.0;
//     if (progress > 1.0) progress = 1.0; // Cap progress at 100%

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//       child: LinearProgressIndicator(
//         value: progress,
//         backgroundColor: backgroundColor,
//         valueColor: AlwaysStoppedAnimation<Color>(progressColor),
//         minHeight: 10,
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//       ),
//     );
//   }
// }
// // lib/widgets/common/custom_text_field.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController? controller;
//   final String labelText;
//   final IconData? icon;
//   final bool obscureText;
//   final String? Function(String?)? validator;
//   final TextInputType? keyboardType;
//   final int maxLines;
//   final void Function(String)? onSubmitted;
//   final ValueChanged<String>? onChanged;
//   final bool readOnly; // Added readOnly parameter

//   const CustomTextField({
//     super.key,
//     this.controller,
//     required this.labelText,
//     this.icon,
//     this.obscureText = false,
//     this.validator,
//     this.keyboardType,
//     this.maxLines = 1,
//     this.onSubmitted,
//     this.onChanged,
//     this.readOnly = false, // Default to false
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       validator: validator,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       onFieldSubmitted: onSubmitted,
//       onChanged: onChanged,
//       readOnly: readOnly, // Pass readOnly to TextFormField
//       style: const TextStyle(color: AppColors.textColor, fontSize: 16),
//       decoration: InputDecoration(
//         labelText: labelText,
//         prefixIcon: icon != null ? Icon(icon, color: AppColors.textColorSecondary) : null,
//         labelStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.8)),
//         hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.5)),
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
//         errorStyle: const TextStyle(color: AppColors.errorColor, fontSize: 12),
//       ),
//       cursorColor: AppColors.accentColor,
//     );
//   }
// }
// // lib/widgets/common/custom_button.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class CustomButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final String text;
//   final IconData? icon;
//   final bool isLoading;

//   const CustomButton({
//     super.key,
//     required this.onPressed,
//     required this.text,
//     this.icon,
//     this.isLoading = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: onPressed == null || isLoading
//               ? [AppColors.primaryColorDark.withOpacity(0.5), AppColors.secondaryColor.withOpacity(0.5)]
//               : [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         boxShadow: onPressed == null || isLoading
//             ? []
//             : [
//                 BoxShadow(
//                   color: AppColors.primaryColor.withOpacity(0.6),
//                   blurRadius: 10,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//       ),
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent, // Make button transparent to show gradient
//           shadowColor: Colors.transparent, // Remove shadow from ElevatedButton
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//           minimumSize: const Size(double.infinity, 0), // Make button full width
//         ),
//         child: isLoading
//             ? const SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(AppColors.textColor),
//                   strokeWidth: 2,
//                 ),
//               )
//             : Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (icon != null) ...[
//                     Icon(icon, color: AppColors.textColor),
//                     const SizedBox(width: AppConstants.spacing),
//                   ],
//                   Text(
//                     text,
//                     style: const TextStyle(
//                       color: AppColors.textColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
// // lib/widgets/common/animated_background.dart
// import 'package:flutter/material.dart';
// import 'dart:math';

// class AnimatedBackground extends StatefulWidget {
//   final Widget child;

//   const AnimatedBackground({super.key, required this.child});

//   @override
//   State<AnimatedBackground> createState() => _AnimatedBackgroundState();
// }

// class _AnimatedBackgroundState extends State<AnimatedBackground> with TickerProviderStateMixin {
//   late List<Star> _stars; // Changed from bubbles to stars for galaxy effect
//   late List<AnimationController> _controllers;
//   late List<Animation<Offset>> _animations;
//   final Random _random = Random();

//   @override
//   void initState() {
//     super.initState();
//     // Generate 50 stars for a denser galaxy effect
//     _stars = List.generate(50, (index) => Star(_random));
//     _controllers = [];
//     _animations = [];

//     for (int i = 0; i < _stars.length; i++) {
//       final controller = AnimationController(
//         duration: Duration(seconds: _random.nextInt(15) + 20), // 20-35 seconds for slower, grander movement
//         vsync: this,
//       )..repeat(reverse: true);
//       _controllers.add(controller);

//       // Random start and end offsets for star movement
//       final startOffset = Offset(_random.nextDouble() * 2 - 1, _random.nextDouble() * 2 - 1);
//       final endOffset = Offset(_random.nextDouble() * 2 - 1, _random.nextDouble() * 2 - 1);

//       _animations.add(
//         Tween<Offset>(begin: startOffset, end: endOffset).animate(
//           CurvedAnimation(
//             parent: controller,
//             curve: Curves.easeInOutSine, // Smooth, wave-like movement
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Dark space/galaxy background color
//         Container(
//           color: Colors.black, // Solid black for deep space
//         ),
//         // Animated stars
//         ...List.generate(_stars.length, (index) {
//           return AnimatedBuilder(
//             animation: _animations[index],
//             builder: (context, child) {
//               // Calculate position relative to screen size
//               final double screenWidth = MediaQuery.of(context).size.width;
//               final double screenHeight = MediaQuery.of(context).size.height;

//               // Adjust position calculation for a wider spread and movement
//               final double offsetX = screenWidth * (_stars[index].initialPosition.dx + _animations[index].value.dx * 0.5); // Multiplier for movement
//               final double offsetY = screenHeight * (_stars[index].initialPosition.dy + _animations[index].value.dy * 0.5); // Multiplier for movement

//               return Positioned(
//                 left: offsetX,
//                 top: offsetY,
//                 child: Opacity(
//                   opacity: _stars[index].opacity,
//                   child: Container(
//                     width: _stars[index].size,
//                     height: _stars[index].size,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: _stars[index].color.withOpacity(0.8), // More solid star color
//                       boxShadow: [
//                         BoxShadow(
//                           color: _stars[index].color.withOpacity(0.4),
//                           blurRadius: _stars[index].size / 3, // Smaller blur for sharper stars
//                           spreadRadius: _stars[index].size / 6,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }),
//         // Main app content
//         widget.child,
//       ],
//     );
//   }
// }

// // Renamed from Bubble to Star for clarity
// class Star {
//   final Random random;
//   final double size;
//   final Color color;
//   final double opacity;
//   final Offset initialPosition;

//   Star(this.random)
//       : size = random.nextDouble() * 3 + 1, // Stars from 1 to 4 pixels
//         color = Colors.white.withOpacity(random.nextDouble() * 0.5 + 0.5), // Varied white/light colors
//         opacity = random.nextDouble() * 0.7 + 0.3, // Varied opacity for twinkling effect
//         initialPosition = Offset(random.nextDouble(), random.nextDouble()); // Initial position within [0,1] range
// }

// // lib/utils/validation_utils.dart
// import 'package:flutter/material.dart';

// class ValidationUtils {
//   static String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email cannot be empty.';
//     }
//     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//       return 'Please enter a valid email address.';
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

//   static String? validateRequired(String? value, String fieldName) {
//     if (value == null || value.isEmpty) {
//       return '$fieldName cannot be empty.';
//     }
//     return null;
//   }
//   static String? validateField(String? value, String fieldName) {
//     if (value == null || value.isEmpty) {
//       return '$fieldName cannot be empty.';
//     }
//     return null;
//   }
//   // Adjusted to accept dynamic for correctAnswerData, and convert to String safely
//   static bool validateAnswer(String userAnswer, String questionType, dynamic correctAnswerData) {
//     final String correctAnswerString = correctAnswerData?.toString() ?? ''; // Safely convert to string, default to empty

//     switch (questionType) {
//       case 'MCQ':
//       case 'FillInBlank':
//         return userAnswer.trim().toLowerCase() == correctAnswerString.trim().toLowerCase();
//       case 'ShortAnswer':
//         List<String> keywords = correctAnswerString.toLowerCase().split(',').map((e) => e.trim()).toList();
//         String userLower = userAnswer.toLowerCase();
//         return keywords.any((keyword) => userLower.contains(keyword));
//       case 'Scenario':
//         // For scenario, we expect a short answer that matches keywords in expectedOutcome
//         List<String> keywords = correctAnswerString.toLowerCase().split(',').map((e) => e.trim()).toList();
//         String userLower = userAnswer.toLowerCase();
//         return keywords.any((keyword) => userLower.contains(keyword));
//       default:
//         // For unsupported question types, consider it incorrect or log an error
//         debugPrint('Unsupported question type for validation: $questionType');
//         return false;
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
//       debugPrint('Could not launch $url');
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
//         allowedExtensions: ['txt', 'pdf', 'docx'],
//       );

//       if (result != null && result.files.single.bytes != null) {
//         String? fileContent;
//         if (result.files.single.extension == 'txt') {
//           fileContent = String.fromCharCodes(result.files.single.bytes!);
//         } else {
//           debugPrint('Unsupported file type for direct content reading: ${result.files.single.extension}');
//           return null;
//         }
//         return fileContent;
//       } else {
//         debugPrint('File picking cancelled or no file selected.');
//         return null;
//       }
//     } catch (e) {
//       debugPrint('Error picking file: $e');
//       return null;
//     }
//   }
// }
// // lib/utils/app_router.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/screens/auth_screen.dart';
// import 'package:gamifier/screens/splash_screen.dart';
// import 'package:gamifier/screens/onboarding_screen.dart';
// import 'package:gamifier/screens/home_screen.dart';
// import 'package:gamifier/screens/profile_screen.dart';
// import 'package:gamifier/screens/avatar_customizer_screen.dart';
// import 'package:gamifier/screens/course_creation_screen.dart';
// import 'package:gamifier/screens/level_selection_screen.dart';
// import 'package:gamifier/screens/lesson_screen.dart';
// import 'package:gamifier/screens/level_completion_screen.dart';
// import 'package:gamifier/screens/chat_screen.dart';
// import 'package:gamifier/screens/community_screen.dart';
// import 'package:gamifier/screens/progress_screen.dart';

// class AppRouter {
//   static const String splashRoute = '/';
//   static const String authRoute = '/auth';
//   static const String onboardingRoute = '/onboarding';
//   static const String homeRoute = '/home';
//   static const String profileRoute = '/profile';
//   static const String avatarCustomizerRoute = '/avatar_customizer';
//   static const String courseCreationRoute = '/course_creation';
//   static const String levelSelectionRoute = '/level_selection';
//   static const String lessonRoute = '/lesson';
//   static const String levelCompletionRoute = '/level_completion';
//   static const String chatRoute = '/chat';
//   static const String communityRoute = '/community';
//   static const String progressRoute = '/progress';

//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case splashRoute:
//         return MaterialPageRoute(builder: (_) => const SplashScreen());
//       case authRoute:
//         return MaterialPageRoute(builder: (_) => const AuthScreen());
//       case onboardingRoute:
//         return MaterialPageRoute(builder: (_) => const OnboardingScreen());
//       case homeRoute:
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//       case profileRoute:
//         return MaterialPageRoute(builder: (_) => const ProfileScreen());
//       case avatarCustomizerRoute:
//         return MaterialPageRoute(builder: (_) => const AvatarCustomizerScreen());
//       case courseCreationRoute:
//         return MaterialPageRoute(builder: (_) => const CourseCreationScreen());
//       case levelSelectionRoute:
//         final args = settings.arguments as Map<String, String>;
//         return MaterialPageRoute(builder: (_) => LevelSelectionScreen(courseId: args['courseId']!, courseTitle: args['courseTitle']!));
//       case lessonRoute:
//         final args = settings.arguments as Map<String, dynamic>;
//         return MaterialPageRoute(builder: (_) => LessonScreen(
//           courseId: args['courseId']!,
//           levelId: args['levelId']!,
//           lessonId: args['lessonId']!,
//           levelOrder: args['levelOrder']!,
//         ));
//       case levelCompletionRoute:
//         final args = settings.arguments as Map<String, dynamic>;
//         return MaterialPageRoute(builder: (_) => LevelCompletionScreen(
//           courseId: args['courseId']!,
//           levelId: args['levelId']!,
//           xpEarned: args['xpEarned']!,
//           isCourseCompleted: args['isCourseCompleted'] ?? false,
//         ));
//       case chatRoute:
//         return MaterialPageRoute(builder: (_) => const ChatScreen());
//       case communityRoute:
//         return MaterialPageRoute(builder: (_) => const CommunityScreen());
//       case progressRoute:
//         return MaterialPageRoute(builder: (_) => const ProgressScreen());
//       default:
//         // Fallback for unknown routes
//         return MaterialPageRoute(builder: (_) => Scaffold(
//           appBar: AppBar(title: const Text('Error')),
//           body: Center(child: Text('Error: Unknown route ${settings.name}')),
//         ));
//     }
//   }
// }
// // lib/services/gemini_api_service.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/models/level.dart';
// import 'package:gamifier/models/lesson.dart';
// import 'package:gamifier/models/question.dart';
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

//   String _extractJsonString(String text) {
//     String cleanedText = text.trim();

//     final jsonCodeBlockRegex = RegExp(r'```json\s*(\{[\s\S]*?\})\s*```', dotAll: true);
//     final jsonCodeBlockMatch = jsonCodeBlockRegex.firstMatch(cleanedText);
//     if (jsonCodeBlockMatch != null && jsonCodeBlockMatch.group(1) != null) {
//       return jsonCodeBlockMatch.group(1)!;
//     }

//     final standaloneJsonRegex = RegExp(r'\{[\s\S]*\}', dotAll: true);
//     final allMatches = standaloneJsonRegex.allMatches(cleanedText);

//     String? bestValidJson;
//     for (final match in allMatches) {
//       String potentialJson = match.group(0)!;
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

//     int openBraces = 0;
//     int openBrackets = 0;
//     bool inString = false;
//     StringBuffer repairedJsonBuffer = StringBuffer();

//     for (int i = 0; i < cleanedText.length; i++) {
//       String char = cleanedText[i];
//       if (char == '\\' && i + 1 < cleanedText.length) {
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
//     required String language, // Added language parameter
//     String? sourceContent,
//     String? youtubeUrl,
//     int numberOfLevels = AppConstants.initialLevelsCount,
//     int startingLevelOrder = 1,
//     List<Level>? previousLevelsContext,
//   }) async {
//     String prompt = '''
//     As an AI-powered gamification engine, your task is to transform a static course topic into an interactive, game-based learning module.
//     Generate a complete course structure including:
//     - courseTitle: A catchy title for the course.
//     - language: The language of the course (e.g., "English", "Spanish"). Choose one from: ${AppConstants.supportedLanguages.join(', ')}.
//     - gameGenre: A suitable game genre for the course (e.g., "Fantasy", "Sci-Fi", "Adventure", "Mystery", "Cyberpunk"). Choose one from: ${AppConstants.gameThemes.join(', ')}.
//     - difficulty: The difficulty level of the course ("Beginner", "Intermediate", "Advanced", "Expert").
//     - levels: An array of $numberOfLevels distinct levels, ordered from easy to hard, each tailored to the course's difficulty. Each level should have:
//         - id: A unique string ID for the level (e.g., "level_${startingLevelOrder}").
//         - title: The title of the level.
//         - description: A brief, engaging description of the level.
//         - difficulty: The specific difficulty of this level (e.g., "Easy", "Medium").
//         - order: An integer representing the sequential order of the level (e.g., $startingLevelOrder, ${startingLevelOrder + 1}, ...). This field is mandatory.
//         - imageAssetPath: An optional path to a local asset image for this level's icon/visual (e.g., "assets/level_icons/level${startingLevelOrder}.png", "assets/level_icons/level${startingLevelOrder + 1}.png"). Create unique, descriptive paths for each.
//         - lessons: An array of 1-3 detailed lessons. Each lesson should have:
//             - id: A unique string ID for the lesson (e.g., "lesson_${startingLevelOrder}_1").
//             - title: The title of the lesson.
//             - content: Comprehensive learning material for the lesson (min 200 words), suitable for a college student, formatted in Markdown.
//             - order: An integer representing the sequential order of the lesson. This field is mandatory.
//             - questions: An array of 3-5 small, interesting, and engaging questions for the lesson, appropriate for the level's difficulty. Each question should have:
//                 - id: A unique string ID for the question (e.g., "q1_lesson_${startingLevelOrder}_1").
//                 - questionText: The question itself.
//                 - xpReward: An integer for XP reward (e.g., 10, 15, 20). This field is mandatory.
//                 - type: One of "MCQ", "FillInBlank", "ShortAnswer", "Scenario". Favor a mix of types for variety.
//                 - specific fields based on type (if applicable):
//                     - For MCQ: options (List<String>), correctAnswer (String, one of options). Ensure options are distinct and plausible.
//                     - For FillInBlank: correctAnswer (String).
//                     - For ShortAnswer: expectedAnswerKeywords (String, comma-separated keywords for evaluation).
//                     - For Scenario: scenarioText (String, concise and engaging), expectedOutcome (String).

//     The course is for "$topicName" for college students in the "$domain" domain, with an overall "$difficulty" difficulty level.
//     The user's education level is "$educationLevel" and their specialty is "$specialty".
//     The course content, lessons, and questions MUST be generated in the "$language" language.
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
//             "language": {"type": "STRING"}, // Added language to schema
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
//                   "order": {"type": "INTEGER"}, // Marked as INTEGER
//                   "imageAssetPath": {"type": "STRING"},
//                   "lessons": {
//                     "type": "ARRAY",
//                     "items": {
//                       "type": "OBJECT",
//                       "properties": {
//                         "id": {"type": "STRING"},
//                         "title": {"type": "STRING"},
//                         "content": {"type": "STRING"},
//                         "order": {"type": "INTEGER"}, // Marked as INTEGER
//                         "questions": {
//                           "type": "ARRAY",
//                           "items": {
//                             "type": "OBJECT",
//                             "properties": {
//                               "id": {"type": "STRING"},
//                               "questionText": {"type": "STRING"},
//                               "xpReward": {"type": "INTEGER"}, // Marked as INTEGER
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
//                       "required": ["id", "title", "content", "order", "questions"]
//                     }
//                   }
//                 },
//                 "required": ["id", "title", "description", "difficulty", "order", "lessons"]
//               }
//             }
//           },
//           "required": ["courseTitle", "language", "gameGenre", "difficulty", "levels"] // Made language required
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

//   Future<Map<String, dynamic>> generateSubsequentLevels({
//     required String courseId,
//     required String topicName,
//     required String ageGroup,
//     required String domain,
//     required String difficulty,
//     required String language, // Added language parameter
//     required int startingLevelOrder,
//     required int numberOfLevels,
//     String? educationLevel,
//     String? specialty,
//     String? sourceContent,
//     String? youtubeUrl,
//     List<Level>? previousLevelsContext,
//   }) async {
//     final Map<String, dynamic> generatedContent = await generateCourseContent(
//       topicName: topicName,
//       ageGroup: ageGroup,
//       domain: domain,
//       difficulty: difficulty,
//       educationLevel: educationLevel,
//       specialty: specialty,
//       language: language, // Pass language to generateCourseContent
//       sourceContent: sourceContent,
//       youtubeUrl: youtubeUrl,
//       numberOfLevels: numberOfLevels,
//       startingLevelOrder: startingLevelOrder,
//       previousLevelsContext: previousLevelsContext,
//     );

//     final List<Level> levels = [];
//     final Map<String, List<Lesson>> lessonsPerLevel = {};
//     final Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel = {};

//     if (generatedContent['levels'] is List) {
//       for (var levelData in generatedContent['levels']) {
//         if (levelData is Map<String, dynamic>) {
//           final Level newLevel = Level.fromMap(levelData)..courseId = courseId;
//           levels.add(newLevel);

//           final List<Lesson> lessons = [];
//           final Map<String, List<Question>> questionsForThisLevelLessons = {};

//           if (levelData['lessons'] is List) {
//             for (var lessonData in levelData['lessons']) {
//               if (lessonData is Map<String, dynamic>) {
//                 final Lesson newLesson = Lesson.fromMap(lessonData)..levelId = newLevel.id;
//                 lessons.add(newLesson);

//                 final List<Question> questions = [];
//                 if (newLesson.questions is List) { // Ensure newLesson.questions is a list before iterating
//                   for (var questionData in newLesson.questions) {
//                     if (questionData is Map<String, dynamic>) { // Ensure questionData is a Map
//                       questions.add(Question.fromMap(questionData as Map<String, dynamic>));
//                     } else {
//                       debugPrint('Warning: Skipping malformed question data: $questionData');
//                     }
//                   }
//                 }
//                 questionsForThisLevelLessons[newLesson.id] = questions;
//               } else {
//                 debugPrint('Warning: Skipping malformed lesson data: $lessonData');
//               }
//             }
//           }
//           lessonsPerLevel[newLevel.id] = lessons;
//           questionsPerLessonPerLevel[newLevel.id] = questionsForThisLevelLessons;
//         } else {
//           debugPrint('Warning: Skipping malformed level data: $levelData');
//         }
//       }
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
//     You are an AI tutor designed to provide personalized,write the only 4-5 lines Socratic feedback to college students.
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
// import 'package:gamifier/models/chat_message.dart';
// import 'package:gamifier/models/lesson.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/constants/app_constants.dart';

// class FirebaseService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
//       // Ensure user profile and streak are handled after sign-in
//       await _ensureUserProfileAndStreak(userCredential.user!);
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

//   Future<UserCredential> registerWithEmailAndPassword(
//       String email,
//       String password,
//       String username, {
//       String? educationLevel, // Added
//       String? specialty, // Added
//       String? language, // New: Language
//   }) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       if (userCredential.user != null) {
//         await createUserProfile(
//           userCredential.user!.uid,
//           username,
//           email: email, // Also save email
//           educationLevel: educationLevel, // Pass along
//           specialty: specialty, // Pass along
//           language: language, // Pass along new field
//         );
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
//       // If profile doesn't exist (e.g., old user or direct sign-in via custom token), create a basic one.
//       // Onboarding screen will then prompt for more details.
//       await createUserProfile(
//         user.uid,
//         user.displayName ?? 'New Learner',
//         email: user.email,
//         educationLevel: null, // Let onboarding set these if needed
//         specialty: null,      // Let onboarding set these if needed
//         language: null,       // Let onboarding set this if needed
//       );
//     } else {
//       UserProfile userProfile = UserProfile.fromMap(docSnapshot.data()!);
//       DateTime today = DateTime.now();
//       DateTime? lastLogin = userProfile.lastLoginDate;

//       DateTime todayNormalized = DateTime(today.year, today.month, today.day);
//       DateTime? lastLoginNormalized = lastLogin != null ? DateTime(lastLogin.year, lastLogin.month, lastLogin.day) : null;

//       int newStreak = userProfile.currentStreak;
//       int xpToAdd = 0;

//       // Logic for streak update
//       if (lastLoginNormalized == null || todayNormalized.difference(lastLoginNormalized).inDays > 1) {
//         // Streak broken or first login, reset to 1
//         newStreak = 1;
//         xpToAdd = 0; // No bonus on reset
//       } else if (todayNormalized.difference(lastLoginNormalized).inDays == 1) {
//         // Streak continued
//         newStreak++;
//         if (newStreak >= AppConstants.minStreakDaysForBonus) {
//           xpToAdd = AppConstants.streakBonusXp;
//         }
//       } else {
//         // Same day login, no change to streak or XP from streak bonus
//         xpToAdd = 0;
//       }

//       Map<String, dynamic> updates = {
//         'lastLoginDate': Timestamp.fromDate(today),
//         'currentStreak': newStreak,
//       };

//       // Apply XP if earned from streak
//       if (xpToAdd > 0) {
//         updates['xp'] = FieldValue.increment(xpToAdd);
//       }
//       await userRef.update(updates);

//       // Re-fetch profile to get updated XP for level calculation
//       UserProfile updatedProfile = UserProfile.fromMap((await userRef.get()).data()!);
//       int newXpTotal = updatedProfile.xp;
//       int newLevel = updatedProfile.level;

//       int xpAtCurrentLevelStart = (newLevel - 1) * AppConstants.xpPerLevel;

//       while (newXpTotal >= xpAtCurrentLevelStart + AppConstants.xpPerLevel) {
//         newLevel++;
//         xpAtCurrentLevelStart = (newLevel - 1) * AppConstants.xpPerLevel;
//       }

//       if (newLevel > userProfile.level) {
//         // Optionally play level up sound or show notification
//         debugPrint('User ${user.uid} leveled up to $newLevel!');
//       }
//       // Only update level if it has actually changed to avoid unnecessary writes
//       if (newLevel != userProfile.level) {
//         await userRef.update({'level': newLevel});
//       }
//     }
//   }

//   Future<void> createUserProfile(String uid, String username, {String? email, String? educationLevel, String? specialty, String? language}) async {
//     final userProfile = UserProfile(
//       uid: uid,
//       username: username,
//       email: email ?? '', // Use provided email or default
//       createdAt: DateTime.now(),
//       lastLoginDate: DateTime.now(),
//       educationLevel: educationLevel, // Set from registration if provided
//       specialty: specialty, // Set from registration if provided
//       language: language, // Set from registration if provided
//       currentStreak: 1, // Start new users with a 1-day streak
//       xp: AppConstants.initialXp,
//       level: 1,
//       avatarAssetPath: AppConstants.defaultAvatarAssets.first.assetPath,
//       earnedBadges: const [],
//       friends: const [],
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
//     // Ordering by XP descending to get top users.
//     // If you need to paginate or filter, that would be added here.
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

//         if (friendUserFriends.contains(currentUserId)) {
//           friendUserFriends.remove(currentUserId);
//           transaction.update(friendUserRef, {'friends': friendUserFriends});
//         }
//       });
//     } catch (e) {
//       throw Exception('Error removing friend: $e');
//     }
//   }

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
//       await _correctPlayer.stop();
//       await _correctPlayer.resume();
//       await _correctPlayer.play(AssetSource(AppConstants.correctSoundPath));
//     } catch (e) {
//       debugPrint('Error playing correct sound: $e');
//     }
//   }

//   Future<void> playLevelUpSound() async {
//     try {
//       await _levelUpPlayer.stop();
//       await _levelUpPlayer.resume();
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
// // lib/screens/splash_screen.dart
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/utils/app_router.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   late FirebaseService _firebaseService;

//   @override
//   void initState() {
//     super.initState();
//     _firebaseService = Provider.of<FirebaseService>(context, listen: false);

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

//     _controller.forward().whenComplete(() {
//       _checkAuthStatus();
//     });
//   }

//   Future<void> _checkAuthStatus() async {
//     // Listen to auth state changes to react when Firebase is ready and user status is known
//     _firebaseService.authStateChanges.listen((User? user) async {
//       // Ensure the widget is still mounted before performing navigation
//       if (mounted) {
//         if (user == null) {
//           // No user logged in, navigate to AuthScreen
//           Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
//         } else {
//           // User is logged in, check profile completeness
//           final userProfile = await _firebaseService.getUserProfile(user.uid);
//           if (userProfile == null || userProfile.username.isEmpty) {
//             // User profile not complete or not found, navigate to Onboarding
//             Navigator.of(context).pushReplacementNamed(AppRouter.onboardingRoute);
//           } else {
//             // User profile complete, navigate to HomeScreen
//             Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//           }
//         }
//       }
//       // After the first check and navigation, we don't need to listen anymore if we pushReplacement
//       // If we allowed back navigation to splash, then we'd keep listening.
//       // For a splash screen, usually, you navigate once and dispose listeners.
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: Center(
//           child: ScaleTransition(
//             scale: _animation,
//             child: FadeTransition(
//               opacity: _animation,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/app_icon.png', // Ensure this asset exists and is correctly configured in pubspec.yaml
//                     width: 150,
//                     height: 150,
//                   ),
//                   const SizedBox(height: AppConstants.spacing * 2),
//                   Text(
//                     AppConstants.appName,
//                     style: AppColors.neonTextStyle(fontSize: 48),
//                   ),
//                   const SizedBox(height: AppConstants.spacing),
//                   Text(
//                     AppConstants.appTagline,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       color: AppColors.textColorSecondary,
//                       fontStyle: FontStyle.italic,
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
// // lib/screens/progress_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/progress_bar.dart';
// import 'package:gamifier/widgets/gamification/leaderboard_list.dart'; // Import LeaderboardList

// class ProgressScreen extends StatefulWidget {
//   const ProgressScreen({super.key});

//   @override
//   State<ProgressScreen> createState() => _ProgressScreenState();
// }

// class _ProgressScreenState extends State<ProgressScreen> with SingleTickerProviderStateMixin {
//   late FirebaseService _firebaseService;
//   String? _currentUserId;
//   bool _isLoading = true;
//   String? _errorMessage;
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     _tabController = TabController(length: 2, vsync: this);
//     _initializeUserAndLoadProgress();
//   }

//   Future<void> _initializeUserAndLoadProgress() async {
//     final user = _firebaseService.currentUser;
//     if (user != null) {
//       setState(() {
//         _currentUserId = user.uid;
//         _isLoading = false;
//       });
//     } else {
//       setState(() {
//         _errorMessage = 'User not logged in.';
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: Text('My Progress'),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: AppColors.accentColor,
//           labelColor: AppColors.accentColor,
//           unselectedLabelColor: AppColors.textColorSecondary,
//           tabs: const [
//             Tab(text: 'My Progress', icon: Icon(Icons.show_chart)),
//             Tab(text: 'Leaderboard', icon: Icon(Icons.leaderboard)),
//           ],
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: _isLoading
//               ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//               : _errorMessage != null
//                   ? Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(AppConstants.padding),
//                         child: Text(
//                           _errorMessage!,
//                           style: const TextStyle(color: AppColors.errorColor),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     )
//                   : TabBarView(
//                       controller: _tabController,
//                       children: [
//                         // My Progress Tab
//                         SingleChildScrollView(
//                           padding: const EdgeInsets.all(AppConstants.padding),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Your Course Progress',
//                                 style: AppColors.neonTextStyle(fontSize: 24, color: AppColors.accentColor),
//                               ),
//                               const SizedBox(height: AppConstants.spacing * 2),
//                               StreamBuilder<List<Course>>(
//                                 stream: _firebaseService.streamAllCourses(),
//                                 builder: (context, courseSnapshot) {
//                                   if (courseSnapshot.connectionState == ConnectionState.waiting) {
//                                     return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
//                                   }
//                                   if (courseSnapshot.hasError) {
//                                     return Center(child: Text('Error loading courses: ${courseSnapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
//                                   }
//                                   if (!courseSnapshot.hasData || courseSnapshot.data!.isEmpty) {
//                                     return const Center(
//                                       child: Text(
//                                         'No courses available to track progress. Create one to get started!',
//                                         style: TextStyle(color: AppColors.textColorSecondary),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     );
//                                   }

//                                   final courses = courseSnapshot.data!;

//                                   return ListView.builder(
//                                     shrinkWrap: true, // Important for ListView inside SingleChildScrollView
//                                     physics: const NeverScrollableScrollPhysics(), // Important to prevent nested scrolling
//                                     itemCount: courses.length,
//                                     itemBuilder: (context, index) {
//                                       final course = courses[index];
//                                       return StreamBuilder<UserProgress?>(
//                                         stream: _firebaseService.streamUserCourseProgress(_currentUserId!, course.id),
//                                         builder: (context, progressSnapshot) {
//                                           if (progressSnapshot.connectionState == ConnectionState.waiting) {
//                                             return CourseProgressCard(course: course, progressPercentage: 0, lessonsCompleted: 0, totalLessons: 0, totalXpEarned: 0, isLoading: true);
//                                           }
//                                           if (progressSnapshot.hasError) {
//                                             return CourseProgressCard(course: course, progressPercentage: 0, lessonsCompleted: 0, totalLessons: 0, totalXpEarned: 0, isError: true);
//                                           }

//                                           final userProgress = progressSnapshot.data;

//                                           int totalLevelsInCourse = course.levelIds.length;
//                                           int completedLevelsCount = 0;
//                                           int totalXpEarned = 0;

//                                           if (userProgress != null) {
//                                             completedLevelsCount = userProgress.levelsProgress.values.where((p) => p.isCompleted).length;
//                                             totalXpEarned = userProgress.levelsProgress.values.fold(0, (sum, progress) => sum + progress.xpEarned);
//                                           }

//                                           double progressPercentage = totalLevelsInCourse > 0
//                                               ? (completedLevelsCount / totalLevelsInCourse)
//                                               : 0.0;

//                                           return CourseProgressCard(
//                                             course: course,
//                                             progressPercentage: progressPercentage,
//                                             lessonsCompleted: completedLevelsCount, // Display completed levels for course
//                                             totalLessons: totalLevelsInCourse, // Display total levels for course
//                                             totalXpEarned: totalXpEarned,
//                                           );
//                                         },
//                                       );
//                                     },
//                                   );
//                                 },
//                               ),
//                               const SizedBox(height: AppConstants.spacing * 2),
//                             ],
//                           ),
//                         ),
//                         // Leaderboard Tab
//                         SingleChildScrollView(
//                           padding: const EdgeInsets.all(AppConstants.padding),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Global Leaderboard',
//                                 style: AppColors.neonTextStyle(fontSize: 24, color: AppColors.xpColor),
//                               ),
//                               const SizedBox(height: AppConstants.spacing * 2),
//                               const LeaderboardList(), // Integrate the LeaderboardList widget
//                               const SizedBox(height: AppConstants.spacing * 2),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 1),
//     );
//   }
// }

// class CourseProgressCard extends StatelessWidget {
//   final Course course;
//   final double progressPercentage;
//   final int lessonsCompleted; // Now represents completed levels
//   final int totalLessons;     // Now represents total levels
//   final int totalXpEarned;
//   final bool isLoading;
//   final bool isError;

//   const CourseProgressCard({
//     super.key,
//     required this.course,
//     required this.progressPercentage,
//     required this.lessonsCompleted,
//     required this.totalLessons,
//     required this.totalXpEarned,
//     this.isLoading = false,
//     this.isError = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//       color: AppColors.cardColor.withOpacity(0.8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//       ),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//             : isError
//                 ? const Center(child: Text('Error loading progress', style: TextStyle(color: AppColors.errorColor)))
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         course.title,
//                         style: const TextStyle(
//                           color: AppColors.textColor,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       Text(
//                         course.description,
//                         style: const TextStyle(
//                           color: AppColors.textColorSecondary,
//                           fontSize: 14,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: AppConstants.spacing * 2),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Progress: ${(progressPercentage * 100).toStringAsFixed(0)}%',
//                             style: const TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             'XP: $totalXpEarned',
//                             style: const TextStyle(color: AppColors.xpColor, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       ProgressBar(
//                         current: (progressPercentage * 100).round(),
//                         total: 100,
//                         backgroundColor: AppColors.progressTrackColor,
//                         progressColor: AppColors.accentColor,
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       Text(
//                         'Levels Completed: ${lessonsCompleted}/${totalLessons}', // Display levels
//                         style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 12),
//                       ),
//                     ],
//                   ),
//       ),
//     );
//   }
// }
// // lib/screens/profile_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/gamification/badge_display.dart';
// import 'package:gamifier/widgets/common/xp_level_display.dart';
// import 'package:gamifier/widgets/gamification/streak_display.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   UserProfile? _userProfile;
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final user = firebaseService.currentUser;

//     if (user != null) {
//       firebaseService.streamUserProfile(user.uid).listen((profile) {
//         if (mounted) {
//           setState(() {
//             _userProfile = profile;
//             _isLoading = false;
//           });
//         }
//       }).onError((error) {
//         debugPrint('Error streaming user profile: $error');
//         if (mounted) {
//           setState(() {
//             _errorMessage = 'Failed to load profile: ${error.toString()}';
//             _isLoading = false;
//           });
//         }
//       });
//     } else {
//       setState(() {
//         _errorMessage = 'User not logged in.';
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _signOut() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       await Provider.of<FirebaseService>(context, listen: false).signOut();
//       if (mounted) {
//         Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error signing out: ${e.toString()}';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(title: 'My Profile'),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: _isLoading
//               ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//               : _errorMessage != null
//                   ? Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(AppConstants.padding),
//                         child: Text(
//                           _errorMessage!,
//                           style: const TextStyle(color: AppColors.errorColor),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     )
//                   : _userProfile == null
//                       ? const Center(
//                           child: Text(
//                             'User profile not found. Please log in again.',
//                             style: TextStyle(color: AppColors.textColorSecondary),
//                           ),
//                         )
//                       : SingleChildScrollView(
//                           padding: const EdgeInsets.all(AppConstants.padding),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Center(
//                                 child: Stack(
//                                   children: [
//                                     CircleAvatar(
//                                       radius: AppConstants.avatarSize,
//                                       backgroundImage: AssetImage(_userProfile!.avatarAssetPath),
//                                       backgroundColor: AppColors.borderColor,
//                                     ),
//                                     Positioned(
//                                       bottom: 0,
//                                       right: 0,
//                                       child: IconButton(
//                                         icon: const Icon(Icons.edit, color: AppColors.accentColor),
//                                         onPressed: () {
//                                           Navigator.of(context).pushNamed(AppRouter.avatarCustomizerRoute);
//                                         },
//                                         tooltip: 'Customize Avatar',
//                                         style: IconButton.styleFrom(
//                                           backgroundColor: AppColors.primaryColor,
//                                           shape: const CircleBorder(),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: AppConstants.spacing * 2),
//                               Text(
//                                 _userProfile!.username,
//                                 style: AppColors.neonTextStyle(fontSize: 28),
//                                 textAlign: TextAlign.center,
//                               ),
//                               if (_userProfile!.email.isNotEmpty) ...[
//                                 const SizedBox(height: AppConstants.spacing),
//                                 Text(
//                                   _userProfile!.email,
//                                   style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                               const SizedBox(height: AppConstants.spacing * 3),
//                               XpLevelDisplay(xp: _userProfile!.xp, level: _userProfile!.level),
//                               const SizedBox(height: AppConstants.spacing * 2),
//                               StreakDisplay(currentStreak: _userProfile!.currentStreak),
//                               const SizedBox(height: AppConstants.spacing * 3),
//                               if (_userProfile!.educationLevel != null && _userProfile!.educationLevel!.isNotEmpty)
//                                 Card(
//                                   color: AppColors.cardColor.withOpacity(0.8),
//                                   margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(AppConstants.padding),
//                                     child: Row(
//                                       children: [
//                                         const Icon(Icons.school, color: AppColors.secondaryColor),
//                                         const SizedBox(width: AppConstants.spacing),
//                                         Text(
//                                           'Education Level: ${_userProfile!.educationLevel}',
//                                           style: const TextStyle(color: AppColors.textColor, fontSize: 16),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               if (_userProfile!.specialty != null && _userProfile!.specialty!.isNotEmpty)
//                                 Card(
//                                   color: AppColors.cardColor.withOpacity(0.8),
//                                   margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(AppConstants.padding),
//                                     child: Row(
//                                       children: [
//                                         const Icon(Icons.star, color: AppColors.xpColor),
//                                         const SizedBox(width: AppConstants.spacing),
//                                         Text(
//                                           'Specialty: ${_userProfile!.specialty}',
//                                           style: const TextStyle(color: AppColors.textColor, fontSize: 16),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               const SizedBox(height: AppConstants.spacing * 2),
//                               Text(
//                                 'Badges Earned (${_userProfile!.earnedBadges.length})',
//                                 style: AppColors.neonTextStyle(fontSize: 20, color: AppColors.secondaryColor),
//                               ),
//                               const SizedBox(height: AppConstants.spacing),
//                               _userProfile!.earnedBadges.isEmpty
//                                   ? const Text(
//                                       'No badges earned yet. Keep learning!',
//                                       style: TextStyle(color: AppColors.textColorSecondary),
//                                     )
//                                   : BadgeDisplay(badgeIds: _userProfile!.earnedBadges),
//                               const SizedBox(height: AppConstants.spacing * 4),
//                               CustomButton(
//                                 onPressed: _signOut,
//                                 text: 'Sign Out',
//                                 icon: Icons.logout,
//                                 isLoading: _isLoading,
//                               ),
//                             ],
//                           ),
//                         ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 5),
//     );
    
//   }
// }
// // lib/screens/onboarding_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/utils/validation_utils.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/custom_text_field.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   String? _educationLevel;
//   String? _specialty;
//   String? _language;
//   bool _isLoading = false;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfileAndSetDefaults();
//   }

//   // Load existing profile details to pre-fill
//   Future<void> _loadUserProfileAndSetDefaults() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       final user = firebaseService.currentUser;
//       if (user != null) {
//         final userProfile = await firebaseService.getUserProfile(user.uid);
//         if (userProfile != null) {
//           _usernameController.text = userProfile.username;

//           // Ensure selected value is in the list, otherwise default to first.
//           _educationLevel = AppConstants.educationLevels.contains(userProfile.educationLevel)
//               ? userProfile.educationLevel
//               : AppConstants.educationLevels.first;
//           _specialty = AppConstants.defaultCourseTopics.contains(userProfile.specialty)
//               ? userProfile.specialty
//               : AppConstants.defaultCourseTopics.first;
//           _language = AppConstants.supportedLanguages.contains(userProfile.language)
//               ? userProfile.language
//               : AppConstants.supportedLanguages.first;
//         } else {
//           // If no profile exists (e.g., brand new user after auth without profile creation)
//           _educationLevel = AppConstants.educationLevels.first;
//           _specialty = AppConstants.defaultCourseTopics.first;
//           _language = AppConstants.supportedLanguages.first;
//         }
//       } else {
//         // Fallback for non-logged-in state (should not happen if routed from Splash correctly)
//         _educationLevel = AppConstants.educationLevels.first;
//         _specialty = AppConstants.defaultCourseTopics.first;
//         _language = AppConstants.supportedLanguages.first;
//       }
//     } catch (e) {
//       debugPrint('Error loading user profile for onboarding: $e');
//       _educationLevel = AppConstants.educationLevels.first;
//       _specialty = AppConstants.defaultCourseTopics.first;
//       _language = AppConstants.supportedLanguages.first;
//       _errorMessage = 'Failed to load profile details. Please try again.';
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _completeOnboarding() async {
//     if (_usernameController.text.trim().isEmpty) {
//       setState(() {
//         _errorMessage = 'Please enter a username.';
//       });
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       final user = firebaseService.currentUser;

//       if (user != null) {
//         await firebaseService.updateUserProfile(
//           user.uid,
//           {
//             'username': _usernameController.text.trim(),
//             'educationLevel': _educationLevel,
//             'specialty': _specialty,
//             'language': _language,
//           },
//         );
//         if (mounted) {
//           Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//         }
//       } else {
//         setState(() {
//           _errorMessage = 'User not logged in. Please try again.';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to complete onboarding: ${e.toString()}';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Widget _buildDropdownField({
//     required String label,
//     required String value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//     required IconData icon,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
//       decoration: BoxDecoration(
//         color: AppColors.cardColor.withOpacity(0.7),
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         border: Border.all(color: AppColors.borderColor, width: 1),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           isExpanded: true,
//           dropdownColor: AppColors.cardColor,
//           icon: const Icon(Icons.arrow_drop_down, color: AppColors.textColorSecondary), // Fixed 'icons' to 'Icons'
//           style: const TextStyle(color: AppColors.textColor, fontSize: 16),
//           onChanged: onChanged,
//           items: items.map<DropdownMenuItem<String>>((String itemValue) {
//             return DropdownMenuItem<String>(
//               value: itemValue,
//               child: Row(
//                 children: [
//                   Icon(icon, color: AppColors.textColorSecondary, size: 20),
//                   SizedBox(width: AppConstants.spacing),
//                   Text(itemValue),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: Center(
//           child: _isLoading
//               ? const CircularProgressIndicator(color: AppColors.accentColor)
//               : SingleChildScrollView(
//                   padding: const EdgeInsets.all(AppConstants.padding * 2),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Welcome to ${AppConstants.appName}!',
//                         style: AppColors.neonTextStyle(fontSize: 32),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       Text(
//                         AppConstants.appTagline,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: AppColors.textColorSecondary,
//                           fontStyle: FontStyle.italic,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: AppConstants.spacing * 4),
//                       Text(
//                         'Let\'s set up your profile for a personalized learning journey.',
//                         style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: AppConstants.spacing * 4),
//                       CustomTextField(
//                         controller: _usernameController,
//                         labelText: 'Choose a Username',
//                         icon: Icons.person_outline,
//                         validator: (value) => ValidationUtils.validateField(value, 'Username'),
//                       ),
//                       const SizedBox(height: AppConstants.spacing * 2),
//                       _buildDropdownField(
//                         label: 'Your Education Level',
//                         value: _educationLevel!,
//                         items: AppConstants.educationLevels,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _educationLevel = newValue;
//                           });
//                         },
//                         icon: Icons.school,
//                       ),
//                       const SizedBox(height: AppConstants.spacing * 2),
//                       _buildDropdownField(
//                         label: 'Your Area of Specialty',
//                         value: _specialty!,
//                         items: AppConstants.defaultCourseTopics,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _specialty = newValue;
//                           });
//                         },
//                         icon: Icons.star,
//                       ),
//                       const SizedBox(height: AppConstants.spacing * 2),
//                       _buildDropdownField(
//                         label: 'Preferred Course Language', // New field for language
//                         value: _language!,
//                         items: AppConstants.supportedLanguages,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _language = newValue;
//                           });
//                         },
//                         icon: Icons.language,
//                       ),
//                       const SizedBox(height: AppConstants.spacing * 4),
//                       if (_errorMessage != null)
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: AppConstants.spacing * 2),
//                           child: Text(
//                             _errorMessage!,
//                             style: const TextStyle(color: AppColors.errorColor),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       CustomButton(
//                         onPressed: _completeOnboarding,
//                         text: 'Start My Journey!',
//                         icon: Icons.rocket_launch,
//                         isLoading: _isLoading,
//                       ),
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
// // lib/screens/level_selection_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/screens/lesson_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/course.dart'; // Import Course model
// import 'package:gamifier/models/level.dart';
// import 'package:gamifier/models/lesson.dart'; // Import Lesson model
// import 'package:gamifier/models/question.dart'; // Import Question model
// import 'package:gamifier/models/user_profile.dart'; // Import UserProfile model
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/gemini_api_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/gamification/level_node.dart';
// import 'package:gamifier/widgets/gamification/level_path_painter.dart';
// import 'dart:math'; // Import for max
// import 'package:collection/collection.dart'; // Import for firstWhereOrNull

// class LevelSelectionScreen extends StatefulWidget {
//   final String courseId;
//   final String courseTitle;

//   const LevelSelectionScreen({
//     super.key,
//     required this.courseId,
//     required this.courseTitle,
//   });

//   @override
//   State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
// }

// class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
//   late Stream<List<Level>> _levelsStream;
//   late Stream<UserProgress?> _userProgressStream;
//   UserProfile? _currentUserProfile;
//   List<Level> _levels = [];
//   bool _isLoadingMoreLevels = false;
//   String? _errorMessage;
//   final Map<String, Offset> _levelNodePositions = {}; // To store calculated top-left positions

//   // A key to access the render box of a specific level node
//   final Map<String, GlobalKey> _levelKeys = {};

//   @override
//   void initState() {
//     super.initState();
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser != null) {
//       _levelsStream = firebaseService.streamLevelsForCourse(widget.courseId);
//       _levelsStream.listen((levels) {
//         if (mounted) {
//           setState(() {
//             _levels = levels;
//             // Initialize GlobalKeys for new levels
//             for (var level in levels) {
//               if (!_levelKeys.containsKey(level.id)) {
//                 _levelKeys[level.id] = GlobalKey();
//               }
//             }
//             // Recalculate positions after the levels data is updated
//             // Do this in a post-frame callback to ensure widgets are rendered and have sizes
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               _calculateLevelNodePositions();
//             });
//           });
//         }
//       }).onError((e) {
//         debugPrint('Error streaming levels: $e');
//         if (mounted) {
//           setState(() {
//             _errorMessage = 'Failed to load levels: ${e.toString()}';
//           });
//         }
//       });

//       _userProgressStream = firebaseService.streamUserCourseProgress(currentUser.uid, widget.courseId);
//       _userProgressStream.listen((progress) {
//         if (mounted && progress != null) {
//           debugPrint('User Progress Updated: ${progress.currentLevelId}');
//           // Trigger recalculation if progress affects level unlock status
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _calculateLevelNodePositions(); // Re-render paths based on completion status
//           });
//         }
//       }).onError((e) {
//         debugPrint('Error streaming user progress: $e');
//       });

//       firebaseService.streamUserProfile(currentUser.uid).listen((profile) {
//         if (mounted) {
//           setState(() {
//             _currentUserProfile = profile;
//           });
//         }
//       });
//     } else {
//       _errorMessage = 'User not logged in. Please log in to view courses.';
//     }
//   }

//   // Calculate positions for zigzag layout using a Stack
//   void _calculateLevelNodePositions() {
//     _levelNodePositions.clear();
//     const double nodeSize = 120.0; // Width/Height of LevelNode
//     const double verticalStep = 160.0; // Vertical distance between centers of nodes (increased for more space)

//     final double screenWidth = MediaQuery.of(context).size.width;
//     // Adjusted these to better center the columns for any screen size
//     final double leftColumnX = screenWidth * 0.2 - nodeSize / 2;
//     final double rightColumnX = screenWidth * 0.8 - nodeSize / 2;

//     for (int i = 0; i < _levels.length; i++) {
//       final level = _levels[i];
//       double x;
//       double y = (i * verticalStep) + AppConstants.padding * 2; // Add top padding to start layout lower

//       if (i % 2 == 0) {
//         // Even index (0, 2, 4...), aligned to the left side
//         x = leftColumnX;
//       } else {
//         // Odd index (1, 3, 5...), aligned to the right side
//         x = rightColumnX;
//       }
//       _levelNodePositions[level.id] = Offset(x, y);
//     }

//     // Recalculate positions for the "Generate More Levels" button
//     if (_levels.length < AppConstants.maxLevelsPerCourse) {
//       final double lastNodeY = _levels.isNotEmpty
//           ? _levelNodePositions[_levels.last.id]!.dy + verticalStep
//           : AppConstants.padding * 2; // Position below the last node or initial padding
//       final double centerX = screenWidth / 2 - nodeSize / 2; // Center the button
//       _levelNodePositions['generate_more'] = Offset(centerX, lastNodeY);
//     }
//   }


//   Future<void> _loadMoreLevels() async {
//     if (_isLoadingMoreLevels || _levels.length >= AppConstants.maxLevelsPerCourse) {
//       return;
//     }

//     setState(() {
//       _isLoadingMoreLevels = true;
//       _errorMessage = null;
//     });

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final geminiService = Provider.of<GeminiApiService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;
//     final userProfile = await firebaseService.getUserProfile(currentUser!.uid);


//     if (currentUser == null || userProfile == null) {
//       setState(() {
//         _errorMessage = 'User not logged in or profile not found.';
//         _isLoadingMoreLevels = false;
//       });
//       return;
//     }

//     try {
//       final int nextStartingOrder = _levels.isNotEmpty ? _levels.last.order + 1 : 1;
//       final int levelsToGenerate = (AppConstants.maxLevelsPerCourse - _levels.length).clamp(0, AppConstants.subsequentLevelsBatchSize);

//       if (levelsToGenerate <= 0) {
//         setState(() {
//           _isLoadingMoreLevels = false;
//         });
//         return;
//       }

//       final List<Level> previousLevelsContext = _levels.sublist(
//           _levels.length > 5 ? _levels.length - 5 : 0); // Provide last few levels for context

//       final Map<String, dynamic> generatedData = await geminiService.generateSubsequentLevels(
//         courseId: widget.courseId,
//         topicName: widget.courseTitle,
//         ageGroup: 'college student',
//         domain: 'General Education',
//         difficulty: 'Intermediate',
//         language: userProfile.language ?? AppConstants.supportedLanguages.first, // Use user's preferred language or default
//         startingLevelOrder: nextStartingOrder,
//         numberOfLevels: levelsToGenerate,
//         educationLevel: userProfile.educationLevel,
//         specialty: userProfile.specialty,
//       );

//       List<Level> newLevels = (generatedData['levels'] as List).map((e) => Level.fromMap(e as Map<String, dynamic>)).toList();
//       Map<String, List<Lesson>> lessonsPerLevel = {};
//       (generatedData['lessonsPerLevel'] as Map).forEach((key, value) {
//         lessonsPerLevel[key as String] = (value as List).map((e) => Lesson.fromMap(e as Map<String, dynamic>)).toList();
//       });

//       Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel = {};
//       (generatedData['questionsPerLessonPerLevel'] as Map).forEach((levelId, lessonMap) {
//         questionsPerLessonPerLevel[levelId as String] = {};
//         (lessonMap as Map).forEach((lessonId, questionList) {
//           questionsPerLessonPerLevel[levelId]![lessonId as String] = (questionList as List).map((e) => Question.fromMap(e as Map<String, dynamic>)).toList();
//         });
//       });


//       await firebaseService.saveLevels(newLevels, lessonsPerLevel, questionsPerLessonPerLevel);

//       // Update the course with new level IDs
//       final Course? existingCourse = await firebaseService.getCourse(widget.courseId);
//       if (existingCourse != null) {
//         final updatedCourse = existingCourse.copyWith(
//           levelIds: [...?existingCourse.levelIds, ...newLevels.map((l) => l.id).toList()],
//         );
//         await firebaseService.updateCourse(widget.courseId, {'levelIds': updatedCourse.levelIds});
//       }

//       if (mounted) {
//         setState(() {
//           _levels.addAll(newLevels);
//           // Initialize GlobalKeys for newly added levels
//           for (var level in newLevels) {
//             _levelKeys[level.id] = GlobalKey();
//           }
//           _calculateLevelNodePositions(); // Recalculate positions after adding new levels
//         });
//       }
//     } catch (e) {
//       debugPrint('Error generating more levels: $e');
//       if (mounted) {
//         setState(() {
//           _errorMessage = 'Failed to generate more levels: ${e.toString()}';
//         });
//       }
//     } finally {
//       setState(() {
//         _isLoadingMoreLevels = false;
//       });
//     }
//   }

//   void _onLevelTapped(Level level, UserProgress? userProgress) async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please log in to start a lesson.')),
//       );
//       return;
//     }

//     // Determine if the level is currently locked.
//     // A level is locked if it's not the first level AND the previous level is not completed.
//     final bool isPreviousLevelCompleted = level.order == 1 ||
//         _levels.any((l) => l.order == level.order - 1 && (userProgress?.levelsProgress[l.id]?.isCompleted == true));

//     final bool isLocked = !isPreviousLevelCompleted && level.order != 1;


//     if (isLocked) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('This level is locked! Complete previous levels first.')),
//       );
//       return;
//     }

//     try {
//       // Fetch the most up-to-date user progress
//       UserProgress? latestUserProgress = await firebaseService.getUserCourseProgress(currentUser.uid, widget.courseId);
//       Lesson? lessonToStart;

//       // Determine which lesson to start within the level
//       List<Lesson> allLessonsInLevel = await firebaseService.getFirestore()
//           .collection(AppConstants.levelsCollection)
//           .doc(level.id)
//           .collection('lessons')
//           .orderBy('order')
//           .get()
//           .then((snapshot) => snapshot.docs.map((doc) => Lesson.fromMap(doc.data())).toList());

//       if (allLessonsInLevel.isEmpty) {
//         debugPrint('No lessons found for level ${level.id}.');
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('No lessons available for this level. Please try another course.')),
//           );
//         }
//         return;
//       }

//       if (latestUserProgress != null &&
//           latestUserProgress.currentLevelId == level.id &&
//           latestUserProgress.currentLessonId != null) {
//         // User is continuing this level, try to load current lesson
//         lessonToStart = allLessonsInLevel.firstWhereOrNull(
//               (lesson) => lesson.id == latestUserProgress.currentLessonId,
//         );

//         // If current lesson is completed or not found, try to find the next uncompleted lesson
//         if (lessonToStart == null || (latestUserProgress.lessonsProgress[lessonToStart.id]?.isCompleted == true)) {
//           lessonToStart = allLessonsInLevel.firstWhereOrNull(
//                 (lesson) => !(latestUserProgress?.lessonsProgress[lesson.id]?.isCompleted == true),
//           );
//         }
//       }

//       if (lessonToStart == null) {
//         // If no progress, or no next uncompleted lesson found, start from the first lesson of the level
//         lessonToStart = allLessonsInLevel.first;
//       }

//       if (lessonToStart != null) {
//         // Update user progress to reflect the current level and lesson
//         final String progressId = '${currentUser.uid}_${widget.courseId}';
//         final updatedUserProgress = (latestUserProgress ?? UserProgress(
//           id: progressId,
//           userId: currentUser.uid,
//           courseId: widget.courseId,
//           currentLevelId: level.id,
//           currentLessonId: lessonToStart.id,
//         )).copyWith(
//           currentLevelId: level.id,
//           currentLessonId: lessonToStart.id,
//           levelsProgress: Map.from(latestUserProgress?.levelsProgress ?? {})..putIfAbsent(level.id, () => const LevelProgress(isCompleted: false, xpEarned: 0, score: 0)),
//           lessonsProgress: Map.from(latestUserProgress?.lessonsProgress ?? {})..putIfAbsent(lessonToStart.id, () => const LessonProgress(isCompleted: false, xpEarned: 0, questionAttempts: {})),
//         );
//         await firebaseService.saveUserProgress(updatedUserProgress);

//         if (mounted) {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => LessonScreen(
//                 courseId: widget.courseId,
//                 levelId: level.id,
//                 lessonId: lessonToStart!.id,
//                 levelOrder: level.order,
//               ),
//             ),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to load lesson details. Please try again.')),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error navigating to lesson: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load lesson: ${e.toString()}')),
//       );
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: CustomAppBar(
//         title: widget.courseTitle,
//         automaticallyImplyLeading: true, // Show back arrow
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: StreamBuilder<UserProgress?>(
//             stream: _userProgressStream,
//             builder: (context, progressSnapshot) {
//               final userProgress = progressSnapshot.data;

//               // Calculate the total height needed for the scrollable content
//               // This accounts for all level nodes and the "Generate More Levels" button
//               final double contentHeight = (_levels.length * 160.0) + // Vertical step per level
//                   (AppConstants.padding * 4) + // Initial/final padding
//                   (AppConstants.levelSelectionGenerateButtonHeight); // Height for the button area

//               return SingleChildScrollView(
//                 child: SizedBox(
//                   // Ensure the SizedBox has enough height to allow scrolling if content exceeds screen height
//                   height: max(contentHeight, MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top),
//                   width: MediaQuery.of(context).size.width, // Ensure it takes full width for painting
//                   child: Stack(
//                     children: [
//                       // Draw zigzag lines
//                       if (_levels.isNotEmpty && _levelNodePositions.isNotEmpty)
//                         CustomPaint(
//                           painter: LevelPathPainter(
//                             levels: _levels,
//                             levelPositions: _levelNodePositions,
//                             levelCompletionStatus: {
//                               for (var level in _levels)
//                                 level.id: userProgress?.levelsProgress[level.id]?.isCompleted == true,
//                             },
//                             nodeSize: 120.0, // Pass node size for path calculation
//                           ),
//                           child: Container(), // Empty container to provide paint area
//                         ),

//                       // Position LevelNodes
//                       ..._levels.map((level) {
//                         final int currentLevelIndex = _levels.indexOf(level);
//                         final String? previousLevelId = currentLevelIndex > 0 ? _levels[currentLevelIndex - 1].id : null;
//                         final bool isPreviousLevelCompleted = previousLevelId != null && (userProgress?.levelsProgress[previousLevelId]?.isCompleted == true);

//                         final bool isLocked = level.order > 1 && !isPreviousLevelCompleted;

//                         final Offset? position = _levelNodePositions[level.id];
//                         if (position == null) return const SizedBox.shrink();

//                         return Positioned(
//                           left: position.dx,
//                           top: position.dy,
//                           child: LevelNode(
//                             key: _levelKeys[level.id], // Assign GlobalKey
//                             level: level,
//                             isCompleted: userProgress?.levelsProgress[level.id]?.isCompleted == true, // Explicitly check completion status from userProgress
//                             isLocked: isLocked,
//                             onTap: () => _onLevelTapped(level, userProgress),
//                           ),
//                         );
//                       }).toList(),

//                       // Position "Generate More Levels" button
//                       if (_levels.length < AppConstants.maxLevelsPerCourse)
//                         Positioned(
//                           left: _levelNodePositions['generate_more']?.dx,
//                           top: _levelNodePositions['generate_more']?.dy,
//                           child: GestureDetector(
//                             onTap: _isLoadingMoreLevels ? null : _loadMoreLevels,
//                             child: Card(
//                               color: AppColors.cardColor.withOpacity(0.7),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                                 side: BorderSide(color: AppColors.borderColor.withOpacity(0.5), width: 1),
//                               ),
//                               child: Container(
//                                 width: 120, // Match node size
//                                 height: 120, // Match node size
//                                 padding: const EdgeInsets.all(AppConstants.padding),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     _isLoadingMoreLevels
//                                         ? const CircularProgressIndicator(color: AppColors.accentColor)
//                                         : Icon(
//                                             Icons.add_circle_outline,
//                                             color: AppColors.textColorSecondary.withOpacity(0.7),
//                                             size: 50,
//                                           ),
//                                     const SizedBox(height: AppConstants.spacing),
//                                     Text(
//                                       _isLoadingMoreLevels ? 'Generating...' : 'Generate More Levels',
//                                       style: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.9), fontSize: 12), // Smaller font
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     if (_errorMessage != null)
//                                       Padding(
//                                         padding: const EdgeInsets.only(top: AppConstants.spacing),
//                                         child: Text(
//                                           _errorMessage!,
//                                           style: const TextStyle(color: AppColors.errorColor, fontSize: 10),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/screens/level_completion_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/audio_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/xp_level_display.dart';
// import 'package:gamifier/screens/level_selection_screen.dart'; // Import LevelSelectionScreen
// import 'package:gamifier/screens/home_screen.dart'; // Import HomeScreen

// class LevelCompletionScreen extends StatefulWidget {
//   final String courseId;
//   final String levelId;
//   final int xpEarned;
//   final bool isCourseCompleted;

//   const LevelCompletionScreen({
//     super.key,
//     required this.courseId,
//     required this.levelId,
//     required this.xpEarned,
//     this.isCourseCompleted = false,
//   });

//   @override
//   State<LevelCompletionScreen> createState() => _LevelCompletionScreenState();
// }

// class _LevelCompletionScreenState extends State<LevelCompletionScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//   late AudioService _audioService;
//   int _currentXp = 0;
//   int _currentLevel = 0;

//   @override
//   void initState() {
//     super.initState();
//     _audioService = Provider.of<AudioService>(context, listen: false);
//     _audioService.playLevelUpSound();
//     _loadUserProfile(); // Load user profile to display updated XP and Level

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );

//     _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );

//     _controller.forward();
//   }

//   Future<void> _loadUserProfile() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final user = firebaseService.currentUser;
//     if (user != null) {
//       // Use a stream to react to real-time updates of XP/level
//       firebaseService.streamUserProfile(user.uid).listen((profile) {
//         if (mounted && profile != null) {
//           setState(() {
//             _currentXp = profile.xp;
//             _currentLevel = profile.level;
//           });
//         }
//       }).onError((error) {
//         debugPrint('Error streaming user profile in LevelCompletionScreen: $error');
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(AppConstants.padding * 2),
//             child: ScaleTransition(
//               scale: _scaleAnimation,
//               child: FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: Card(
//                   color: AppColors.cardColor.withOpacity(0.9),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
//                     side: const BorderSide(color: AppColors.accentColor, width: 2),
//                   ),
//                   elevation: 10,
//                   child: Padding(
//                     padding: const EdgeInsets.all(AppConstants.padding * 2),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(
//                           Icons.check_circle_outline,
//                           color: AppColors.successColor,
//                           size: 80,
//                         ),
//                         const SizedBox(height: AppConstants.spacing * 2),
//                         Text(
//                           widget.isCourseCompleted ? 'Course Completed!' : 'Level Completed!',
//                           style: AppColors.neonTextStyle(fontSize: 28, color: AppColors.accentColor),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: AppConstants.spacing),
//                         Text(
//                           'You earned ${widget.xpEarned} XP!',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.xpColor,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: AppConstants.spacing * 2),
//                         XpLevelDisplay(xp: _currentXp, level: _currentLevel),
//                         const SizedBox(height: AppConstants.spacing * 4),
//                         CustomButton(
//                           onPressed: () {
//                             if (widget.isCourseCompleted) {
//                               // If course is completed, go back to the Home screen and remove all other routes
//                               Navigator.of(context).pushAndRemoveUntil(
//                                 MaterialPageRoute(builder: (context) => const HomeScreen()),
//                                 (route) => false, // Remove all routes
//                               );
//                             } else {
//                               // If course is NOT completed, go back to the Level Selection for this course
//                               // Remove all routes until the home route, then push LevelSelectionScreen
//                               // This handles cases where LessonScreen might be pushed directly.
//                               Navigator.of(context).pushAndRemoveUntil(
//                                 MaterialPageRoute(
//                                   builder: (context) => LevelSelectionScreen(
//                                     courseId: widget.courseId,
//                                     courseTitle: '', // Title not strictly needed for navigation, but required by constructor
//                                   ),
//                                 ),
//                                 (route) => route.settings.name == AppRouter.homeRoute || route.isFirst,
//                               );
//                             }
//                           },
//                           text: widget.isCourseCompleted ? 'Back to Courses' : 'Continue Learning',
//                           icon: widget.isCourseCompleted ? Icons.menu_book : Icons.play_arrow,
//                         ),
//                         const SizedBox(height: AppConstants.spacing),
//                         CustomButton(
//                           onPressed: () {
//                             // Navigate directly to Home and clear all routes below it
//                             Navigator.of(context).pushAndRemoveUntil(
//                               MaterialPageRoute(builder: (context) => const HomeScreen()),
//                               (route) => false, // Remove all routes
//                             );
//                           },
//                           text: 'Go to Home',
//                           icon: Icons.home,
//                         ),
//                       ],
//                     ),
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
// // lib/screens/lesson_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/lesson.dart';
// import 'package:gamifier/models/level.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/audio_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/utils/validation_utils.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/progress_bar.dart';
// import 'package:gamifier/widgets/feedback/personalized_feedback_modal.dart';
// import 'package:gamifier/widgets/lesson/lesson_content_display.dart';
// import 'package:gamifier/widgets/questions/question_renderer.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart'; // Import BottomNavBar

// class LessonScreen extends StatefulWidget {
//   final String courseId;
//   final String levelId;
//   final String lessonId;
//   final int levelOrder;

//   const LessonScreen({
//     super.key,
//     required this.courseId,
//     required this.levelId,
//     required this.lessonId,
//     required this.levelOrder,
//   });

//   @override
//   State<LessonScreen> createState() => _LessonScreenState();
// }

// class _LessonScreenState extends State<LessonScreen> {
//   Lesson? _currentLesson;
//   Level? _currentLevel;
//   List<Question> _questions = [];
//   UserProgress? _userProgress;
//   int _currentQuestionIndex = 0;
//   bool _isLoading = true;
//   String? _errorMessage;
//   Map<String, String> _userAnswers = {};
//   Map<String, bool> _questionAttemptStatus = {};
//   Map<String, int> _xpAwardedPerQuestion = {};

//   late FirebaseService _firebaseService;
//   late AudioService _audioService;

//   @override
//   void initState() {
//     super.initState();
//     _firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     _audioService = Provider.of<AudioService>(context, listen: false);
//     _loadLessonAndProgress();
//   }

//   Future<void> _loadLessonAndProgress() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final user = _firebaseService.currentUser;
//       if (user == null) {
//         setState(() {
//           _errorMessage = 'User not logged in.';
//           _isLoading = false;
//         });
//         return;
//       }

//       final lesson = await _firebaseService.getLesson(widget.levelId, widget.lessonId);
//       final level = await _firebaseService.getLevel(widget.levelId);
//       final questions = await _firebaseService.getLessonQuestions(widget.levelId, widget.lessonId);
//       final userProgress = await _firebaseService.getUserCourseProgress(user.uid, widget.courseId);

//       if (lesson == null || level == null) {
//         setState(() {
//           _errorMessage = 'Lesson or Level not found. Please go back and try again.';
//           _isLoading = false;
//         });
//         return;
//       }

//       setState(() {
//         _currentLesson = lesson;
//         _currentLevel = level;
//         _questions = questions;
//         _userProgress = userProgress ?? UserProgress(
//           id: '${user.uid}_${widget.courseId}',
//           userId: user.uid,
//           courseId: widget.courseId,
//           currentLevelId: widget.levelId,
//           currentLessonId: widget.lessonId,
//         );

//         // Restore user answers and question attempt status if available in progress
//         final lessonProgress = _userProgress!.lessonsProgress[_currentLesson!.id];
//         if (lessonProgress != null) {
//           _currentQuestionIndex = lessonProgress.questionAttempts.length;
//           lessonProgress.questionAttempts.forEach((questionId, attempt) {
//             _questionAttemptStatus[questionId] = attempt.isCorrect;
//             _userAnswers[questionId] = attempt.userAnswer;
//             _xpAwardedPerQuestion[questionId] = attempt.xpAwarded;
//           });
//         }
//         _isLoading = false;
//       });
//     } catch (e) {
//       debugPrint('Error loading lesson or progress: $e');
//       setState(() {
//         _errorMessage = 'Failed to load lesson content: ${e.toString()}';
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _submitAnswer(String questionId, String userAnswer, String questionType, dynamic correctAnswerData) async {
//     if (_isLoading) return;
//     setState(() {
//       _isLoading = true;
//     });

//     final firebaseUser = _firebaseService.currentUser;
//     if (firebaseUser == null || _currentLesson == null || _userProgress == null) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = 'User not logged in or lesson/progress data missing.';
//       });
//       return;
//     }

//     // Ensure correctAnswerData is a String for validation, defaulting to empty if null
//     // Specifically handle MCQ where correctAnswer is the correct option string
//     String validationCorrectAnswer;
//     if (questionType == 'MCQ') {
//       // For MCQ, correctAnswerData should directly be the correct answer string from the Question model
//       validationCorrectAnswer = _questions.firstWhere((q) => q.id == questionId).correctAnswer ?? '';
//     } else {
//       validationCorrectAnswer = correctAnswerData?.toString() ?? '';
//     }


//     final bool isCorrect = ValidationUtils.validateAnswer(userAnswer, questionType, validationCorrectAnswer);
//     final int xpAwarded = isCorrect ? _questions[_currentQuestionIndex].xpReward : 0;

//     // Only play correct sound if the answer is correct
//     if (isCorrect) {
//       _audioService.playCorrectSound();
//     }

//     setState(() {
//       _userAnswers[questionId] = userAnswer;
//       _questionAttemptStatus[questionId] = isCorrect;
//       _xpAwardedPerQuestion[questionId] = xpAwarded;
//     });

//     // Update user progress
//     LessonProgress currentLessonProgress = _userProgress!.lessonsProgress[_currentLesson!.id] ??
//         const LessonProgress(isCompleted: false, xpEarned: 0, questionAttempts: {});

//     final updatedQuestionAttempts = Map<String, QuestionAttempt>.from(currentLessonProgress.questionAttempts);
//     updatedQuestionAttempts[questionId] = QuestionAttempt(
//       userAnswer: userAnswer,
//       isCorrect: isCorrect,
//       attemptedAt: DateTime.now(),
//       xpAwarded: xpAwarded,
//     );

//     currentLessonProgress = currentLessonProgress.copyWith(
//       xpEarned: (currentLessonProgress.xpEarned) + xpAwarded, // Correctly accumulate XP
//       questionAttempts: updatedQuestionAttempts,
//     );

//     Map<String, LessonProgress> updatedLessonsProgress = Map.from(_userProgress!.lessonsProgress);
//     updatedLessonsProgress[_currentLesson!.id] = currentLessonProgress;

//     await _firebaseService.addXp(firebaseUser.uid, xpAwarded);

//     _userProgress = _userProgress!.copyWith(
//       lessonsProgress: updatedLessonsProgress,
//     );
//     await _firebaseService.saveUserProgress(_userProgress!);

//     setState(() {
//       _isLoading = false;
//     });

//     await showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (ctx) => PersonalizedFeedbackModal(
//         isCorrect: isCorrect,
//         userAnswer: userAnswer,
//         questionText: _questions[_currentQuestionIndex].questionText,
//         correctAnswer: validationCorrectAnswer, // Pass the non-null string
//         lessonContent: _currentLesson!.content,
//         userProgress: _userProgress!,
//       ),
//     );

//     _goToNextQuestion();
//   }

//   void _goToNextQuestion() {
//     setState(() {
//       if (_currentQuestionIndex < _questions.length - 1) {
//         _currentQuestionIndex++;
//       } else {
//         _markLessonCompleted();
//       }
//     });
//   }

//   Future<void> _markLessonCompleted() async {
//     final firebaseUser = _firebaseService.currentUser;
//     if (firebaseUser == null || _currentLesson == null || _userProgress == null) {
//       return;
//     }

//     LessonProgress currentLessonProgress = _userProgress!.lessonsProgress[_currentLesson!.id] ??
//         const LessonProgress(isCompleted: false, xpEarned: 0, questionAttempts: {});

//     if (!currentLessonProgress.isCompleted) {
//       currentLessonProgress = currentLessonProgress.copyWith(
//         isCompleted: true,
//         completedAt: DateTime.now(),
//       );

//       Map<String, LessonProgress> updatedLessonsProgress = Map.from(_userProgress!.lessonsProgress);
//       updatedLessonsProgress[_currentLesson!.id] = currentLessonProgress;

//       _userProgress = _userProgress!.copyWith(
//         lessonsProgress: updatedLessonsProgress,
//       );
//       await _firebaseService.saveUserProgress(_userProgress!);
//     }

//     // Check if current level is completed
//     List<Lesson> allLessonsInLevel = [];
//     try {
//       final levelRef = _firebaseService.getFirestore().collection(AppConstants.levelsCollection).doc(widget.levelId);
//       final lessonsSnapshot = await levelRef.collection('lessons').orderBy('order').get();
//       allLessonsInLevel = lessonsSnapshot.docs.map((doc) => Lesson.fromMap(doc.data())).toList();
//     } catch (e) {
//       debugPrint('Error fetching all lessons in level: $e');
//       // If error, assume lessons are not all fetched and handle gracefully
//       allLessonsInLevel = [];
//     }


//     bool allLessonsCompletedInLevel = allLessonsInLevel.isNotEmpty && allLessonsInLevel.every((lesson) {
//       return _userProgress!.lessonsProgress[lesson.id]?.isCompleted == true;
//     });

//     if (allLessonsCompletedInLevel) {
//       int totalXpEarnedInLevel = allLessonsInLevel.fold(0, (sum, lesson) => sum + (_userProgress!.lessonsProgress[lesson.id]?.xpEarned ?? 0));

//       LevelProgress currentLevelProgress = _userProgress!.levelsProgress[widget.levelId] ??
//           const LevelProgress(isCompleted: false, xpEarned: 0, score: 0);

//       currentLevelProgress = currentLevelProgress.copyWith(
//         isCompleted: true,
//         xpEarned: (currentLevelProgress.xpEarned) + totalXpEarnedInLevel, // Ensure xpEarned is not null
//         score: (totalXpEarnedInLevel / (allLessonsInLevel.length * 15 * (_questions.isNotEmpty ? _questions.length : 1))).round(), // Rough score calculation
//         completedAt: DateTime.now(),
//       );

//       Map<String, LevelProgress> updatedLevelsProgress = Map.from(_userProgress!.levelsProgress);
//       updatedLevelsProgress[widget.levelId] = currentLevelProgress;

//       _userProgress = _userProgress!.copyWith(
//         currentLevelId: null, // Reset current level as it's completed
//         currentLessonId: null, // Reset current lesson as it's completed
//         levelsProgress: updatedLevelsProgress,
//       );
//       await _firebaseService.saveUserProgress(_userProgress!);

//       // Check if course is completed
//       List<Level> allLevelsInCourse = [];
//       try {
//         final courseLevelsSnapshot = await _firebaseService.getFirestore()
//             .collection(AppConstants.levelsCollection)
//             .where('courseId', isEqualTo: widget.courseId)
//             .orderBy('order')
//             .get();
//         allLevelsInCourse = courseLevelsSnapshot.docs.map((doc) => Level.fromMap(doc.data())).toList();
//       } catch (e) {
//         debugPrint('Error fetching all levels in course: $e');
//         allLevelsInCourse = [];
//       }

//       bool allLevelsCompletedInCourse = allLevelsInCourse.isNotEmpty && allLevelsInCourse.every((level) {
//         return _userProgress!.levelsProgress[level.id]?.isCompleted == true;
//       });

//       if (mounted) {
//         Navigator.of(context).pushReplacementNamed(
//           AppRouter.levelCompletionRoute,
//           arguments: {
//             'courseId': widget.courseId,
//             'levelId': widget.levelId,
//             'xpEarned': totalXpEarnedInLevel,
//             'isCourseCompleted': allLevelsCompletedInCourse,
//           },
//         );
//       }
//     } else {
//       // If not all lessons in the current level are completed, go back to level selection
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Lesson completed! Continue to the next lesson or level.'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         Navigator.of(context).pop(); // Go back to level selection
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: CustomAppBar(
//         title: _currentLevel?.title ?? 'Lesson',
//         subtitle: _currentLesson?.title,
//         automaticallyImplyLeading: true, // Allow back to level selection
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: _isLoading
//               ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//               : _errorMessage != null
//                   ? Center(child: Text(_errorMessage!, style: const TextStyle(color: AppColors.errorColor)))
//                   : Padding(
//                       padding: const EdgeInsets.all(AppConstants.padding),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (_questions.isNotEmpty)
//                             ProgressBar(
//                               current: _currentQuestionIndex,
//                               total: _questions.length,
//                             ),
//                           const SizedBox(height: AppConstants.spacing * 2),
//                           Expanded(
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Card(
//                                     color: AppColors.cardColor.withOpacity(0.9),
//                                     elevation: 5,
//                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(AppConstants.padding),
//                                       child: LessonContentDisplay(content: _currentLesson!.content),
//                                     ),
//                                   ),
//                                   const SizedBox(height: AppConstants.spacing * 2),
//                                   if (_questions.isNotEmpty && _currentQuestionIndex < _questions.length)
//                                     QuestionRenderer(
//                                       question: _questions[_currentQuestionIndex],
//                                       onSubmit: (userAnswer) {
//                                         // Ensure the correctAnswerData passed is never null
//                                         dynamic dataToSend;
//                                         // Directly use the correctAnswer from the current question for MCQ
//                                         if (_questions[_currentQuestionIndex].type == 'MCQ') {
//                                           dataToSend = _questions[_currentQuestionIndex].correctAnswer;
//                                         } else {
//                                           switch (_questions[_currentQuestionIndex].type) {
//                                             case 'FillInBlank':
//                                               dataToSend = _questions[_currentQuestionIndex].correctAnswer;
//                                               break;
//                                             case 'ShortAnswer':
//                                               dataToSend = _questions[_currentQuestionIndex].expectedAnswerKeywords;
//                                               break;
//                                             case 'Scenario':
//                                               dataToSend = _questions[_currentQuestionIndex].expectedOutcome;
//                                               break;
//                                             default:
//                                               dataToSend = ''; // Default for unknown types
//                                           }
//                                         }


//                                         _submitAnswer(
//                                           _questions[_currentQuestionIndex].id,
//                                           userAnswer,
//                                           _questions[_currentQuestionIndex].type,
//                                           dataToSend ?? '', // Ensure it's never null
//                                         );
//                                       },
//                                       isSubmitted: _questionAttemptStatus.containsKey(_questions[_currentQuestionIndex].id),
//                                       lastUserAnswer: _userAnswers[_questions[_currentQuestionIndex].id],
//                                       isLastAttemptCorrect: _questionAttemptStatus[_questions[_currentQuestionIndex].id],
//                                       xpAwarded: _xpAwardedPerQuestion[_questions[_currentQuestionIndex].id],
//                                     )
//                                   else if (_questions.isEmpty)
//                                     const Center(
//                                       child: Text(
//                                         'No questions for this lesson yet. Please try again later.',
//                                         style: TextStyle(color: AppColors.textColorSecondary),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           if (_questions.isNotEmpty && _currentQuestionIndex == _questions.length)
//                             Padding(
//                               padding: const EdgeInsets.only(top: AppConstants.padding),
//                               child: CustomButton(
//                                 onPressed: _markLessonCompleted,
//                                 text: 'Finish Lesson',
//                                 icon: Icons.flag,
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 0), // Default to home in bottom nav
//     );
//   }
// }
// // lib/screens/home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/course/course_card.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:gamifier/widgets/common/xp_level_display.dart';
// import 'package:gamifier/widgets/gamification/streak_display.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   UserProfile? _userProfile;
//   late Stream<List<Course>> _coursesStream;
//   late FirebaseService _firebaseService;

//   @override
//   void initState() {
//     super.initState();
//     _firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     _loadUserProfile();
//     _coursesStream = _firebaseService.streamAllCourses();
//   }

//   Future<void> _loadUserProfile() async {
//     final user = _firebaseService.currentUser;
//     if (user != null) {
//       _firebaseService.streamUserProfile(user.uid).listen((profile) {
//         if (mounted) {
//           setState(() {
//             _userProfile = profile;
//           });
//         }
//       }).onError((error) {
//         debugPrint('Error loading user profile: $error');
//       });
//     }
//   }

//   void _onCourseTapped(Course course) {
//     Navigator.of(context).pushNamed(
//       AppRouter.levelSelectionRoute,
//       arguments: {
//         'courseId': course.id,
//         'courseTitle': course.title,
//       },
//     );
//   }

//   void _deleteCourse(Course course) async {
//     final bool? confirmDelete = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           backgroundColor: AppColors.cardColor,
//           title: const Text('Delete Course', style: TextStyle(color: AppColors.textColor)),
//           content: Text(
//             'Are you sure you want to delete "${course.title}"? This action cannot be undone.',
//             style: const TextStyle(color: AppColors.textColorSecondary),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop(false);
//               },
//               child: const Text('Cancel', style: TextStyle(color: AppColors.accentColor)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop(true);
//               },
//               child: const Text('Delete', style: TextStyle(color: AppColors.errorColor)),
//             ),
//           ],
//         );
//       },
//     );

//     if (confirmDelete == true) {
//       try {
//         await _firebaseService.deleteCourse(course.id, course.levelIds);
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Course deleted successfully!')),
//           );
//         }
//       } catch (e) {
//         debugPrint('Error deleting course: $e');
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to delete course: ${e.toString()}')),
//           );
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(
//         title: AppConstants.appName,
//         automaticallyImplyLeading: false, // Home screen is the root, no back button needed.
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(AppConstants.padding),
//                 child: _userProfile == null
//                     ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//                     : Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: AppConstants.avatarSize / 2,
//                                 backgroundImage: AssetImage(_userProfile!.avatarAssetPath),
//                                 backgroundColor: AppColors.borderColor,
//                               ),
//                               const SizedBox(width: AppConstants.spacing * 2),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Hello, ${_userProfile!.username}!',
//                                       style: AppColors.neonTextStyle(fontSize: 24),
//                                     ),
//                                     const SizedBox(height: AppConstants.spacing),
//                                     XpLevelDisplay(
//                                       xp: _userProfile!.xp,
//                                       level: _userProfile!.level,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: AppConstants.spacing * 2),
//                           StreakDisplay(currentStreak: _userProfile!.currentStreak),
//                         ],
//                       ),
//               ),
//               Expanded(
//                 child: StreamBuilder<List<Course>>(
//                   stream: _coursesStream,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
//                     }
//                     if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
//                     }
//                     if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return const Center(
//                         child: Text(
//                           'No courses found. Create one to get started!',
//                           style: TextStyle(color: AppColors.textColorSecondary, fontSize: 18),
//                           textAlign: TextAlign.center,
//                         ),
//                       );
//                     }
//                     final courses = snapshot.data!;
//                     return ListView.builder(
//                       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
//                       itemCount: courses.length,
//                       itemBuilder: (context, index) {
//                         final course = courses[index];
//                         return CourseCard(
//                           course: course,
//                           onTap: () => _onCourseTapped(course),
//                           onDelete: () => _deleteCourse(course),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 0),
//     );
//   }
// }
// // lib/screens/course_creation_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/models/level.dart';
// import 'package:gamifier/models/lesson.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/gemini_api_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/course/course_form.dart';
// import 'package:gamifier/utils/file_picker_util.dart';

// class CourseCreationScreen extends StatefulWidget {
//   const CourseCreationScreen({super.key});

//   @override
//   State<CourseCreationScreen> createState() => _CourseCreationScreenState();
// }

// class _CourseCreationScreenState extends State<CourseCreationScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String _topicName = '';
//   String _domain = '';
//   String _difficulty = AppConstants.difficultyLevels[0];
//   String _educationLevel = AppConstants.educationLevels[0];
//   String _language = AppConstants.supportedLanguages[0]; // Changed from _gameGenre
//   String _sourceContent = '';
//   String _youtubeUrl = '';
//   bool _isLoading = false;
//   String? _errorMessage;

//   Future<void> _pickFile() async {
//     final content = await FilePickerUtil.pickTextFile();
//     if (content != null) {
//       setState(() {
//         _sourceContent = content;
//       });
//     }
//   }

//   Future<void> _createCourse() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     _formKey.currentState!.save();

//     if (_sourceContent.isEmpty && _youtubeUrl.isEmpty && _topicName.isEmpty) {
//       setState(() {
//         _errorMessage = 'Please provide a Topic Name or Source Content/YouTube URL.';
//       });
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final geminiService = Provider.of<GeminiApiService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       setState(() {
//         _errorMessage = 'You must be logged in to create a course.';
//         _isLoading = false;
//       });
//       return;
//     }

//     try {
//       final String newCourseId = firebaseService.generateNewDocId();

//       final Map<String, dynamic> generatedData = await geminiService.generateCourseContent(
//         topicName: _topicName.isNotEmpty ? _topicName : 'Dynamic Course',
//         ageGroup: 'college student',
//         domain: _domain.isNotEmpty ? _domain : 'General Education',
//         difficulty: _difficulty,
//         educationLevel: _educationLevel,
//         specialty: _domain,
//         language: _language, // Pass the selected language
//         sourceContent: _sourceContent.isNotEmpty ? _sourceContent : null,
//         youtubeUrl: _youtubeUrl.isNotEmpty ? _youtubeUrl : null,
//         numberOfLevels: AppConstants.initialLevelsCount,
//       );

//       Course newCourse = Course(
//         id: newCourseId,
//         title: generatedData['courseTitle'] as String,
//         description: 'A dynamically generated course on ${generatedData['courseTitle']}.',
//         gameGenre: generatedData['gameGenre'] as String?, // Still read gameGenre from model if present
//         language: generatedData['language'] as String, // Read language from generated data
//         difficulty: generatedData['difficulty'] as String,
//         creatorId: currentUser.uid,
//         createdAt: DateTime.now(),
//       );

//       List<Level> levelsToSave = [];
//       Map<String, List<Lesson>> lessonsPerLevel = {};
//       Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel = {};

//       if (generatedData['levels'] is List) { // Robust check for levels list
//         for (var levelData in generatedData['levels']) {
//           if (levelData is Map<String, dynamic>) { // Ensure each level item is a map
//             final level = Level.fromMap(levelData);
//             level.courseId = newCourseId;
//             levelsToSave.add(level);

//             List<Lesson> lessonsForThisLevel = [];
//             Map<String, List<Question>> questionsForThisLevelLessons = {};

//             if (levelData['lessons'] is List) { // Robust check for lessons list
//               for (var lessonData in (levelData['lessons'] as List)) {
//                 if (lessonData is Map<String, dynamic>) { // Ensure each lesson item is a map
//                   final lesson = Lesson.fromMap(lessonData);
//                   lesson.levelId = level.id;
//                   lessonsForThisLevel.add(lesson);

//                   List<Question> questionsForThisLesson = [];
//                   if (lessonData['questions'] is List) { // Robust check for questions list
//                     for (var questionData in (lessonData['questions'] as List)) {
//                       if (questionData is Map<String, dynamic>) { // Ensure each question item is a map
//                         questionsForThisLesson.add(Question.fromMap(questionData));
//                       } else {
//                         debugPrint('Warning: Skipping malformed question data: $questionData');
//                       }
//                     }
//                   }
//                   questionsForThisLevelLessons[lesson.id] = questionsForThisLesson;
//                 } else {
//                   debugPrint('Warning: Skipping malformed lesson data: $lessonData');
//                 }
//               }
//             }
//             lessonsPerLevel[level.id] = lessonsForThisLevel;
//             questionsPerLessonPerLevel[level.id] = questionsForThisLevelLessons;
//           } else {
//             debugPrint('Warning: Skipping malformed level data: $levelData');
//           }
//         }
//       }


//       newCourse = newCourse.copyWith(levelIds: levelsToSave.map((l) => l.id).toList());

//       await firebaseService.saveCourse(newCourse);
//       await firebaseService.saveLevels(levelsToSave, lessonsPerLevel, questionsPerLessonPerLevel);

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Course created successfully!')),
//         );
//         Navigator.of(context).pushReplacementNamed(AppRouter.levelSelectionRoute, arguments: {
//           'courseId': newCourse.id,
//           'courseTitle': newCourse.title,
//         });
//       }
//     } catch (e) {
//       debugPrint('Error creating course: $e');
//       setState(() {
//         _errorMessage = 'Failed to create course: ${e.toString()}';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(title: 'Create New Course'),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(AppConstants.padding),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   CourseForm(
//                     onTopicChanged: (value) => _topicName = value,
//                     onDomainChanged: (value) => _domain = value,
//                     onDifficultyChanged: (value) => setState(() => _difficulty = value!),
//                     onEducationLevelChanged: (value) => setState(() => _educationLevel = value!),
//                     onLanguageChanged: (value) => setState(() => _language = value!), // Changed here
//                     onYoutubeUrlChanged: (value) => _youtubeUrl = value,
//                     onSourceContentChanged: (value) => _sourceContent = value,
//                     currentDifficulty: _difficulty,
//                     currentEducationLevel: _educationLevel,
//                     currentLanguage: _language, // Changed here
//                   ),
//                   const SizedBox(height: AppConstants.spacing * 2),
//                   CustomButton(
//                     onPressed: _pickFile,
//                     text: 'Upload Course Material (Text/PDF)',
//                     icon: Icons.upload_file,
//                   ),
//                   if (_sourceContent.isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//                       child: Text(
//                         'File selected. Content length: ${_sourceContent.length} characters.',
//                         style: const TextStyle(color: AppColors.textColorSecondary),
//                       ),
//                     ),
//                   const SizedBox(height: AppConstants.spacing * 2),
//                   if (_errorMessage != null)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: AppConstants.spacing),
//                       child: Text(
//                         _errorMessage!,
//                         style: const TextStyle(color: AppColors.errorColor),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   _isLoading
//                       ? const CircularProgressIndicator(color: AppColors.accentColor)
//                       : CustomButton(
//                           onPressed: _createCourse,
//                           text: 'Generate Course',
//                           icon: Icons.auto_awesome,
//                         ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 4),
//     );
//   }
// }
// // lib/screens/community_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/community_post.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/services/firebase_service.dart';
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
//   UserProfile? _currentUserProfile;
//   bool _isLoadingPost = false;

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
//       setState(() {
//         _currentUserProfile = profile;
//       });
//     }
//   }

//   Future<void> _createPost() async {
//     if (_postController.text.trim().isEmpty || _currentUserProfile == null) {
//       return;
//     }

//     setState(() {
//       _isLoadingPost = true;
//     });

//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       final newPost = CommunityPost(
//         id: firebaseService.generateNewDocId(),
//         authorId: _currentUserProfile!.uid,
//         authorUsername: _currentUserProfile!.username,
//         authorAvatarUrl: _currentUserProfile!.avatarAssetPath,
//         content: _postController.text.trim(),
//         timestamp: DateTime.now(),
//       );
//       await firebaseService.createCommunityPost(newPost);
//       _postController.clear();
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Post created successfully!')),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error creating post: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to create post: ${e.toString()}')),
//         );
//       }
//     } finally {
//       setState(() {
//         _isLoadingPost = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _postController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(title: 'Community Feed'),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(AppConstants.padding),
//                 child: Column(
//                   children: [
//                     CustomTextField(
//                       controller: _postController,
//                       labelText: 'Share your thoughts or achievements!',
//                       icon: Icons.edit,
//                       maxLines: 3,
//                       keyboardType: TextInputType.multiline,
//                     ),
//                     const SizedBox(height: AppConstants.spacing),
//                     CustomButton(
//                       onPressed: _isLoadingPost ? null : _createPost,
//                       text: 'Create Post',
//                       icon: Icons.send,
//                       isLoading: _isLoadingPost,
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: StreamBuilder<List<CommunityPost>>(
//                   stream: Provider.of<FirebaseService>(context).streamCommunityPosts(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
//                     }
//                     if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
//                     }
//                     if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return const Center(
//                         child: Text(
//                           'No posts yet. Be the first to share!',
//                           style: TextStyle(color: AppColors.textColorSecondary),
//                         ),
//                       );
//                     }
//                     final posts = snapshot.data!;
//                     return ListView.builder(
//                       itemCount: posts.length,
//                       itemBuilder: (context, index) {
//                         return PostCard(post: posts[index], currentUserId: _currentUserProfile?.uid);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 2),
//     );
//   }
// }
// // lib/screens/chat_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/chat_message.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/gemini_api_service.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_text_field.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   UserProfile? _currentUserProfile;
//   late FirebaseService _firebaseService;
//   late GeminiApiService _geminiApiService;
//   bool _isGeneratingResponse = false;

//   @override
//   void initState() {
//     super.initState();
//     _firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     _geminiApiService = Provider.of<GeminiApiService>(context, listen: false);
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     final user = _firebaseService.currentUser;
//     if (user != null) {
//       final profile = await _firebaseService.getUserProfile(user.uid);
//       setState(() {
//         _currentUserProfile = profile;
//       });
//     }
//   }

//   void _sendMessage() async {
//     if (_messageController.text.trim().isEmpty || _currentUserProfile == null || _isGeneratingResponse) {
//       return;
//     }

//     final String messageText = _messageController.text.trim();
//     _messageController.clear();

//     final userMessage = ChatMessage(
//       id: _firebaseService.generateNewDocId(),
//       senderId: _currentUserProfile!.uid,
//       senderUsername: _currentUserProfile!.username,
//       senderAvatarUrl: _currentUserProfile!.avatarAssetPath,
//       text: messageText,
//       timestamp: DateTime.now(),
//       isUser: true,
//     );

//     await _firebaseService.sendChatMessage(userMessage);

//     setState(() {
//       _isGeneratingResponse = true;
//     });

//     try {
//       final chatHistorySnapshot = await _firebaseService.getFirestore()
//           .collection(AppConstants.chatMessagesCollection)
//           .orderBy('timestamp', descending: false)
//           .get();
//       final List<ChatMessage> currentChatHistory = chatHistorySnapshot.docs
//           .map((doc) => ChatMessage.fromMap(doc.data()))
//           .toList();

//       final String aiResponseText = await _geminiApiService.generateChatResponse(currentChatHistory);

//       final aiMessage = ChatMessage(
//         id: _firebaseService.generateNewDocId(),
//         senderId: 'ai_tutor',
//         senderUsername: 'AI Tutor',
//         senderAvatarUrl: 'assets/app_icon.png',
//         text: aiResponseText,
//         timestamp: DateTime.now(),
//         isUser: false,
//       );
//       await _firebaseService.sendChatMessage(aiMessage);
//     } catch (e) {
//       debugPrint('Error generating AI response: $e');
//       final errorMessage = ChatMessage(
//         id: _firebaseService.generateNewDocId(),
//         senderId: 'ai_tutor',
//         senderUsername: 'AI Tutor',
//         senderAvatarUrl: 'assets/app_icon.png',
//         text: 'Sorry, I am having trouble connecting right now. Please try again later.',
//         timestamp: DateTime.now(),
//         isUser: false,
//       );
//       await _firebaseService.sendChatMessage(errorMessage);
//     } finally {
//       setState(() {
//         _isGeneratingResponse = false;
//       });
//       _scrollToBottom();
//     }
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(title: 'AI Chat Tutor 🤖'),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: StreamBuilder<List<ChatMessage>>(
//                   stream: _firebaseService.streamChatMessages(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
//                     }
//                     if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
//                     }
//                     if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return const Center(
//                         child: Text(
//                           'Start a conversation with your AI tutor!',
//                           style: TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
//                           textAlign: TextAlign.center,
//                         ),
//                       );
//                     }

//                     final messages = snapshot.data!;
//                     _scrollToBottom();

//                     return ListView.builder(
//                       controller: _scrollController,
//                       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.padding / 2),
//                       itemCount: messages.length + (_isGeneratingResponse ? 1 : 0),
//                       itemBuilder: (context, index) {
//                         if (index == messages.length) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
//                                 decoration: BoxDecoration(
//                                   color: AppColors.cardColor,
//                                   borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                                 ),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Image.asset(
//                                       'assets/app_icon.png',
//                                       width: 24,
//                                       height: 24,
//                                     ),
//                                     const SizedBox(width: AppConstants.spacing),
//                                     const Text(
//                                       'AI Tutor is typing...',
//                                       style: TextStyle(color: AppColors.textColorSecondary),
//                                     ),
//                                     const SizedBox(width: AppConstants.spacing / 2),
//                                     const SizedBox(
//                                       width: 16,
//                                       height: 16,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         }

//                         final message = messages[index];
//                         final bool isMe = message.senderId == _currentUserProfile?.uid;

//                         return Align(
//                           alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//                             padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
//                             decoration: BoxDecoration(
//                               color: isMe ? AppColors.primaryColor.withOpacity(0.8) : AppColors.cardColor,
//                               borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                             ),
//                             constraints: BoxConstraints(
//                               maxWidth: MediaQuery.of(context).size.width * 0.75,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 12,
//                                       backgroundImage: AssetImage(message.senderAvatarUrl),
//                                       backgroundColor: AppColors.borderColor,
//                                     ),
//                                     const SizedBox(width: AppConstants.spacing),
//                                     Text(
//                                       message.senderUsername,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: isMe ? AppColors.textColor : AppColors.accentColor,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: AppConstants.spacing / 2),
//                                 Text(
//                                   message.text,
//                                   style: TextStyle(color: isMe ? AppColors.textColor : AppColors.textColorSecondary, fontSize: 16),
//                                 ),
//                                 const SizedBox(height: AppConstants.spacing / 2),
//                                 Align(
//                                   alignment: Alignment.bottomRight,
//                                   child: Text(
//                                     '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}',
//                                     style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 10),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(AppConstants.padding),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: CustomTextField(
//                         controller: _messageController,
//                         labelText: 'Type your message...',
//                         icon: Icons.message,
//                         keyboardType: TextInputType.text,
//                         onSubmitted: (value) => _sendMessage(),
//                       ),
//                     ),
//                     const SizedBox(width: AppConstants.spacing),
//                     Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColors.primaryColor.withOpacity(0.4),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: IconButton(
//                         icon: _isGeneratingResponse
//                             ? const CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(AppColors.textColor),
//                               )
//                             : const Icon(Icons.send, color: AppColors.textColor),
//                         onPressed: _isGeneratingResponse ? null : _sendMessage,
//                         padding: const EdgeInsets.all(AppConstants.spacing * 1.5),
//                         splashRadius: 24,
//                         tooltip: 'Send Message',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 3),
//     );
//   }
// }
// // lib/screens/avatar_customizer_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/avatar_asset.dart';
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
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       final currentUser = firebaseService.currentUser;
//       if (currentUser != null) {
//         final profile = await firebaseService.getUserProfile(currentUser.uid);
//         setState(() {
//           _userProfile = profile;
//           _selectedAvatarPath = profile?.avatarAssetPath;
//         });
//       } else {
//         setState(() {
//           _errorMessage = 'User not logged in.';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to load user profile: ${e.toString()}';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _onAvatarSelected(AvatarAsset avatar) {
//     setState(() {
//       _selectedAvatarPath = avatar.assetPath;
//     });
//   }

//   Future<void> _saveAvatar() async {
//     if (_userProfile == null || _selectedAvatarPath == null) {
//       setState(() {
//         _errorMessage = 'No avatar selected or user profile not loaded.';
//       });
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       await firebaseService.updateUserProfile(
//         _userProfile!.uid,
//         {'avatarAssetPath': _selectedAvatarPath},
//       );
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Avatar updated successfully!')),
//         );
//         Navigator.of(context).pop();
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to save avatar: ${e.toString()}';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(title: 'Customize Avatar'),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: _isLoading
//               ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//               : _errorMessage != null
//                   ? Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(AppConstants.padding),
//                         child: Text(
//                           _errorMessage!,
//                           style: const TextStyle(color: AppColors.errorColor),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     )
//                   : Column(
//                       children: [
//                         Expanded(
//                           child: AvatarCustomizer(
//                             selectedAvatarPath: _selectedAvatarPath,
//                             onAvatarSelected: _onAvatarSelected,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(AppConstants.padding),
//                           child: CustomButton(
//                             onPressed: _saveAvatar,
//                             text: 'Save Avatar',
//                             icon: Icons.save,
//                             isLoading: _isLoading,
//                           ),
//                         ),
//                       ],
//                     ),
//         ),
//       ),
//     );
//   }
// }
// // lib/screens/auth_screen.dart
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/utils/validation_utils.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/custom_text_field.dart';
// import 'package:provider/provider.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   String? _educationLevel;
//   String? _specialty;
//   String? _language; // New field

//   bool _isLogin = true;
//   bool _isLoading = false;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _educationLevel = AppConstants.educationLevels.first; // Initialize
//     _specialty = AppConstants.defaultCourseTopics.first; // Initialize
//     _language = AppConstants.supportedLanguages.first; // Initialize new field
//   }

//   Future<void> _submitAuthForm() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       if (_isLogin) {
//         await firebaseService.signInWithEmailAndPassword(
//           _emailController.text.trim(),
//           _passwordController.text.trim(),
//         );
//         if (mounted) {
//           // After successful login, check if profile is complete.
//           // This ensures existing users created before these fields were added go to onboarding.
//           final userProfile = await firebaseService.getUserProfile(firebaseService.currentUser!.uid);
//           if (userProfile == null || userProfile.username.isEmpty || userProfile.educationLevel == null || userProfile.specialty == null || userProfile.language == null) {
//             Navigator.of(context).pushReplacementNamed(AppRouter.onboardingRoute);
//           } else {
//             Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//           }
//         }
//       } else {
//         await firebaseService.registerWithEmailAndPassword(
//           _emailController.text.trim(),
//           _passwordController.text.trim(),
//           _usernameController.text.trim(),
//           educationLevel: _educationLevel, // Pass new fields
//           specialty: _specialty, // Pass new fields
//           language: _language, // Pass new field
//         );
//         if (mounted) {
//           // New users go directly to home if profile complete upon registration.
//           Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _errorMessage = e.message;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'An unexpected error occurred: ${e.toString()}';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Widget _buildDropdownField({
//     required String label,
//     required String value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//     required IconData icon,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
//       decoration: BoxDecoration(
//         color: AppColors.cardColor.withOpacity(0.7),
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//         border: Border.all(color: AppColors.borderColor, width: 1),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           isExpanded: true,
//           dropdownColor: AppColors.cardColor,
//           icon: Icon(Icons.arrow_drop_down, color: AppColors.textColorSecondary),
//           style: const TextStyle(color: AppColors.textColor, fontSize: 16),
//           onChanged: onChanged,
//           items: items.map<DropdownMenuItem<String>>((String itemValue) {
//             return DropdownMenuItem<String>(
//               value: itemValue,
//               child: Row(
//                 children: [
//                   Icon(icon, color: AppColors.textColorSecondary, size: 20),
//                   SizedBox(width: AppConstants.spacing),
//                   Text(itemValue),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _usernameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
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
//                   Text(
//                     _isLogin ? 'Welcome Back!' : 'Join Gamifier!',
//                     style: AppColors.neonTextStyle(fontSize: 32),
//                   ),
//                   const SizedBox(height: AppConstants.spacing * 4),
//                   if (!_isLogin) ...[
//                     CustomTextField(
//                       controller: _usernameController,
//                       labelText: 'Username',
//                       icon: Icons.person,
//                       validator: ValidationUtils.validateUsername,
//                       keyboardType: TextInputType.text,
//                     ),
//                     const SizedBox(height: AppConstants.spacing * 2),
//                     _buildDropdownField(
//                       label: 'Education Level',
//                       value: _educationLevel!,
//                       items: AppConstants.educationLevels,
//                       onChanged: (value) {
//                         setState(() {
//                           _educationLevel = value;
//                         });
//                       },
//                       icon: Icons.school,
//                     ),
//                     const SizedBox(height: AppConstants.spacing * 2),
//                     _buildDropdownField(
//                       label: 'Specialty (e.g., "AI", "Web Dev")',
//                       value: _specialty!,
//                       items: AppConstants.defaultCourseTopics,
//                       onChanged: (value) {
//                         setState(() {
//                           _specialty = value;
//                         });
//                       },
//                       icon: Icons.star,
//                     ),
//                     const SizedBox(height: AppConstants.spacing * 2),
//                     _buildDropdownField( // New language dropdown
//                       label: 'Preferred Language',
//                       value: _language!,
//                       items: AppConstants.supportedLanguages,
//                       onChanged: (value) {
//                         setState(() {
//                           _language = value;
//                         });
//                       },
//                       icon: Icons.language,
//                     ),
//                     const SizedBox(height: AppConstants.spacing * 2),
//                   ],
//                   CustomTextField(
//                     controller: _emailController,
//                     labelText: 'Email',
//                     icon: Icons.email,
//                     validator: ValidationUtils.validateEmail,
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   const SizedBox(height: AppConstants.spacing * 2),
//                   CustomTextField(
//                     controller: _passwordController,
//                     labelText: 'Password',
//                     icon: Icons.lock,
//                     validator: ValidationUtils.validatePassword,
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: AppConstants.spacing * 4),
//                   if (_errorMessage != null)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: AppConstants.spacing * 2),
//                       child: Text(
//                         _errorMessage!,
//                         style: const TextStyle(color: AppColors.errorColor, fontSize: 14),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   _isLoading
//                       ? const CircularProgressIndicator(color: AppColors.accentColor)
//                       : CustomButton(
//                           onPressed: _submitAuthForm,
//                           text: _isLogin ? 'Login' : 'Register',
//                           icon: _isLogin ? Icons.login : Icons.app_registration,
//                         ),
//                   const SizedBox(height: AppConstants.spacing * 2),
//                   TextButton(
//                     onPressed: () {
//                       setState(() {
//                         _isLogin = !_isLogin;
//                         _errorMessage = null;
//                         // Reset dropdowns to first value when toggling form type
//                         _educationLevel = AppConstants.educationLevels.first;
//                         _specialty = AppConstants.defaultCourseTopics.first;
//                         _language = AppConstants.supportedLanguages.first; // Reset language
//                       });
//                     },
//                     child: Text(
//                       _isLogin
//                           ? 'Don\'t have an account? Register'
//                           : 'Already have an account? Login',
//                       style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
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
//   final String id;
//   final String userId;
//   final String courseId;
//   final String? currentLevelId;
//   final String? currentLessonId;
//   final Map<String, LevelProgress> levelsProgress;
//   final Map<String, LessonProgress> lessonsProgress;

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
//   final Map<String, QuestionAttempt> questionAttempts;
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
// import 'package:flutter/foundation.dart';
// import 'package:gamifier/models/badge.dart'; // Ensure Badge is imported if used directly here, though typically its ID is stored

// @immutable
// class UserProfile {
//   final String uid;
//   final String username;
//   final String email;
//   final String avatarAssetPath;
//   final int xp;
//   final int level;
//   final DateTime createdAt;
//   final DateTime? lastLoginDate;
//   final int currentStreak;
//   final List<String> earnedBadges;
//   final List<String> friends;
//   final String? educationLevel; // Made nullable for flexibility if not set
//   final String? specialty;      // Made nullable for flexibility if not set
//   final String? language;       // New: User's preferred language

//   const UserProfile({
//     required this.uid,
//     required this.username,
//     required this.email,
//     required this.avatarAssetPath,
//     required this.xp,
//     required this.level,
//     required this.createdAt,
//     this.lastLoginDate,
//     required this.currentStreak,
//     required this.earnedBadges,
//     required this.friends,
//     this.educationLevel,
//     this.specialty,
//     this.language, // Initialize new field
//   });

//   factory UserProfile.fromMap(Map<String, dynamic> map) {
//     return UserProfile(
//       uid: map['uid'] as String,
//       username: map['username'] as String,
//       email: map['email'] as String,
//       avatarAssetPath: map['avatarAssetPath'] as String,
//       xp: map['xp'] as int,
//       level: map['level'] as int,
//       createdAt: (map['createdAt'] as Timestamp).toDate(),
//       lastLoginDate: (map['lastLoginDate'] as Timestamp?)?.toDate(),
//       currentStreak: map['currentStreak'] as int,
//       earnedBadges: List<String>.from(map['earnedBadges'] ?? []),
//       friends: List<String>.from(map['friends'] ?? []),
//       educationLevel: map['educationLevel'] as String?,
//       specialty: map['specialty'] as String?,
//       language: map['language'] as String?, // Read the new field
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'username': username,
//       'email': email,
//       'avatarAssetPath': avatarAssetPath,
//       'xp': xp,
//       'level': level,
//       'createdAt': Timestamp.fromDate(createdAt),
//       'lastLoginDate': lastLoginDate != null ? Timestamp.fromDate(lastLoginDate!) : null,
//       'currentStreak': currentStreak,
//       'earnedBadges': earnedBadges,
//       'friends': friends,
//       'educationLevel': educationLevel,
//       'specialty': specialty,
//       'language': language, // Include the new field
//     };
//   }

//   UserProfile copyWith({
//     String? uid,
//     String? username,
//     String? email,
//     String? avatarAssetPath,
//     int? xp,
//     int? level,
//     DateTime? createdAt,
//     DateTime? lastLoginDate,
//     int? currentStreak,
//     List<String>? earnedBadges,
//     List<String>? friends,
//     String? educationLevel,
//     String? specialty,
//     String? language, // Update copyWith
//   }) {
//     return UserProfile(
//       uid: uid ?? this.uid,
//       username: username ?? this.username,
//       email: email ?? this.email,
//       avatarAssetPath: avatarAssetPath ?? this.avatarAssetPath,
//       xp: xp ?? this.xp,
//       level: level ?? this.level,
//       createdAt: createdAt ?? this.createdAt,
//       lastLoginDate: lastLoginDate ?? this.lastLoginDate,
//       currentStreak: currentStreak ?? this.currentStreak,
//       earnedBadges: earnedBadges ?? this.earnedBadges,
//       friends: friends ?? this.friends,
//       educationLevel: educationLevel ?? this.educationLevel,
//       specialty: specialty ?? this.specialty,
//       language: language ?? this.language, // Copy the new field
//     );
//   }

//   @override
//   String toString() {
//     return 'UserProfile(uid: $uid, username: $username, email: $email, avatarAssetPath: $avatarAssetPath, xp: $xp, level: $level, createdAt: $createdAt, lastLoginDate: $lastLoginDate, currentStreak: $currentStreak, earnedBadges: $earnedBadges, friends: $friends, educationLevel: $educationLevel, specialty: $specialty, language: $language)';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is UserProfile &&
//           runtimeType == other.runtimeType &&
//           uid == other.uid &&
//           username == other.username &&
//           email == other.email &&
//           avatarAssetPath == other.avatarAssetPath &&
//           xp == other.xp &&
//           level == other.level &&
//           createdAt == other.createdAt &&
//           lastLoginDate == other.lastLoginDate &&
//           currentStreak == other.currentStreak &&
//           listEquals(earnedBadges, other.earnedBadges) &&
//           listEquals(friends, other.friends) &&
//           educationLevel == other.educationLevel &&
//           specialty == other.specialty &&
//           language == other.language; // Compare new field

//   @override
//   int get hashCode =>
//       uid.hashCode ^
//       username.hashCode ^
//       email.hashCode ^
//       avatarAssetPath.hashCode ^
//       xp.hashCode ^
//       level.hashCode ^
//       createdAt.hashCode ^
//       (lastLoginDate?.hashCode ?? 0) ^
//       currentStreak.hashCode ^
//       listEquals(earnedBadges, earnedBadges).hashCode ^
//       listEquals(friends, friends).hashCode ^
//       (educationLevel?.hashCode ?? 0) ^
//       (specialty?.hashCode ?? 0) ^
//       (language?.hashCode ?? 0); // Include new field in hash code
// }
// // lib/models/question.dart
// class Question {
//   final String id;
//   final String questionText;
//   final String type;
//   final int xpReward; // Ensure this is always an int

//   final List<String>? options;
//   final String? correctAnswer;
//   final String? expectedAnswerKeywords;
//   final String? scenarioText;
//   final String? expectedOutcome;

//   Question({
//     required this.id,
//     required this.questionText,
//     required this.type,
//     this.xpReward = 0, // Default to 0 if not provided, to prevent null -> int cast issues
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
//       xpReward: map['xpReward'] as int? ?? 0, // Safely cast and default to 0
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
// }) {
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
// import 'package:flutter/material.dart';

// class Level {
//   final String id;
//   final String title;
//   final String description;
//   String courseId;
//   final String difficulty;
//   final int order;
//   final String? imageAssetPath;

//   Level({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.courseId,
//     required this.difficulty,
//     this.order = 0, // Default to 0 to prevent null -> int error
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
//       courseId: map['courseId'] as String? ?? '',
//       difficulty: map['difficulty'] as String,
//       order: map['order'] as int? ?? 0, // Safely cast and default to 0
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
// // lib/models/level.dart
// import 'package:flutter/material.dart';

// class Level {
//   final String id;
//   final String title;
//   final String description;
//   String courseId;
//   final String difficulty;
//   final int order;
//   final String? imageAssetPath;

//   Level({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.courseId,
//     required this.difficulty,
//     this.order = 0, // Default to 0 to prevent null -> int error
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
//       courseId: map['courseId'] as String? ?? '',
//       difficulty: map['difficulty'] as String,
//       order: map['order'] as int? ?? 0, // Safely cast and default to 0
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
// import 'package:gamifier/models/question.dart';

// class Lesson {
//   final String id;
//   final String title;
//   final String content;
//   String levelId;
//   final int order;
//   final List<Question> questions;

//   Lesson({
//     required this.id,
//     required this.title,
//     required this.content,
//     required this.levelId,
//     this.order = 0, // Default to 0 to prevent null -> int error
//     this.questions = const [],
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'content': content,
//       'levelId': levelId,
//       'order': order,
//       'questions': questions.map((q) => q.toMap()).toList(),
//     };
//   }

//   factory Lesson.fromMap(Map<String, dynamic> map) {
//     return Lesson(
//       id: map['id'] as String,
//       title: map['title'] as String,
//       content: map['content'] as String,
//       levelId: map['levelId'] as String? ?? '',
//       order: map['order'] as int? ?? 0, // Safely cast and default to 0
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

// @immutable
// class Course {
//   final String id;
//   final String title;
//   final String description;
//   final String? gameGenre; // Made nullable as it's being replaced by language
//   final String language; // New field for course language
//   final String difficulty;
//   final String creatorId;
//   final DateTime createdAt;
//   final List<String> levelIds;
//   final String? educationLevel;
//   final String? specialty;

//   const Course({
//     required this.id,
//     required this.title,
//     required this.description,
//     this.gameGenre, // Now optional
//     required this.language, // Now required
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
//       gameGenre: map['gameGenre'] as String?, // Read as nullable
//       language: map['language'] as String? ?? 'English', // New field, default to English
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
//       'language': language, // Include in map
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
//     String? language, // Update copyWith
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
//       language: language ?? this.language, // Copy language
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
//     return 'Course(id: $id, title: $title, description: $description, gameGenre: $gameGenre, language: $language, difficulty: $difficulty, creatorId: $creatorId, createdAt: $createdAt, levelIds: $levelIds, educationLevel: $educationLevel, specialty: $specialty)';
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
//           language == other.language && // Compare language
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
//       (gameGenre?.hashCode ?? 0) ^ // Update hash code
//       language.hashCode ^ // Add language to hash code
//       difficulty.hashCode ^
//       creatorId.hashCode ^
//       createdAt.hashCode ^
//       listEquals(levelIds, levelIds).hashCode ^
//       (educationLevel?.hashCode ?? 0) ^
//       (specialty?.hashCode ?? 0);
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
//   final IconData icon;
//   final String imageUrl;

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
//   static const int initialXp = 0;
//   static const int xpPerLevel = 100;
//   static const int leaderboardLimit = 10;
//   static const int minStreakDaysForBonus = 3;
//   static const int streakBonusXp = 20;

//   // Course Generation Constants
//   static const int initialLevelsCount = 5; // Generate first 5 levels
//   static const int subsequentLevelsBatchSize = 5; // Generate 5 more levels at a time
//   static const int maxLevelsPerCourse = 15; // Max total levels

//   // UI specific constants
//   static const double levelSelectionGenerateButtonHeight = 150.0; // Added for LevelSelectionScreen height calculation

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

//   // Added supportedLanguages for course creation
//   static const List<String> supportedLanguages = [
//     'English',
//     'Hindi',
//     'Marathi',
//     'Bengali',
//     'Telugu',
//     'Nepali',
//     'Punjabi',
//     'Arabic',
//     'Portuguese',
//     'Russian',
//   ];

//   // Removed gameThemes as it's no longer used for new course generation.
//   // static const List<String> gameThemes = [...]; // This line is removed

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
//     'Not Specified', // Added for flexibility
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
//     'Data Structures & Algorithms',
//     'Operating Systems',
//     'Computer Networks',
//     'Software Engineering Principles',
//     'Product Management',
//     'Financial Literacy',
//     'Personal Development',
//     'Communication Skills',
//     'Critical Thinking',
//     'Problem Solving',
//     'Creative Writing',
//     'History',
//     'Philosophy',
//     'Economics',
//     'Biology',
//     'Chemistry',
//     'Physics',
//     'Mathematics',
//     'Art History',
//     'Music Theory',
//   ];
//   // Keeping gameThemes for existing Course model data and potential future use,
//   // but it will no longer be used in the CourseCreationScreen.
//   static const List<String> gameThemes = [
//     'Fantasy',
//     'Sci-Fi',
//     'Adventure',
//     'Mystery',
//     'Cyberpunk',
//   ];
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
//   static const Color streakColor = Color(0xFFFD8C00);
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