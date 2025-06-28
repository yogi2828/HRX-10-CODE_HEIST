// lib/screens/community_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/community_post.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/common/loading_indicator.dart';
import 'package:uuid/uuid.dart';
import 'package:share_plus/share_plus.dart'; // New: For content sharing

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _postController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  UserProfile? _currentUserProfile;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final user = firebaseService.currentUser;
    if (user != null) {
      firebaseService.streamUserProfile(user.uid).listen((profile) {
        if (mounted) {
          setState(() {
            _currentUserProfile = profile;
          });
        }
      });
    }
  }

  void _createPost() async {
    if (_postController.text.isEmpty || _currentUserProfile == null) return;

    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final newPost = CommunityPost(
      id: const Uuid().v4(),
      userId: _currentUserProfile!.uid,
      username: _currentUserProfile!.username,
      avatarAssetPath: _currentUserProfile!.avatarAssetPath,
      content: _postController.text.trim(),
      timestamp: DateTime.now(),
    );

    await firebaseService.addCommunityPost(newPost);
    _postController.clear();
    _scrollController.animateTo(
      0.0,
      duration: AppConstants.defaultAnimationDuration,
      curve: Curves.easeOut,
    );
  }

  void _toggleLike(CommunityPost post) async {
    if (_currentUserProfile == null) return;

    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    if (post.likedBy.contains(_currentUserProfile!.uid)) {
      await firebaseService.unlikeCommunityPost(post.id, _currentUserProfile!.uid);
    } else {
      await firebaseService.likeCommunityPost(post.id, _currentUserProfile!.uid);
      // Award XP for liking posts, as part of a daily mission, for example
      // This could be integrated with the DailyMission completion logic
    }
  }

  void _addComment(CommunityPost post, String commentContent) async {
    if (_currentUserProfile == null || commentContent.isEmpty) return;

    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final newComment = Comment(
      userId: _currentUserProfile!.uid,
      username: _currentUserProfile!.username,
      avatarAssetPath: _currentUserProfile!.avatarAssetPath,
      content: commentContent,
      timestamp: DateTime.now(),
    );

    await firebaseService.addCommentToPost(post.id, newComment);
  }

  void _sharePost(CommunityPost post) async {
    await Share.share('Check out this post from Gamifier by ${post.username}: "${post.content}"');
  }

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context);

    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: const CustomAppBar(title: 'Community Feed'),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppConstants.padding),
              child: Card(
                color: AppColors.cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.padding),
                  child: Column(
                    children: [
                      TextField(
                        controller: _postController,
                        decoration: InputDecoration(
                          hintText: 'Share your thoughts or achievements...',
                          contentPadding: const EdgeInsets.all(AppConstants.padding),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: AppColors.secondaryColor.withOpacity(0.3),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: AppConstants.spacing),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: _createPost,
                          icon: const Icon(Icons.send),
                          label: const Text('Post'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<CommunityPost>>(
                stream: firebaseService.streamCommunityPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingIndicator();
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
                    controller: _scrollController,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      final bool isLiked = _currentUserProfile?.uid != null && post.likedBy.contains(_currentUserProfile!.uid);

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: AppConstants.spacing, horizontal: AppConstants.padding),
                        color: AppColors.cardColor.withOpacity(0.9),
                        child: Padding(
                          padding: const EdgeInsets.all(AppConstants.padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(post.avatarAssetPath),
                                    radius: 20,
                                  ),
                                  const SizedBox(width: AppConstants.spacing),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.username,
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${post.timestamp.toLocal().hour}:${post.timestamp.toLocal().minute} - ${post.timestamp.toLocal().day}/${post.timestamp.toLocal().month}',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.textColorSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppConstants.padding),
                              Text(
                                post.content,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColor),
                              ),
                              const Divider(color: AppColors.borderColor, height: AppConstants.padding * 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          isLiked ? Icons.favorite : Icons.favorite_border,
                                          color: isLiked ? AppColors.accentColor : AppColors.textColorSecondary,
                                        ),
                                        onPressed: () => _toggleLike(post),
                                      ),
                                      Text(
                                        '${post.likedBy.length}',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColorSecondary),
                                      ),
                                      const SizedBox(width: AppConstants.padding),
                                      IconButton(
                                        icon: const Icon(Icons.comment, color: AppColors.textColorSecondary),
                                        onPressed: () => _showCommentDialog(post),
                                      ),
                                      Text(
                                        '${post.comments.length}',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColorSecondary),
                                      ),
                                    ],
                                  ),
                                  TextButton.icon(
                                    onPressed: () => _sharePost(post), // Changed to call _sharePost
                                    icon: const Icon(Icons.share, color: AppColors.textColorSecondary),
                                    label: Text(
                                      'Share',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColorSecondary),
                                    ),
                                  ),
                                ],
                              ),
                              if (post.comments.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: AppConstants.spacing),
                                    Text(
                                      'Comments:',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.textColor),
                                    ),
                                    ...post.comments.map((comment) =>
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: AssetImage(comment.avatarAssetPath),
                                                radius: 12,
                                              ),
                                              const SizedBox(width: AppConstants.spacing),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      comment.username,
                                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                        color: AppColors.accentColor,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      comment.content,
                                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColorSecondary),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
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
          ],
        ),
      ),
    );
  }

  void _showCommentDialog(CommunityPost post) {
    final TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a Comment'),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(
              hintText: 'Write your comment here...',
              filled: true,
              fillColor: AppColors.secondaryColor.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                borderSide: BorderSide.none,
              ),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel', style: TextStyle(color: AppColors.accentColor)),
            ),
            ElevatedButton(
              onPressed: () {
                _addComment(post, commentController.text.trim());
                Navigator.of(context).pop();
              },
              child: const Text('Comment'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _postController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
