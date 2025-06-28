// lib/screens/ai_chat_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/services/gemini_api_service.dart';
import 'package:gamifier/services/firebase_service.dart'; // New: For user profile
import 'package:gamifier/models/user_profile.dart'; // New: For user profile
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/common/loading_indicator.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  UserProfile? _userProfile; // New

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final user = firebaseService.currentUser;
    if (user != null) {
      firebaseService.streamUserProfile(user.uid).listen((profile) {
        if (mounted) {
          setState(() {
            _userProfile = profile;
          });
        }
      });
    }
  }

  void _sendMessage() async {
    if (_textController.text.isEmpty) return;

    final message = _textController.text;
    _textController.clear();

    setState(() {
      _messages.add(ChatMessage(text: message, isUser: true));
      _isLoading = true;
    });

    try {
      final geminiApiService = Provider.of<GeminiApiService>(context, listen: false);
      final aiPersona = _userProfile?.aiPersona ?? 'Default'; // Get AI persona

      String aiResponse;
      if (aiPersona != 'Default') {
        aiResponse = await geminiApiService.getAIPersonaResponse(message, aiPersona);
      } else {
        aiResponse = await geminiApiService.generateText(message);
      }

      setState(() {
        _messages.add(ChatMessage(text: aiResponse, isUser: false));
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(text: 'Error: ${e.toString()}', isUser: false));
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: const CustomAppBar(title: 'AI Tutor Chat'),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(AppConstants.padding),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(AppConstants.padding),
                child: LoadingIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.padding),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Ask your AI tutor...',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.padding,
                            vertical: AppConstants.spacing * 1.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.cardColor.withOpacity(0.8),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacing),
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.buttonGradient(),
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: AppColors.textColor),
                      onPressed: _sendMessage,
                      padding: const EdgeInsets.all(AppConstants.padding),
                      tooltip: 'Send Message',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
        padding: const EdgeInsets.all(AppConstants.padding),
        decoration: BoxDecoration(
          color: isUser ? AppColors.accentColor : AppColors.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isUser ? AppConstants.borderRadius : 0),
            topRight: Radius.circular(isUser ? 0 : AppConstants.borderRadius),
            bottomLeft: const Radius.circular(AppConstants.borderRadius),
            bottomRight: const Radius.circular(AppConstants.borderRadius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? AppColors.textColor : AppColors.textColorSecondary,
            fontSize: AppConstants.mediumTextSize,
          ),
        ),
      ),
    );
  }
}
