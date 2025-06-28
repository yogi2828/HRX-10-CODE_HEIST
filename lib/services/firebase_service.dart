// lib/services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Badge; // Hide Flutter's Badge
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/course.dart';
import 'package:gamifier/models/level.dart';
import 'package:gamifier/models/lesson.dart';
import 'package:gamifier/models/question.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/models/user_progress.dart';
import 'package:gamifier/models/badge.dart'; // Our custom Badge model
import 'package:gamifier/models/community_post.dart';
import 'package:gamifier/models/daily_mission.dart'; // New: DailyMission model

class FirebaseService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.message}');
      return null;
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.message}');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> createUserProfile(String uid, String username) async {
    final userProfile = UserProfile(
      uid: uid,
      username: username,
      createdAt: DateTime.now(),
    );
    await _firestore.collection(AppConstants.usersCollection).doc(uid).set(userProfile.toMap());
  }

  Stream<UserProfile?> streamUserProfile(String uid) {
    return _firestore.collection(AppConstants.usersCollection).doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserProfile.fromMap(snapshot.data()!);
      }
      return null;
    });
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    await _firestore.collection(AppConstants.usersCollection).doc(userProfile.uid).update(userProfile.toMap());
  }

  Future<void> addXp(String uid, int amount) async {
    final userDocRef = _firestore.collection(AppConstants.usersCollection).doc(uid);
    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDocRef);
      if (!snapshot.exists) return;

      final currentXp = (snapshot.data()?['xp'] ?? 0) as int;
      final currentLevel = (snapshot.data()?['level'] ?? 1) as int;
      int newXp = currentXp + amount;
      int newLevel = currentLevel;

      // Calculate next level threshold
      int nextLevelXpThreshold = currentLevel * AppConstants.xpPerLevel;

      // Handle multiple level ups if enough XP is gained
      while (newXp >= nextLevelXpThreshold) {
        newLevel++;
        newXp -= nextLevelXpThreshold; // Deduct XP needed for the level
        nextLevelXpThreshold = newLevel * AppConstants.xpPerLevel; // Update threshold for next potential level
      }


      transaction.update(userDocRef, {
        'xp': newXp,
        'level': newLevel,
      });
    });
  }

  Future<void> updateStreak(String uid) async {
    final userDocRef = _firestore.collection(AppConstants.usersCollection).doc(uid);
    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDocRef);
      if (!snapshot.exists) return;

      final lastUpdate = (snapshot.data()?['lastStreakUpdate'] as Timestamp?)?.toDate();
      final currentStreak = (snapshot.data()?['currentStreak'] ?? 0) as int;
      final now = DateTime.now();

      int newStreak = currentStreak;
      // If last update was yesterday, continue streak
      // If last update was older than yesterday, reset streak
      // If last update is today, do nothing (already updated)
      if (lastUpdate == null || now.difference(lastUpdate).inDays > 1) {
        newStreak = 1; // Reset or start new streak
      } else if (now.difference(lastUpdate).inDays == 1) {
        newStreak++; // Continue streak
      }
      // If it's the same day, don't update streak or timestamp,
      // as it means the streak for today has already been counted.

      transaction.update(userDocRef, {
        'currentStreak': newStreak,
        'lastStreakUpdate': Timestamp.fromDate(now),
      });
    });
  }

  Future<void> addEarnedBadge(String uid, String badgeId) async {
    await _firestore.collection(AppConstants.usersCollection).doc(uid).update({
      'earnedBadges': FieldValue.arrayUnion([badgeId]),
    });
  }

  Future<List<Course>> getCourses() async {
    final snapshot = await _firestore.collection(AppConstants.coursesCollection).get();
    return snapshot.docs.map((doc) => Course.fromMap(doc.data())).toList();
  }

  Future<Course?> getCourse(String courseId) async {
    final snapshot = await _firestore.collection(AppConstants.coursesCollection).doc(courseId).get();
    if (snapshot.exists) {
      return Course.fromMap(snapshot.data()!);
    }
    return null;
  }

  Future<void> addCourse(Course course) async {
    await _firestore.collection(AppConstants.coursesCollection).doc(course.id).set(course.toMap());
  }

  Future<void> updateCourse(Course course) async {
    await _firestore.collection(AppConstants.coursesCollection).doc(course.id).update(course.toMap());
  }

  Future<List<Level>> getLevelsForCourse(String courseId) async {
    final snapshot = await _firestore.collection(AppConstants.levelsCollection)
        .where('courseId', isEqualTo: courseId)
        .orderBy('order') // Order by 'order' field
        .get();
    return snapshot.docs.map((doc) => Level.fromMap(doc.data())).toList();
  }

  Future<Level?> getLevel(String levelId) async {
    final snapshot = await _firestore.collection(AppConstants.levelsCollection).doc(levelId).get();
    if (snapshot.exists) {
      return Level.fromMap(snapshot.data()!);
    }
    return null;
  }

  Future<void> addLevel(Level level) async {
    await _firestore.collection(AppConstants.levelsCollection).doc(level.id).set(level.toMap());
  }

  Future<void> updateLevel(Level level) async {
    await _firestore.collection(AppConstants.levelsCollection).doc(level.id).update(level.toMap());
  }

  Future<List<Lesson>> getLessonsForLevel(String levelId) async {
    final snapshot = await _firestore.collection(AppConstants.lessonsCollection)
        .where('levelId', isEqualTo: levelId) // Assuming lesson has levelId field
        .get();
    return snapshot.docs.map((doc) => Lesson.fromMap(doc.data())).toList();
  }

  Future<Lesson?> getLesson(String lessonId) async {
    final snapshot = await _firestore.collection(AppConstants.lessonsCollection).doc(lessonId).get();
    if (snapshot.exists) {
      return Lesson.fromMap(snapshot.data()!);
    }
    return null;
  }

  Future<void> addLesson(Lesson lesson) async {
    await _firestore.collection(AppConstants.lessonsCollection).doc(lesson.id).set(lesson.toMap());
  }

  Future<void> updateLesson(Lesson lesson) async {
    await _firestore.collection(AppConstants.lessonsCollection).doc(lesson.id).update(lesson.toMap());
  }

  Future<List<Question>> getQuestionsForLesson(String lessonId) async {
    final snapshot = await _firestore.collection(AppConstants.lessonsCollection).doc(lessonId).collection('questions').get();
    return snapshot.docs.map((doc) => Question.fromMap(doc.data())).toList();
  }

  Future<Question?> getQuestion(String lessonId, String questionId) async {
    final snapshot = await _firestore.collection(AppConstants.lessonsCollection).doc(lessonId).collection('questions').doc(questionId).get();
    if (snapshot.exists) {
      return Question.fromMap(snapshot.data()!);
    }
    return null;
  }

  Future<void> addQuestion(String lessonId, Question question) async {
    await _firestore.collection(AppConstants.lessonsCollection).doc(lessonId).collection('questions').doc(question.id).set(question.toMap());
  }

  Future<void> updateQuestion(String lessonId, Question question) async {
    await _firestore.collection(AppConstants.lessonsCollection).doc(lessonId).collection('questions').doc(question.id).update(question.toMap());
  }

  Stream<UserProgress?> streamUserProgress(String userId, String courseId) {
    return _firestore.collection(AppConstants.userProgressCollection)
        .where('userId', isEqualTo: userId)
        .where('courseId', isEqualTo: courseId)
        .limit(1)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            return UserProgress.fromMap(snapshot.docs.first.data());
          }
          return null;
        });
  }
  
  // New method to stream all user progress for a given user
  Stream<List<UserProgress>> streamAllUserProgressForUser(String userId) {
    return _firestore.collection(AppConstants.userProgressCollection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => UserProgress.fromMap(doc.data())).toList());
  }

  Future<void> saveUserProgress(UserProgress progress) async {
    await _firestore.collection(AppConstants.userProgressCollection).doc(progress.id).set(progress.toMap());
  }

  Future<void> updateUserProgress(UserProgress progress) async {
    await _firestore.collection(AppConstants.userProgressCollection).doc(progress.id).update(progress.toMap());
  }

  Future<List<Badge>> getAllBadges() async {
    final snapshot = await _firestore.collection(AppConstants.badgesCollection).get();
    return snapshot.docs.map((doc) => Badge.fromMap(doc.data())).toList();
  }

  Future<void> addBadge(Badge badge) async {
    await _firestore.collection(AppConstants.badgesCollection).doc(badge.id).set(badge.toMap());
  }

  Future<List<UserProfile>> getLeaderboard() async {
    final snapshot = await _firestore.collection(AppConstants.usersCollection)
        .orderBy('xp', descending: true)
        .limit(AppConstants.leaderboardLimit)
        .get();
    return snapshot.docs.map((doc) => UserProfile.fromMap(doc.data())).toList();
  }

  Future<void> addCommunityPost(CommunityPost post) async {
    await _firestore.collection(AppConstants.communityPostsCollection).doc(post.id).set(post.toMap());
  }

  Stream<List<CommunityPost>> streamCommunityPosts() {
    return _firestore.collection(AppConstants.communityPostsCollection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => CommunityPost.fromMap(doc.data())).toList());
  }

  Future<void> likeCommunityPost(String postId, String userId) async {
    await _firestore.collection(AppConstants.communityPostsCollection).doc(postId).update({
      'likedBy': FieldValue.arrayUnion([userId]),
    });
  }

  Future<void> unlikeCommunityPost(String postId, String userId) async {
    await _firestore.collection(AppConstants.communityPostsCollection).doc(postId).update({
      'likedBy': FieldValue.arrayRemove([userId]),
    });
  }

  Future<void> addCommentToPost(String postId, Comment comment) async {
    await _firestore.collection(AppConstants.communityPostsCollection).doc(postId).update({
      'comments': FieldValue.arrayUnion([comment.toMap()]),
    });
  }

  // New: Daily Missions
  Future<List<DailyMission>> getDailyMissions() async {
    // In a real app, this would fetch from Firestore or generate based on user data
    // For now, return some hardcoded missions
    return [
      DailyMission(id: 'mission1', title: 'Complete 3 new questions', description: 'Answer 3 questions you haven\'t seen before.', xpReward: 25, isCompleted: false),
      DailyMission(id: 'mission2', title: 'Review a completed lesson', description: 'Revisit a lesson you\'ve already finished.', xpReward: 15, isCompleted: false),
      DailyMission(id: 'mission3', title: 'Like 5 community posts', description: 'Engage with the community and show some love.', xpReward: 10, isCompleted: false),
      DailyMission(id: 'mission4', title: 'Create a new lesson outline', description: 'Use the AI to generate a new lesson.', xpReward: 30, isCompleted: false),
    ];
  }

  Future<void> completeDailyMission(String userId, String missionId, int xpReward) async {
    // Query for the UserProgress document for the specific user
    final userProgressQuery = _firestore.collection(AppConstants.userProgressCollection).where('userId', isEqualTo: userId).limit(1);
    final userProfileRef = _firestore.collection(AppConstants.usersCollection).doc(userId);

    await _firestore.runTransaction((transaction) async {
      // Execute the query to get the QuerySnapshot
      final progressQuerySnapshot = await userProgressQuery.get(); // Corrected: get QuerySnapshot outside transaction

      if (progressQuerySnapshot.docs.isNotEmpty) {
        final progressDocRef = progressQuerySnapshot.docs.first.reference; // Get DocumentReference
        final progressDocSnapshot = await transaction.get(progressDocRef); // Get DocumentSnapshot within transaction

        if (progressDocSnapshot.exists) {
          final userProgress = UserProgress.fromMap(progressDocSnapshot.data()!);

          // Check if the mission is already completed
          if (!userProgress.dailyMissionsCompleted.contains(missionId)) {
            // Add mission to completed list
            final updatedDailyMissions = List<String>.from(userProgress.dailyMissionsCompleted)..add(missionId);
            transaction.update(progressDocRef, {'dailyMissionsCompleted': updatedDailyMissions});

            // Also add XP to user profile
            final userProfileSnapshot = await transaction.get(userProfileRef);
            if (userProfileSnapshot.exists) {
              final currentUserXp = (userProfileSnapshot.data()?['xp'] ?? 0) as int;
              final currentLevel = (userProfileSnapshot.data()?['level'] ?? 1) as int;
              int newXp = currentUserXp + xpReward;
              int newLevel = currentLevel;

              // Handle multiple level ups if enough XP is gained
              int nextLevelXpThreshold = currentLevel * AppConstants.xpPerLevel;
              while (newXp >= nextLevelXpThreshold) {
                newLevel++;
                newXp -= nextLevelXpThreshold;
                nextLevelXpThreshold = newLevel * AppConstants.xpPerLevel;
              }

              transaction.update(userProfileRef, {
                'xp': newXp,
                'level': newLevel,
              });
            }
          }
        }
      } else {
        print('No UserProgress found for userId: $userId');
        // Optionally, create a new UserProgress document if it doesn't exist
        // This might be appropriate if daily missions are independent of a specific course progress.
        // For this scenario, we'll assume progress exists or it's a no-op if not.
      }
    });
  }
}
