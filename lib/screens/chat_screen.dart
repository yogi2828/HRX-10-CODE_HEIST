
// lib/screens/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:gamifier/widgets/navigation/top_nav_bar.dart'; // Changed to TopNavBar
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/chat_message.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/services/gemini_api_service.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/widgets/common/custom_text_field.dart';
import 'package:gamifier/widgets/common/night_sky_background.dart'; // Import NightSkyBackground

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  UserProfile? _currentUserProfile;
  late FirebaseService _firebaseService;
  late GeminiApiService _geminiApiService;
  bool _isGeneratingResponse = false;

  @override
  void initState() {
    super.initState();
    _firebaseService = Provider.of<FirebaseService>(context, listen: false);
    _geminiApiService = Provider.of<GeminiApiService>(context, listen: false);
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = _firebaseService.currentUser;
    if (user != null) {
      final profile = await _firebaseService.getUserProfile(user.uid);
      setState(() {
        _currentUserProfile = profile;
      });
    }
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty || _currentUserProfile == null || _isGeneratingResponse) {
      return;
    }

    final String messageText = _messageController.text.trim();
    _messageController.clear();

    final userMessage = ChatMessage(
      id: _firebaseService.generateNewDocId(),
      senderId: _currentUserProfile!.uid,
      senderUsername: _currentUserProfile!.username,
      senderAvatarUrl: _currentUserProfile!.avatarAssetPath,
      text: messageText,
      timestamp: DateTime.now(),
      isUser: true,
    );

    await _firebaseService.sendChatMessage(userMessage);

    setState(() {
      _isGeneratingResponse = true;
    });

    try {
      final chatHistorySnapshot = await _firebaseService.getFirestore()
          .collection(AppConstants.chatMessagesCollection)
          .orderBy('timestamp', descending: false)
          .get();
      final List<ChatMessage> currentChatHistory = chatHistorySnapshot.docs
          .map((doc) => ChatMessage.fromMap(doc.data()))
          .toList();

      final String aiResponseText = await _geminiApiService.generateChatResponse(currentChatHistory);

      final aiMessage = ChatMessage(
        id: _firebaseService.generateNewDocId(),
        senderId: 'ai_tutor',
        senderUsername: 'AI Tutor',
        senderAvatarUrl: 'assets/app_icon.png',
        text: aiResponseText,
        timestamp: DateTime.now(),
        isUser: false,
      );
      await _firebaseService.sendChatMessage(aiMessage);
    } catch (e) {
      debugPrint('Error generating AI response: $e');
      final errorMessage = ChatMessage(
        id: _firebaseService.generateNewDocId(),
        senderId: 'ai_tutor',
        senderUsername: 'AI Tutor',
        senderAvatarUrl: 'assets/app_icon.png',
        text: 'Sorry, I am having trouble connecting right now. Please try again later.',
        timestamp: DateTime.now(),
        isUser: false,
      );
      await _firebaseService.sendChatMessage(errorMessage);
    } finally {
      setState(() {
        _isGeneratingResponse = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TopNavBar( // Replaced CustomAppBar
        currentIndex: 3,
        title: 'AI Chat Tutor 🤖',
      ),
      body: NightSkyBackground( // Wrap content with NightSkyBackground
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<ChatMessage>>(
                  stream: _firebaseService.streamChatMessages(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          'Start a conversation with your AI tutor!',
                          style: TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    final messages = snapshot.data!;
                    _scrollToBottom();

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.padding / 2),
                      itemCount: messages.length + (_isGeneratingResponse ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
                                decoration: BoxDecoration(
                                  color: AppColors.cardColor,
                                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      AppConstants.appIconPath, // Use app icon for AI tutor
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: AppConstants.spacing),
                                    const Text(
                                      'AI Tutor is typing...',
                                      style: TextStyle(color: AppColors.textColorSecondary),
                                    ),
                                    const SizedBox(width: AppConstants.spacing / 2),
                                    const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        final message = messages[index];
                        final bool isMe = message.senderId == _currentUserProfile?.uid;

                        return Align(
                          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
                            padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
                            decoration: BoxDecoration(
                              color: isMe ? AppColors.primaryColor.withOpacity(0.8) : AppColors.cardColor,
                              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                            ),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.75,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(message.senderAvatarUrl),
                                      backgroundColor: AppColors.borderColor,
                                    ),
                                    const SizedBox(width: AppConstants.spacing),
                                    Text(
                                      message.senderUsername,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isMe ? AppColors.textColor : AppColors.accentColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppConstants.spacing / 2),
                                Text(
                                  message.text,
                                  style: TextStyle(color: isMe ? AppColors.textColor : AppColors.textColorSecondary, fontSize: 16),
                                ),
                                const SizedBox(height: AppConstants.spacing / 2),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                                    style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppConstants.padding),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _messageController,
                        labelText: 'Type your message...',
                        icon: Icons.message,
                        keyboardType: TextInputType.text,
                        onSubmitted: (value) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacing),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primaryColor, AppColors.secondaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: _isGeneratingResponse
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.textColor),
                              )
                            : const Icon(Icons.send, color: AppColors.textColor),
                        onPressed: _isGeneratingResponse ? null : _sendMessage,
                        padding: const EdgeInsets.all(AppConstants.spacing * 1.5),
                        splashRadius: 24,
                        tooltip: 'Send Message',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}