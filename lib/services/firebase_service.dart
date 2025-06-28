// lib/services/firebase_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/models/course.dart';
import 'package:gamifier/models/user_progress.dart';
import 'package:gamifier/models/badge.dart';
import 'package:gamifier/models/level.dart';
import 'package:gamifier/models/community_post.dart';
import 'package:gamifier/models/chat_message.dart';
import 'package:gamifier/models/lesson.dart';
import 'package:gamifier/models/question.dart';
import 'package:gamifier/constants/app_constants.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore getFirestore() {
    return _firestore;
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  String generateNewDocId() {
    return _firestore.collection('dummy').doc().id;
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Ensure user profile and streak are handled after sign-in
      await _ensureUserProfileAndStreak(userCredential.user!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(code: 'user-not-found', message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw FirebaseAuthException(code: 'wrong-password', message: 'Wrong password provided.');
      }
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred during sign-in: $e');
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(
      String email,
      String password,
      String username, {
      String? educationLevel, // Added
      String? specialty, // Added
      String? language, // New: Language
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await createUserProfile(
          userCredential.user!.uid,
          username,
          email: email, // Also save email
          educationLevel: educationLevel, // Pass along
          specialty: specialty, // Pass along
          language: language, // Pass along new field
        );
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw FirebaseAuthException(code: 'weak-password', message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw FirebaseAuthException(code: 'email-already-in-use', message: 'An account already exists for that email.');
      }
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred during registration: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Error signing out: $e');
    }
  }

  Future<void> _ensureUserProfileAndStreak(User user) async {
    final userRef = _firestore.collection(AppConstants.usersCollection).doc(user.uid);
    final docSnapshot = await userRef.get();

    if (!docSnapshot.exists) {
      // If profile doesn't exist (e.g., old user or direct sign-in via custom token), create a basic one.
      // Onboarding screen will then prompt for more details.
      await createUserProfile(
        user.uid,
        user.displayName ?? 'New Learner',
        email: user.email,
        educationLevel: null, // Let onboarding set these if needed
        specialty: null,      // Let onboarding set these if needed
        language: null,       // Let onboarding set this if needed
      );
    } else {
      UserProfile userProfile = UserProfile.fromMap(docSnapshot.data()!);
      DateTime today = DateTime.now();
      DateTime? lastLogin = userProfile.lastLoginDate;

      DateTime todayNormalized = DateTime(today.year, today.month, today.day);
      DateTime? lastLoginNormalized = lastLogin != null ? DateTime(lastLogin.year, lastLogin.month, lastLogin.day) : null;

      int newStreak = userProfile.currentStreak;
      int xpToAdd = 0;

      // Logic for streak update
      if (lastLoginNormalized == null || todayNormalized.difference(lastLoginNormalized).inDays > 1) {
        // Streak broken or first login, reset to 1
        newStreak = 1;
        xpToAdd = 0; // No bonus on reset
      } else if (todayNormalized.difference(lastLoginNormalized).inDays == 1) {
        // Streak continued
        newStreak++;
        if (newStreak >= AppConstants.minStreakDaysForBonus) {
          xpToAdd = AppConstants.streakBonusXp;
        }
      } else {
        // Same day login, no change to streak or XP from streak bonus
        xpToAdd = 0;
      }

      Map<String, dynamic> updates = {
        'lastLoginDate': Timestamp.fromDate(today),
        'currentStreak': newStreak,
      };

      // Apply XP if earned from streak
      if (xpToAdd > 0) {
        updates['xp'] = FieldValue.increment(xpToAdd);
      }
      await userRef.update(updates);

      // Re-fetch profile to get updated XP for level calculation
      UserProfile updatedProfile = UserProfile.fromMap((await userRef.get()).data()!);
      int newXpTotal = updatedProfile.xp;
      int newLevel = updatedProfile.level;

      int xpAtCurrentLevelStart = (newLevel - 1) * AppConstants.xpPerLevel;

      while (newXpTotal >= xpAtCurrentLevelStart + AppConstants.xpPerLevel) {
        newLevel++;
        xpAtCurrentLevelStart = (newLevel - 1) * AppConstants.xpPerLevel;
      }

      if (newLevel > userProfile.level) {
        // Optionally play level up sound or show notification
        debugPrint('User ${user.uid} leveled up to $newLevel!');
      }
      // Only update level if it has actually changed to avoid unnecessary writes
      if (newLevel != userProfile.level) {
        await userRef.update({'level': newLevel});
      }
    }
  }

  Future<void> createUserProfile(String uid, String username, {String? email, String? educationLevel, String? specialty, String? language}) async {
    final userProfile = UserProfile(
      uid: uid,
      username: username,
      email: email ?? '', // Use provided email or default
      createdAt: DateTime.now(),
      lastLoginDate: DateTime.now(),
      educationLevel: educationLevel, // Set from registration if provided
      specialty: specialty, // Set from registration if provided
      language: language, // Set from registration if provided
      currentStreak: 1, // Start new users with a 1-day streak
      xp: AppConstants.initialXp,
      level: 1,
      avatarAssetPath: AppConstants.defaultAvatarAssets.first.assetPath,
      earnedBadges: const [],
      friends: const [],
    );
    try {
      await _firestore.collection(AppConstants.usersCollection).doc(uid).set(userProfile.toMap());
    } catch (e) {
      throw Exception('Error creating user profile: $e');
    }
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection(AppConstants.usersCollection).doc(uid).get();
      if (doc.exists) {
        return UserProfile.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Error getting user profile: $e');
    }
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection(AppConstants.usersCollection).doc(uid).update(updates);
    } catch (e) {
      throw Exception('Error updating user profile: $e');
    }
  }

  Stream<UserProfile?> streamUserProfile(String uid) {
    return _firestore
        .collection(AppConstants.usersCollection)
        .doc(uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return UserProfile.fromMap(snapshot.data()!);
      }
      return null;
    }).handleError((e) {
      debugPrint('Error streaming user profile for $uid: $e');
      return null;
    });
  }

  Future<void> addXp(String userId, int amount) async {
    try {
      final userRef = _firestore.collection(AppConstants.usersCollection).doc(userId);
      await _firestore.runTransaction((transaction) async {
        final userDoc = await transaction.get(userRef);
        if (!userDoc.exists) {
          throw Exception("User does not exist to add XP!");
        }

        UserProfile userProfile = UserProfile.fromMap(userDoc.data()!);
        int newXpTotal = userProfile.xp + amount;
        int newLevel = userProfile.level;

        int xpAtCurrentLevelStart = (newLevel - 1) * AppConstants.xpPerLevel;

        while (newXpTotal >= xpAtCurrentLevelStart + AppConstants.xpPerLevel) {
          newLevel++;
          xpAtCurrentLevelStart = (newLevel - 1) * AppConstants.xpPerLevel;
        }

        transaction.update(userRef, {
          'xp': newXpTotal,
          'level': newLevel,
        });
      });
    } catch (e) {
      throw Exception('Error adding XP to user: $e');
    }
  }

  Future<void> saveCourse(Course course) async {
    try {
      await _firestore.collection(AppConstants.coursesCollection).doc(course.id).set(course.toMap());
    } catch (e) {
      throw Exception('Error saving course: $e');
    }
  }

  Future<void> updateCourse(String courseId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection(AppConstants.coursesCollection).doc(courseId).update(updates);
    } catch (e) {
      throw Exception('Error updating course: $e');
    }
  }

  Future<Course?> getCourse(String courseId) async {
    try {
      final doc = await _firestore.collection(AppConstants.coursesCollection).doc(courseId).get();
      if (doc.exists) {
        return Course.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Error getting course: $e');
    }
  }

  Future<void> deleteCourse(String courseId, List<String> levelIds) async {
    try {
      final batch = _firestore.batch();

      for (final levelId in levelIds) {
        final levelRef = _firestore.collection(AppConstants.levelsCollection).doc(levelId);
        final lessonsSnapshot = await levelRef.collection('lessons').get();
        for (final lessonDoc in lessonsSnapshot.docs) {
          final lessonRef = lessonDoc.reference;
          final questionsSnapshot = await lessonRef.collection('questions').get();
          for (final questionDoc in questionsSnapshot.docs) {
            batch.delete(questionDoc.reference);
          }
          batch.delete(lessonRef);
        }
        batch.delete(levelRef);
      }

      final userProgressQuery = await _firestore
          .collection(AppConstants.userProgressCollection)
          .where('courseId', isEqualTo: courseId)
          .get();
      for (final doc in userProgressQuery.docs) {
        batch.delete(doc.reference);
      }

      final courseRef = _firestore.collection(AppConstants.coursesCollection).doc(courseId);
      batch.delete(courseRef);

      await batch.commit();
    } catch (e) {
      throw Exception('Error deleting course $courseId: $e');
    }
  }

  Stream<List<Course>> streamAllCourses() {
    return _firestore.collection(AppConstants.coursesCollection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Course.fromMap(doc.data()!)).toList();
    }).handleError((e) {
      debugPrint('Error streaming all courses: $e');
      return <Course>[];
    });
  }

  Future<void> saveLevel(Level level, List<Lesson> lessons, Map<String, List<Question>> questionsPerLesson) async {
    try {
      final levelRef = _firestore.collection(AppConstants.levelsCollection).doc(level.id);
      await levelRef.set(level.toMap());

      for (final lesson in lessons) {
        final lessonRef = levelRef.collection('lessons').doc(lesson.id);
        await lessonRef.set(lesson.toMap());
        for (final question in questionsPerLesson[lesson.id]!) {
          await lessonRef.collection('questions').doc(question.id).set(question.toMap());
        }
      }
    } catch (e) {
      throw Exception('Error saving level, lessons, and questions: $e');
    }
  }

  Future<void> saveLevels(
    List<Level> levels,
    Map<String, List<Lesson>> lessonsPerLevel,
    Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel,
  ) async {
    final batch = _firestore.batch();
    try {
      for (final level in levels) {
        final levelRef = _firestore.collection(AppConstants.levelsCollection).doc(level.id);
        batch.set(levelRef, level.toMap());

        if (lessonsPerLevel.containsKey(level.id)) {
          for (final lesson in lessonsPerLevel[level.id]!) {
            final lessonRef = levelRef.collection('lessons').doc(lesson.id);
            batch.set(lessonRef, lesson.toMap());

            if (questionsPerLessonPerLevel.containsKey(level.id) &&
                questionsPerLessonPerLevel[level.id]!.containsKey(lesson.id)) {
              for (final question in questionsPerLessonPerLevel[level.id]![lesson.id]!) {
                batch.set(lessonRef.collection('questions').doc(question.id), question.toMap());
              }
            }
          }
        }
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Error saving multiple levels, lessons, and questions: $e');
    }
  }

  Future<Level?> getLevel(String levelId) async {
    try {
      final doc = await _firestore.collection(AppConstants.levelsCollection).doc(levelId).get();
      if (doc.exists) {
        return Level.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Error getting level: $e');
    }
  }

  Stream<List<Level>> streamLevelsForCourse(String courseId) {
    return _firestore
        .collection(AppConstants.levelsCollection)
        .where('courseId', isEqualTo: courseId)
        .orderBy('order')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Level.fromMap(doc.data()!)).toList();
    }).handleError((e) {
      debugPrint('Error streaming levels for course $courseId: $e');
      return <Level>[];
    });
  }

  Future<Lesson?> getLesson(String levelId, String lessonId) async {
    try {
      final doc = await _firestore.collection(AppConstants.levelsCollection).doc(levelId).collection('lessons').doc(lessonId).get();
      if (doc.exists) {
        return Lesson.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Error getting lesson: $e');
    }
  }

  Future<List<Question>> getLessonQuestions(String levelId, String lessonId) async {
    try {
      final querySnapshot = await _firestore
          .collection(AppConstants.levelsCollection)
          .doc(levelId)
          .collection('lessons')
          .doc(lessonId)
          .collection('questions')
          .get();

      return querySnapshot.docs.map((doc) => Question.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Error getting lesson questions for lesson $lessonId in level $levelId: $e');
    }
  }

  Future<void> saveUserProgress(UserProgress progress) async {
    try {
      await _firestore.collection(AppConstants.userProgressCollection).doc(progress.id).set(progress.toMap(), SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error saving user progress: $e');
    }
  }

  Future<UserProgress?> getUserCourseProgress(String userId, String courseId) async {
    try {
      final String progressId = '${userId}_$courseId';
      final doc = await _firestore.collection(AppConstants.userProgressCollection).doc(progressId).get();
      if (doc.exists) {
        return UserProgress.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Error getting user course progress: $e');
    }
  }

  Stream<UserProgress?> streamUserCourseProgress(String userId, String courseId) {
    final String progressId = '${userId}_$courseId';
    return _firestore
        .collection(AppConstants.userProgressCollection)
        .doc(progressId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return UserProgress.fromMap(snapshot.data()!);
      }
      return null;
    }).handleError((e) {
      debugPrint('Error streaming user course progress for $progressId: $e');
      return null;
    });
  }

  Future<void> addEarnedBadge(String userId, Badge badge) async {
    try {
      final userRef = _firestore.collection(AppConstants.usersCollection).doc(userId);
      await userRef.update({
        'earnedBadges': FieldValue.arrayUnion([badge.id]),
      });
    } catch (e) {
      throw Exception('Error adding earned badge: $e');
    }
  }

  Future<Badge?> getBadge(String badgeId) async {
    try {
      final doc = await _firestore.collection(AppConstants.badgesCollection).doc(badgeId).get();
      if (doc.exists) {
        return Badge.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Error getting badge: $e');
    }
  }

  Stream<List<UserProfile>> streamLeaderboard() {
    // Ordering by XP descending to get top users.
    // If you need to paginate or filter, that would be added here.
    return _firestore
        .collection(AppConstants.usersCollection)
        .orderBy('xp', descending: true)
        .limit(AppConstants.leaderboardLimit)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => UserProfile.fromMap(doc.data()!)).toList();
    }).handleError((e) {
      debugPrint('Error streaming leaderboard: $e');
      return <UserProfile>[];
    });
  }

  Future<void> createCommunityPost(CommunityPost post) async {
    try {
      await _firestore.collection(AppConstants.communityPostsCollection).doc(post.id).set(post.toMap());
    } catch (e) {
      throw Exception('Error creating community post: $e');
    }
  }

  Stream<List<CommunityPost>> streamCommunityPosts() {
    return _firestore
        .collection(AppConstants.communityPostsCollection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => CommunityPost.fromMap(doc.data()!)).toList();
    }).handleError((e) {
      debugPrint('Error streaming community posts: $e');
      return <CommunityPost>[];
    });
  }

  Future<void> addCommentToPost(String postId, Comment comment) async {
    try {
      final postRef = _firestore.collection(AppConstants.communityPostsCollection).doc(postId);
      await postRef.update({
        'comments': FieldValue.arrayUnion([comment.toMap()]),
      });
    } catch (e) {
      throw Exception('Error adding comment to post: $e');
    }
  }

  Future<void> toggleLikeOnPost(String postId, String userId) async {
    try {
      final postRef = _firestore.collection(AppConstants.communityPostsCollection).doc(postId);
      await _firestore.runTransaction((transaction) async {
        final postSnapshot = await transaction.get(postRef);
        if (!postSnapshot.exists) {
          throw Exception("Post does not exist!");
        }
        final post = CommunityPost.fromMap(postSnapshot.data()!);
        List<String> likedBy = List<String>.from(post.likedBy);

        if (likedBy.contains(userId)) {
          likedBy.remove(userId);
        } else {
          likedBy.add(userId);
        }

        transaction.update(postRef, {'likedBy': likedBy});
      });
    } catch (e) {
      throw Exception('Error toggling like on post: $e');
    }
  }

  Future<void> addFriend(String currentUserId, String friendId) async {
    try {
      final currentUserRef = _firestore.collection(AppConstants.usersCollection).doc(currentUserId);
      final friendUserRef = _firestore.collection(AppConstants.usersCollection).doc(friendId);

      await _firestore.runTransaction((transaction) async {
        final currentUserDoc = await transaction.get(currentUserRef);
        final friendUserDoc = await transaction.get(friendUserRef);

        if (!currentUserDoc.exists || !friendUserDoc.exists) {
          throw Exception("One or both users do not exist.");
        }

        UserProfile currentUserProfile = UserProfile.fromMap(currentUserDoc.data()!);
        UserProfile friendUserProfile = UserProfile.fromMap(friendUserDoc.data()!);

        List<String> currentUserFriends = List<String>.from(currentUserProfile.friends);
        List<String> friendUserFriends = List<String>.from(friendUserProfile.friends);

        if (!currentUserFriends.contains(friendId)) {
          currentUserFriends.add(friendId);
          transaction.update(currentUserRef, {'friends': currentUserFriends});
        }

        if (!friendUserFriends.contains(currentUserId)) {
          friendUserFriends.add(currentUserId);
          transaction.update(friendUserRef, {'friends': friendUserFriends});
        }
      });
    } catch (e) {
      throw Exception('Error adding friend: $e');
    }
  }

  Future<void> removeFriend(String currentUserId, String friendId) async {
    try {
      final currentUserRef = _firestore.collection(AppConstants.usersCollection).doc(currentUserId);
      final friendUserRef = _firestore.collection(AppConstants.usersCollection).doc(friendId);

      await _firestore.runTransaction((transaction) async {
        final currentUserDoc = await transaction.get(currentUserRef);
        final friendUserDoc = await transaction.get(friendUserRef);

        if (!currentUserDoc.exists || !friendUserDoc.exists) {
          throw Exception("One or both users do not exist.");
        }

        UserProfile currentUserProfile = UserProfile.fromMap(currentUserDoc.data()!);
        UserProfile friendUserProfile = UserProfile.fromMap(friendUserDoc.data()!);

        List<String> currentUserFriends = List<String>.from(currentUserProfile.friends);
        List<String> friendUserFriends = List<String>.from(friendUserProfile.friends);

        if (currentUserFriends.contains(friendId)) {
          currentUserFriends.remove(friendId);
          transaction.update(currentUserRef, {'friends': currentUserFriends});
        }

        if (friendUserFriends.contains(currentUserId)) {
          friendUserFriends.remove(currentUserId);
          transaction.update(friendUserRef, {'friends': friendUserFriends});
        }
      });
    } catch (e) {
      throw Exception('Error removing friend: $e');
    }
  }

  Future<void> sendChatMessage(ChatMessage message) async {
    try {
      await _firestore.collection(AppConstants.chatMessagesCollection).add(message.toMap());
    } catch (e) {
      throw Exception('Error sending chat message: $e');
    }
  }

  Stream<List<ChatMessage>> streamChatMessages() {
    return _firestore
        .collection(AppConstants.chatMessagesCollection)
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ChatMessage.fromMap(doc.data())).toList();
    }).handleError((e) {
      debugPrint('Error streaming chat messages: $e');
      return <ChatMessage>[];
    });
  }
}
