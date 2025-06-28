// lib/widgets/community/post_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/community_post.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/widgets/common/custom_text_field.dart';

class PostCard extends StatefulWidget {
  final CommunityPost post;
  final String? currentUserId;

  const PostCard({
    super.key,
    required this.post,
    this.currentUserId,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final TextEditingController _commentController = TextEditingController();
  bool _showComments = false;
  bool _isLoadingComment = false;

  Future<void> _toggleLike() async {
    if (widget.currentUserId == null) return;
    try {
      await Provider.of<FirebaseService>(context, listen: false)
          .toggleLikeOnPost(widget.post.id, widget.currentUserId!);
    } catch (e) {
      debugPrint('Error toggling like: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to like/unlike post: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _addComment() async {
    if (_commentController.text.trim().isEmpty || widget.currentUserId == null) return;

    setState(() {
      _isLoadingComment = true;
    });

    try {
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      final currentUserProfile = await firebaseService.getUserProfile(widget.currentUserId!);

      if (currentUserProfile == null) {
        throw Exception('User profile not found.');
      }

      final newComment = Comment(
        id: firebaseService.generateNewDocId(),
        userId: currentUserProfile.uid,
        username: currentUserProfile.username,
        avatarUrl: currentUserProfile.avatarAssetPath,
        text: _commentController.text.trim(),
        timestamp: DateTime.now(),
      );
      await firebaseService.addCommentToPost(widget.post.id, newComment);
      _commentController.clear();
    } catch (e) {
      debugPrint('Error adding comment: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add comment: ${e.toString()}')),
        );
      }
    } finally {
      setState(() {
        _isLoadingComment = false;
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLiked = widget.post.likedBy.contains(widget.currentUserId);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
      color: AppColors.cardColor.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(widget.post.authorAvatarUrl),
                  backgroundColor: AppColors.borderColor,
                ),
                const SizedBox(width: AppConstants.spacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.authorUsername,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${widget.post.timestamp.day}/${widget.post.timestamp.month}/${widget.post.timestamp.year} at ${widget.post.timestamp.hour}:${widget.post.timestamp.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacing),
            Text(
              widget.post.content,
              style: const TextStyle(color: AppColors.textColor, fontSize: 15),
            ),
            if (widget.post.imageUrl != null && widget.post.imageUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  child: Image.network(
                    widget.post.imageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.borderColor,
                      height: 200,
                      child: const Center(
                        child: Icon(Icons.broken_image, color: AppColors.textColorSecondary),
                      ),
                    ),
                  ),
                ),
              ),
            const Divider(color: AppColors.borderColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: widget.currentUserId != null ? _toggleLike : null,
                  child: Row(
                    children: [
                      Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? AppColors.errorColor : AppColors.textColorSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: AppConstants.spacing / 2),
                      Text(
                        '${widget.post.likedBy.length}',
                        style: TextStyle(color: isLiked ? AppColors.errorColor : AppColors.textColorSecondary),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showComments = !_showComments;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.comment_outlined, color: AppColors.textColorSecondary, size: 20),
                      const SizedBox(width: AppConstants.spacing / 2),
                      Text(
                        '${widget.post.comments.length}',
                        style: const TextStyle(color: AppColors.textColorSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_showComments)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(color: AppColors.borderColor),
                  ...widget.post.comments.map((comment) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundImage: AssetImage(comment.avatarUrl),
                              backgroundColor: AppColors.borderColor,
                            ),
                            const SizedBox(width: AppConstants.spacing),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.username,
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor, fontSize: 13),
                                  ),
                                  Text(
                                    comment.text,
                                    style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: AppConstants.spacing),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _commentController,
                          labelText: 'Add a comment...',
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: AppConstants.spacing),
                      _isLoadingComment
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accentColor),
                            )
                          : IconButton(
                              icon: const Icon(Icons.send, color: AppColors.accentColor),
                              onPressed: _addComment,
                            ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}