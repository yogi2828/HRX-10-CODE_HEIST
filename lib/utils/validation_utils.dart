import 'package:flutter/material.dart';

class ValidationUtils {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty.';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty.';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters long.';
    }
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty.';
    }
    return null;
  }

  static String? validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty.';
    }
    return null;
  }

  // Adjusted to accept dynamic for correctAnswerData, and convert to String safely
  static bool validateAnswer(String userAnswer, String questionType, dynamic correctAnswerData) {
    // Ensure correctAnswerData is not null before calling toString()
    final String correctAnswerString = correctAnswerData?.toString().trim().toLowerCase() ?? '';
    final String userLower = userAnswer.trim().toLowerCase();

    switch (questionType) {
      case 'MCQ':
      case 'FillInBlank':
        // For MCQ and FillInBlank, direct comparison after trimming and lowercasing
        return userLower == correctAnswerString;
      case 'ShortAnswer':
      case 'Scenario':
        // For ShortAnswer and Scenario, check if any of the comma-separated keywords are contained in the user's answer
        List<String> keywords = correctAnswerString.split(',').map((e) => e.trim().toLowerCase()).toList();
        return keywords.any((keyword) => userLower.contains(keyword));
      default:
        debugPrint('Unsupported question type for validation: $questionType');
        return false;
    }
  }
}
