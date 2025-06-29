// lib/screens/community_screen.dart
import 'package:flutter/material.dart';
import 'package:gamifier/widgets/navigation/top_nav_bar.dart'; // Changed to TopNavBar
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/community_post.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/widgets/common/custom_button.dart';
import 'package:gamifier/widgets/common/custom_text_field.dart';
import 'package:gamifier/widgets/community/post_card.dart';
import 'package:gamifier/widgets/common/night_sky_background.dart'; // Import NightSkyBackground

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _postController = TextEditingController();
  UserProfile? _currentUserProfile;
  bool _isLoadingPost = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final user = firebaseService.currentUser;
    if (user != null) {
      final profile = await firebaseService.getUserProfile(user.uid);
      setState(() {
        _currentUserProfile = profile;
      });
    }
  }

  Future<void> _createPost() async {
    if (_postController.text.trim().isEmpty || _currentUserProfile == null) {
      return;
    }

    setState(() {
      _isLoadingPost = true;
    });

    try {
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      final newPost = CommunityPost(
        id: firebaseService.generateNewDocId(),
        authorId: _currentUserProfile!.uid,
        authorUsername: _currentUserProfile!.username,
        authorAvatarUrl: _currentUserProfile!.avatarAssetPath,
        content: _postController.text.trim(),
        timestamp: DateTime.now(),
      );
      await firebaseService.createCommunityPost(newPost);
      _postController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post created successfully!')),
        );
      }
    } catch (e) {
      debugPrint('Error creating post: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create post: ${e.toString()}')),
        );
      }
    } finally {
      setState(() {
        _isLoadingPost = false;
      });
    }
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TopNavBar( // Replaced CustomAppBar
        currentIndex: 2,
        title: 'Community Feed',
      ),
      body: NightSkyBackground( // Wrap content with NightSkyBackground
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppConstants.padding),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _postController,
                      labelText: 'Share your thoughts or achievements!',
                      icon: Icons.edit,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: AppConstants.spacing),
                    CustomButton(
                      onPressed: _isLoadingPost ? null : _createPost,
                      text: 'Create Post',
                      icon: Icons.send,
                      isLoading: _isLoadingPost,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<List<CommunityPost>>(
                  stream: Provider.of<FirebaseService>(context).streamCommunityPosts(),
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
                          'No posts yet. Be the first to share!',
                          style: TextStyle(color: AppColors.textColorSecondary),
                        ),
                      );
                    }
                    final posts = snapshot.data!;
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return PostCard(post: posts[index], currentUserId: _currentUserProfile?.uid);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


